import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';
import 'package:starter_application/core/ui/appbar/appbar.dart';
import 'package:starter_application/core/ui/error_ui/errors_screens/error_widget.dart';
import 'package:starter_application/core/ui/widgets/waiting_widget.dart';
import 'package:starter_application/features/account/presentation/state_m/bloc/account_cubit.dart';
import 'package:starter_application/generated/l10n.dart';

import '../screen/../state_m/provider/nearby_clients_screen_notifier.dart';
import 'nearby_clients_screen_content.dart';

class NearbyClientsScreen extends StatefulWidget {
  static const String routeName = "/NearbyClientsScreen";

  const NearbyClientsScreen({Key? key}) : super(key: key);

  @override
  _NearbyClientsScreenState createState() => _NearbyClientsScreenState();
}

class _NearbyClientsScreenState extends State<NearbyClientsScreen> {
  final sn = NearbyClientsScreenNotifier();

  @override
  void initState() {
    super.initState();
    sn.getLocation();
  }

  @override
  void dispose() {
    sn.closeNotifier();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<NearbyClientsScreenNotifier>.value(
      value: sn,
      child: Scaffold(
          appBar:
              buildCustomAppbar(titleText: Translation.current.nearby_people),
          backgroundColor: Theme.of(context).scaffoldBackgroundColor,
          body: BlocConsumer<AccountCubit, AccountState>(
            bloc: sn.accountCubit,
            builder: (context, state) => state.maybeMap(
              accountInit: (value) => NearbyClientsScreenContent(),
              accountLoading: (value) => WaitingWidget(),
              nearbyClientsLoadedState: (value) => NearbyClientsScreenContent(),
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
