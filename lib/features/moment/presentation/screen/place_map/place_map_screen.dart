import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:starter_application/core/common/app_colors.dart';
import 'package:starter_application/core/ui/appbar/appbar.dart';
import 'package:starter_application/core/ui/custom_map/logic/custom_map_model.dart';
import 'package:starter_application/core/ui/widgets/waiting_widget.dart';
import 'package:starter_application/features/moment/presentation/state_m/provider/place_map_screen_notifier.dart';

import 'place_map_screen_content.dart';

class PlaceMapScreen extends StatefulWidget {
  static const String routeName = "/PlaceMapScreen";
  final PlaceMapScreenParam param;
  const PlaceMapScreen({Key? key, required this.param}) : super(key: key);

  @override
  _PlaceMapScreenState createState() => _PlaceMapScreenState();
}

class _PlaceMapScreenState extends State<PlaceMapScreen> {
  late final PlaceMapScreenNotifier sn;
  final customMapModel = CustomMapModel();

  late final Future<Widget> mapFuture;

  @override
  void initState() {
    super.initState();

    /// Hide status Bar
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.leanBack);
    sn = PlaceMapScreenNotifier(widget.param);

    mapFuture = _buildScreenContent();
  }

  @override
  void dispose() {
    sn.closeNotifier();
    customMapModel.dispose();

    /// Show status Bar
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual,
        overlays: SystemUiOverlay.values);

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<PlaceMapScreenNotifier>.value(
          value: sn,
        ),
        ChangeNotifierProvider.value(
          value: customMapModel,
        ),
      ],
      child: Scaffold(
        extendBodyBehindAppBar: true,
        appBar: buildAppbar(
          elevation: 0,
          backgroundColor: AppColors.white.withOpacity(0.4)
        ),
        body: PlaceMapScreenContent(),
      ),
    );
  }

  Widget _buildFutureBuilder() {
    return FutureBuilder<Widget>(
        future: mapFuture,
        builder: (context, AsyncSnapshot<Widget> snapshot) {
          if (snapshot.hasData) {
            return snapshot.data!;
          } else {
            return Scaffold(
              backgroundColor: Colors.red,
              body: WaitingWidget(),
            );
          }
        });
  }

  Future<Widget> _buildScreenContent() async {
    // await sn.setMarkersIcons();

    return PlaceMapScreenContent();
  }
}
