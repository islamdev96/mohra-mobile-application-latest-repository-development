import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_progress_hud/flutter_progress_hud.dart';
import 'package:provider/provider.dart';
import 'package:starter_application/core/common/app_config.dart';
import 'package:starter_application/core/common/provider/session_data.dart';
import 'package:starter_application/core/errors/app_errors.dart';
import 'package:starter_application/core/navigation/nav.dart';
import 'package:starter_application/core/results/result.dart';
import 'package:starter_application/core/ui/error_ui/error_viewer/error_viewer.dart';
import 'package:starter_application/core/ui/error_ui/errors_screens/error_widget.dart';
import 'package:starter_application/core/ui/widgets/waiting_widget.dart';
import 'package:starter_application/di/service_locator.dart';
import 'package:starter_application/features/account/domain/entity/city_entity.dart';
import 'package:starter_application/features/event/presentation/widget/event_appbar.dart';
import 'package:starter_application/features/event_orginizer/presentation/state_m/cubit/event_orginizer_cubit.dart';
import 'package:starter_application/features/event_orginizer/presentation/widget/event_home_appbar.dart';
import 'package:starter_application/features/user/data/model/request/get_city_params.dart';
import 'package:starter_application/features/user/domain/usecase/get_all_city_usecase.dart';
import 'package:starter_application/generated/l10n.dart';
import '../../../Event Organizer/pages/event_search/event_search.dart';
import '../../../Event Organizer/widgets/home_widgets/side_bar.dart';
import '../screen/../state_m/provider/event_organizer_screen_notifier.dart';
import 'event_organizer_screen_content.dart';

class EventOrganizerScreen extends StatefulWidget {
  static const String routeName = "/EventOrganizerScreen";

  const EventOrganizerScreen({Key? key}) : super(key: key);

  @override
  _EventOrganizerScreenState createState() => _EventOrganizerScreenState();
}

class _EventOrganizerScreenState extends State<EventOrganizerScreen> {
  final sn = EventOrganizerScreenNotifier();

  @override
  void initState() {
    initCities();
    sn.getEvents();
    super.initState();
  }
  initCities()async{
    final results = await Future.wait([
      getIt<GetAllCityUseCase>()(
        GetCityParams(type: 1,maxResultCount: 1000),
      ),
    ]);
    final error = checkError(results);
    if (error != null) {
      Future.wait([
        getIt<GetAllCityUseCase>()(
          GetCityParams(type: 1,maxResultCount: 1000),
        ),
      ]);
    }else{
      late SessionData session =
      Provider.of<SessionData>(AppConfig().appContext, listen: false);
      if(results[0].data is CityListEntity)
        session.cities =  (results[0].data as CityListEntity).items;
    }
  }
  AppErrors? checkError<T>(List<Result<AppErrors, T>> results) {
    for (int i = 0; i < results.length; i++) {
      if (results[i].hasErrorOnly) return results[i].error;
    }
    return null;
  }
  @override
  void dispose() {
    sn.closeNotifier();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return ProgressHUD(
      indicatorWidget: Material(
        color: Colors.transparent,
        child: TextWaitingWidget(
          Translation.current.claiming_rewards,
          textColor: Colors.white,
        ),
      ),
      child: ChangeNotifierProvider<EventOrganizerScreenNotifier>.value(
        value: sn,
        child: MultiBlocListener(
          listeners: [
            BlocListener<EventOrginizerCubit, EventOrginizerState>(
              bloc: sn.eventCubit,
              listener: (context, state) {
                state.mapOrNull(
                  eventOrginizerErrorState:  (value) {
                    sn.loading(false);
                    ErrorViewer.showError(
                      context: context,
                      error: value.error,
                      callback: value.callback,
                    );
                  },
                  eventsLoaded:  (value) {
                    sn.EventsLoaded(value.entity);
                    sn.loading(false);
                  }
                );
              },
            )
          ],
          child: Scaffold(
            key: sn.scaffoldKey,
            drawer: AppDrawer(),
            appBar: EventsHomeAppBar(
              sn: sn,
              isLeading: sn.isSearch,
              controller: sn.search,
              isHasLeading: true,
              title: Padding(
                padding: const EdgeInsets.only(left: 20.0,right: 20,),
                child:  Text(Translation.current.events,style: TextStyle(fontWeight: FontWeight.bold,fontSize: 25,color: Colors.black),),
              ),
              onPress: () {
                sn.change();
                sn.changeSearchBody();
                sn.getEvents();
                setState(() {});
              },
              onSearch: () {
                sn.getEvents();
                sn.change();
              },
              onSubmitted: (String value) {
                sn.getEvents();
                sn.change();
              },
              onClose: () {
                if(sn.isSearchBody||sn.isSearch){
                  sn.changeAll();
                }else {
                  Nav.pop();
                }
              },),
            backgroundColor: Theme.of(context).scaffoldBackgroundColor,
            body: BlocConsumer<EventOrginizerCubit, EventOrginizerState>(
              bloc: sn.eventCubit,
              listener: (context, state) {
                if (state is EventsLoadedState) {
                  sn.onEventsLoaded(state.entity);
                }
              },
              builder: (context, state) {
                return state.maybeMap(
                  eventOrginizerLoadingState: (s) => WaitingWidget(),
                  eventsLoaded: (s) => EventOrganizerScreenContent(),
                  orElse: () => EventOrganizerScreenContent(),
                );
              },
            )
          ),
        ),
      ),
    );
  }
}
