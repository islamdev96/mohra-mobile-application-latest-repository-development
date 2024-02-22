import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:starter_application/core/ui/appbar/appbar.dart';
import '../screen/../state_m/provider/favorite_session_screen_notifier.dart';
import 'favorite_session_screen_content.dart';

class FavoriteSessionScreen extends StatefulWidget {
  static const String routeName = "/FavoriteSessionScreen";

  const FavoriteSessionScreen({Key? key}) : super(key: key);

  @override
  _FavoriteSessionScreenState createState() => _FavoriteSessionScreenState();
}

class _FavoriteSessionScreenState extends State<FavoriteSessionScreen> {
  final sn = FavoriteSessionScreenNotifier();

  @override
  void initState() {
    super.initState();
    sn.getFavoriteSessions();
  }

  @override
  void dispose() {
    sn.closeNotifier();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<FavoriteSessionScreenNotifier>.value(
      value: sn,
      child: Scaffold(
        appBar: buildCustomAppbar(

        ),
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        body: FavoriteSessionScreenContent(),
      ),
    );
  }
}
