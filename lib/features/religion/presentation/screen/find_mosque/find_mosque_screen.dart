import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';
import 'package:starter_application/core/common/style/gaps.dart';
import 'package:starter_application/core/ui/appbar/appbar.dart';
import 'package:starter_application/core/ui/error_ui/errors_screens/error_widget.dart';
import 'package:starter_application/core/ui/widgets/waiting_widget.dart';
import 'package:starter_application/features/religion/presentation/state_m/cubit/religion_cubit.dart';
import 'package:starter_application/features/religion/presentation/state_m/provider/find_mosque_screen_notifier.dart';
import 'package:starter_application/generated/l10n.dart';

import 'find_mosque_screen_content.dart';

class FindMosqueScreen extends StatefulWidget {
  static const String routeName = "/FindMosqueScreen";

  const FindMosqueScreen({Key? key}) : super(key: key);

  @override
  _FindMosqueScreenState createState() => _FindMosqueScreenState();
}

class _FindMosqueScreenState extends State<FindMosqueScreen> {
  final sn = FindMosqueScreenNotifier();

  @override
  void initState() {
    super.initState();
    sn.getLocationAndNearbyMosques();
  }

  @override
  void dispose() {
    sn.closeNotifier();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<FindMosqueScreenNotifier>.value(
      value: sn,
      builder: (context, child) {
        context.watch<FindMosqueScreenNotifier>();
        return Scaffold(
          appBar: buildCustomAppbar(),
          body: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              buildAppbarTitle(
                Translation.current.find_mosque,
                size: TitleSize.medium,
              ),
              Gaps.vGap32,
              Expanded(
                  child: !sn.isLocationReady
                      ? WaitingWidget()
                      : BlocConsumer<ReligionCubit, ReligionState>(
                          bloc: sn.findMosquesCubit,
                          listener: (context, state) {
                            if (state is NearbyMosquesLoaded) {
                              sn.onNearbyMosquesLoaded(
                                  state.nearbyPlacesEntity.results);
                            }
                          },
                          builder: (context, state) {
                            return state.map(
                              religionInitState: (s) => WaitingWidget(),
                              religionLoadingState: (s) => WaitingWidget(),
                              religionErrorState: (s) => ErrorScreenWidget(
                                error: s.error,
                                callback: s.callback,
                              ),
                              prayerTimesLoaded: (s) =>
                                  const ScreenNotImplementedError(),
                              prayerTimesWithPrevNextLoaded: (s) =>
                                  const ScreenNotImplementedError(),
                              nearbyMosquesLoaded: (s) =>
                                  FindMosqueScreenContent(),
                              azkarCategoryLoaded: (_) =>
                                  const ScreenNotImplementedError(),
                            );
                          },
                        )),
            ],
          ),
        );
      },
    );
  }
}
