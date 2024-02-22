import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_progress_hud/flutter_progress_hud.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';
import 'package:starter_application/core/ui/appbar/appbar.dart';
import 'package:starter_application/features/moment/domain/entity/find_place_result_list_entity.dart';
import 'package:starter_application/features/moment/presentation/state_m/cubit/moment_cubit.dart';
import 'package:starter_application/features/moment/presentation/state_m/provider/select_place_screen_notifier.dart';

import 'select_place_screen_content.dart';

class SelectPlaceScreenParam {
  Function(List<FindPlaceResultEntity> places)? onPlaceSelected;

  SelectPlaceScreenParam({
    this.onPlaceSelected,
  });
}

class SelectPlaceScreen extends StatefulWidget {
  static const String routeName = "/SelectPlaceScreen";
  final SelectPlaceScreenParam param;

  const SelectPlaceScreen({
    Key? key,
    required this.param,
  }) : super(key: key);

  @override
  _SelectPlaceScreenState createState() => _SelectPlaceScreenState();
}

class _SelectPlaceScreenState extends State<SelectPlaceScreen> {
  late final SelectPlaceScreenNotifier sn;

  @override
  void initState() {
    super.initState();
    sn = SelectPlaceScreenNotifier(widget.param);
    sn.getLocation();
  }

  @override
  void dispose() {
    sn.closeNotifier();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ProgressHUD(
      child: ChangeNotifierProvider<SelectPlaceScreenNotifier>.value(
        value: sn,
        child: MultiBlocListener(
          listeners: [
            BlocListener<MomentCubit, MomentState>(
              bloc: sn.findPlaceCubit,
              listener: (context, state) {
                if (state is FindPlaceLoaded) {
                  sn.places = state.results.candidates;
                }
              },
            ),
          ],
          child: Scaffold(
            appBar: buildCustomAppbar(),
            backgroundColor: Theme.of(context).scaffoldBackgroundColor,
            body: SelectPlaceScreenContent(),
          ),
        ),
      ),
    );
  }
}
