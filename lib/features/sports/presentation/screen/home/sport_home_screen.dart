import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:provider/provider.dart';
import 'package:starter_application/core/ui/error_ui/errors_screens/error_widget.dart';
import 'package:starter_application/core/ui/widgets/waiting_widget.dart';
import 'package:starter_application/features/sports/presentation/screen/home/sport_home_screen_content.dart';
import 'package:starter_application/features/sports/presentation/state_m/cubit/sports_cubit.dart';
import '../../state_m/provider/sport_home_screen_notifier.dart';

class SportHomeScreen extends StatefulWidget {
  static const String routeName = "/SportHomeScreen";

  const SportHomeScreen({Key? key}) : super(key: key);

  @override
  _SportHomeScreenState createState() => _SportHomeScreenState();
}

class _SportHomeScreenState extends State<SportHomeScreen> {
  final sn = SportHomeScreenNotifier();

  @override
  void initState() {
    super.initState();
    //sn.getLiveScores();
  }

  @override
  void dispose() {
    sn.closeNotifier();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<SportHomeScreenNotifier>.value(
      value: sn,
      builder: (context, child){
        context.watch<SportHomeScreenNotifier>();
        return OrientationBuilder(
            builder: (context, _){
              return Scaffold(
                body: SportHomeScreenContent(),
              );
            }
        );
      },
    );

  }

/*  Widget _buildBody(BuildContext context) {
    return BlocConsumer<SportsCubit, SportsState>(
      bloc: sn.sportCubit,
      listener: (context, state) {
        if (state is LiveScoresLodaed) {
          sn.onMatchesLoaded(
              state.liveScoreEntity);
        }
      },
      builder: (context , state){
        return state.map(
            sportsInitState: (s) => WaitingWidget(),
            sportsLoadingState: (s) => WaitingWidget(),
            matchEventsLoaded:(s)=> const ScreenNotImplementedError(),
            matchlineUpsLoaded: (s)=> const ScreenNotImplementedError(),
            matchStatisticsLoaded: (s)=> const ScreenNotImplementedError(),
            sportsErrorState: (s) => ErrorScreenWidget(
              error: s.error,
              callback: s.callback,
            ),
            liveScoresLodaed: (s) {
              print('');
              print(sn.matches.length);
              return SportHomeScreenContent();
            });
      },
    );
  }*/


}
