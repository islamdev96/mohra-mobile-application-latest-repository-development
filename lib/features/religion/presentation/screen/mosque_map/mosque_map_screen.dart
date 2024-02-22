import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:starter_application/core/ui/custom_map/logic/custom_map_model.dart';
import 'package:starter_application/core/ui/widgets/waiting_widget.dart';
import 'package:starter_application/features/religion/presentation/state_m/provider/mosque_map_screen_notifier.dart';

import 'mosque_map_screen_content.dart';

class MosqueMapScreen extends StatefulWidget {
  static const String routeName = "/MosqueMapScreen";
  final MosqueMapScreenParam param;
  const MosqueMapScreen({Key? key, required this.param}) : super(key: key);

  @override
  _MosqueMapScreenState createState() => _MosqueMapScreenState();
}

class _MosqueMapScreenState extends State<MosqueMapScreen> {
  late final MosqueMapScreenNotifier sn;
  final customMapModel = CustomMapModel();

  late final Future<Widget> mapFuture;

  @override
  void initState() {
    super.initState();

    /// Hide status Bar
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.leanBack);
    sn = MosqueMapScreenNotifier(widget.param);

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
        ChangeNotifierProvider<MosqueMapScreenNotifier>.value(
          value: sn,
        ),
        ChangeNotifierProvider.value(
          value: customMapModel,
        ),
      ],
      child: Scaffold(
        body: MosqueMapScreenContent(),
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

    return MosqueMapScreenContent();
  }
}
