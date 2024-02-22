import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:starter_application/core/ui/appbar/appbar.dart';
import 'package:starter_application/features/moment/domain/entity/moment_entity.dart';
import 'package:starter_application/generated/l10n.dart';
import '../screen/../state_m/provider/view_post_comments_screen_notifier.dart';
import 'view_post_comments_screen_content.dart';



class ViewPostCommentsScreen extends StatefulWidget {
  static const String routeName = "/ViewPostCommentsScreen";
   MomentItemEntity momentItemEntity;
   ViewPostCommentsScreen({Key? key , required this.momentItemEntity}) : super(key: key);

  @override
  _ViewPostCommentsScreenState createState() => _ViewPostCommentsScreenState();
}

class _ViewPostCommentsScreenState extends State<ViewPostCommentsScreen> {
  final sn = ViewPostCommentsScreenNotifier();

  @override
  void initState() {
    sn.momentItemEntity = widget.momentItemEntity;
    sn.getComments();
    super.initState();
  }

  @override
  void dispose() {
    sn.closeNotifier();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
       return ChangeNotifierProvider<ViewPostCommentsScreenNotifier>.value(
        value: sn,
        child: Scaffold(
          appBar: buildAppbar(
              title: Translation.current.comments
          ),
          backgroundColor: Theme.of(context).scaffoldBackgroundColor,
          body: ViewPostCommentsScreenContent(),
      ),
      );
    }


}
  

 


