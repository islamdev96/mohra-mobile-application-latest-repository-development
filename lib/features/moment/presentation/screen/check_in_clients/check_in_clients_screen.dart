import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';

import 'package:starter_application/core/ui/appbar/appbar.dart';
import 'package:starter_application/core/ui/error_ui/errors_screens/error_widget.dart';
import 'package:starter_application/core/ui/widgets/waiting_widget.dart';
import 'package:starter_application/features/account/presentation/state_m/bloc/account_cubit.dart';
import 'package:starter_application/features/moment/presentation/state_m/provider/check_in_clients_screen_notifier.dart';
import 'package:starter_application/generated/l10n.dart';

import 'check_in_clients_screen_content.dart';

class CheckInClientsScreenParam {
  final LatLng location;
  CheckInClientsScreenParam({
    required this.location,
  });
}

class CheckInClientsScreen extends StatefulWidget {
  final CheckInClientsScreenParam param;
  static const String routeName = "/CheckInClientsScreen";

  const CheckInClientsScreen({
    Key? key,
    required this.param,
  }) : super(key: key);

  @override
  _CheckInClientsScreenState createState() => _CheckInClientsScreenState();
}

class _CheckInClientsScreenState extends State<CheckInClientsScreen> {
  late final CheckInClientsScreenNotifier sn;

  @override
  void initState() {
    super.initState();
    sn = CheckInClientsScreenNotifier(widget.param);
    sn.getClients();
  }

  @override
  void dispose() {
    sn.closeNotifier();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<CheckInClientsScreenNotifier>.value(
      value: sn,
      child: Scaffold(
          appBar:
              buildCustomAppbar(titleText: Translation.current.nearby_people),
          backgroundColor: Theme.of(context).scaffoldBackgroundColor,
          body: BlocConsumer<AccountCubit, AccountState>(
            bloc: sn.accountCubit,
            builder: (context, state) => state.maybeMap(
              accountInit: (value) => CheckInClientsScreenContent(),
              accountLoading: (value) => WaitingWidget(),
              nearbyClientsLoadedState: (value) =>
                  CheckInClientsScreenContent(),
              accountError: (value) => ErrorScreenWidget(
                error: value.error,
                callback: value.callback,
              ),
              orElse: () => const SizedBox.shrink(),
            ),
            listener: (context, state) => state.mapOrNull(
              nearbyClientsLoadedState: (value) {
                sn.clients = value.nearbyClientsEntity.items;
              },
            ),
          )),
    );
  }
}
