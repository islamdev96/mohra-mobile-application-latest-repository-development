import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_progress_hud/flutter_progress_hud.dart';
import 'package:provider/provider.dart';
import 'package:starter_application/core/navigation/nav.dart';
import 'package:starter_application/core/params/screen_params/challenge_details_screen_params.dart';
import 'package:starter_application/core/ui/appbar/appbar.dart';
import 'package:starter_application/core/ui/error_ui/errors_screens/error_widget.dart';
import 'package:starter_application/core/ui/snackbars/show_snackbar.dart';
import 'package:starter_application/core/ui/widgets/waiting_widget.dart';
import 'package:starter_application/features/challenge/presentation/state_m/cubit/challenge_cubit.dart';
import 'package:starter_application/features/challenge/presentation/state_m/provider/challenge_screen_notifier.dart';
import 'package:starter_application/generated/l10n.dart';

import 'challenge_screen_content.dart';

class ChallengeScreen extends StatefulWidget {
  final ChallengeDetailsScreenParams params;

  static const routeName = "/ChallengeScreen";
  ChallengeScreen({Key? key, required this.params}) : super(key: key);

  @override
  _ChallengeScreenState createState() => _ChallengeScreenState();
}

class _ChallengeScreenState extends State<ChallengeScreen> {
  late final ChallengeScreenNotifier sn;

  @override
  void initState() {
    super.initState();
    sn = ChallengeScreenNotifier(widget.params);
    sn.getChallengeDetails(widget.params.challangeItemEntity!.id);
  }

  @override
  void dispose() {
    sn.closeNotifier();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<ChallengeScreenNotifier>.value(
      value: sn,
      builder: (context, _) {
        context.watch<ChallengeScreenNotifier>();
        return ProgressHUD(
          child: Scaffold(
            appBar: buildAppbar(title: Translation.current.challenge),
            body: BlocListener<ChallengeCubit, ChallengeState>(
              bloc: sn.challengeStepsCubit,
              listener: (context, state) {
                state.map(
                  challengeLoadingState: (_) {
                    sn.loading = true;
                    ProgressHUD.of(context)!.show();
                  },
                  challengeInitState: (_) {},
                  challengesSuccess: (_) {},
                  getChallengeSuccess: (_) {},
                  joinOrUnSucess: (_) {
                    sn.loading = false;
                    ProgressHUD.of(context)!.dismiss();
                    if (sn.itemEntity.currentStep == 0) {
                      sn.itemEntity.currentStep = 1;
                    } else {
                      sn.itemEntity.currentStep = 0;
                    }
                    sn.currentStep = 1;
                    sn.getChallengeDetails(
                        widget.params.challangeItemEntity!.id);

                    widget.params.onStepChange
                        ?.call(sn.itemEntity.currentStep!);
                  },
                  joinLoadingState: (_) {
                    ProgressHUD.of(context)!.show();
                    sn.loading = true;
                  },
                  claimRewardsLoadingState: (_) {
                    ProgressHUD.of(context)!.show();
                    sn.loading = true;
                  },
                  claimRewardsSuccess: (_) {
                    ProgressHUD.of(context)!.dismiss();
                    sn.loading = false;
                    sn.itemEntity.currentStep = 4;
                    Nav.pop();
                    showSnackbar(Translation.current.reward_claimed);
                    widget.params.onStepChange
                        ?.call(sn.itemEntity.currentStep!);

                    // sn.getChallengeDetails(widget.params.challangeItemEntity!.id);
                  },
                  challengeErrorState: (_) {
                    ProgressHUD.of(context)!.dismiss();
                    sn.loading = false;
                  },
                  inviteFriendsLoadingState: (_) {
                    ProgressHUD.of(context)!.show();
                    sn.loading = true;
                  },
                  inviteFriendsSuccess: (_) {
                    ProgressHUD.of(context)!.dismiss();
                    sn.loading = false;
                    sn.itemEntity.currentStep = 2;
                    sn.getChallengeDetails(
                        widget.params.challangeItemEntity!.id);
                    widget.params.onStepChange
                        ?.call(sn.itemEntity.currentStep!);
                  },
                );
              },
              child: BlocConsumer<ChallengeCubit, ChallengeState>(
                  bloc: sn.challengeCubit,
                  listener: (context, state) {
                    state.mapOrNull(
                      getChallengeSuccess: (value) {
                        sn.setChallengeDetails(value.item);
                        ProgressHUD.of(context)!.dismiss();
                        sn.loading = false;
                      },
                      challengeErrorState: (_) {
                        ProgressHUD.of(context)!.dismiss();
                        sn.loading = false;
                      },
                    );
                  },
                  builder: (context, state) {
                    return state.maybeMap(
                      orElse: () => const ScreenNotImplementedError(),
                      challengeInitState: (_) => WaitingWidget(),
                      challengeLoadingState: (_) => WaitingWidget(),
                      challengeErrorState: (s) => ErrorScreenWidget(
                        error: s.error,
                        callback: s.callback,
                      ),
                      getChallengeSuccess: (_) => ChallengeScreenContent(
                        item: widget.params.challangeItemEntity!,
                      ),
                    );
                  }),
            ),
          ),
        );
      },
    );
  }
}
