import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:starter_application/core/ui/appbar/appbar.dart';
import 'package:starter_application/features/moment/domain/entity/moment_entity.dart';
import 'package:starter_application/generated/l10n.dart';
import '../screen/../state_m/provider/view_post_interactions_screen_notifier.dart';
import 'view_post_interactions_screen_content.dart';



class ViewPostInteractionsScreen extends StatefulWidget {
  static const String routeName = "/ViewPostInteractionsScreen";
  MomentItemEntity momentItemEntity;
  ViewPostInteractionsScreen({Key? key , required this.momentItemEntity}) : super(key: key);

  @override
  _ViewPostInteractionsScreenState createState() => _ViewPostInteractionsScreenState();
}

class _ViewPostInteractionsScreenState extends State<ViewPostInteractionsScreen> {
  final sn = ViewPostInteractionsScreenNotifier();

  @override
  void initState() {
    sn.momentItemEntity = widget.momentItemEntity;
    sn.getPostInteraction();
    super.initState();
  }

  @override
  void dispose() {
    sn.closeNotifier();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
       return ChangeNotifierProvider<ViewPostInteractionsScreenNotifier>.value(
        value: sn,
        child: Scaffold(
          appBar: buildAppbar(
              title: Translation.current.interactions
          ),
          backgroundColor: Theme.of(context).scaffoldBackgroundColor,
          body: ViewPostInteractionsScreenContent(),
      ),
      );
    }


}
  

 


