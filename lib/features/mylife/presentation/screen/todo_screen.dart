import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:starter_application/core/common/app_colors.dart';
import 'package:starter_application/core/constants/app/app_constants.dart';
import 'package:starter_application/core/navigation/nav.dart';
import 'package:starter_application/generated/l10n.dart';
import '../screen/../state_m/provider/todo_screen_notifier.dart';
import 'todo_screen_content.dart';



class TodoScreen extends StatefulWidget {
  static const String routeName = "/TodoScreen";

  const TodoScreen({Key? key}) : super(key: key);

  @override
  _TodoScreenState createState() => _TodoScreenState();
}

class _TodoScreenState extends State<TodoScreen> {
  final sn = TodoScreenNotifier();

  @override
  void initState() {
    sn.getTask();
    super.initState();
  }

  @override
  void dispose() {
    sn.closeNotifier();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
       return ChangeNotifierProvider<TodoScreenNotifier>.value(
        value: sn,
        child: Scaffold(
          appBar: AppBar(
            backgroundColor: Colors.white,
            elevation:0.0,
            title: Text(
              Translation.current.todo_list,
              style: TextStyle(fontSize: 55.sp,color: AppColors.black_text,fontWeight: FontWeight.bold),
            ),
            leading: InkWell(
                onTap: () {
                  Nav.pop();
                },
                child:  Icon(
                  AppConstants.getIconBack(),
                  color: Colors.black,
                )),
          ),
          backgroundColor:AppColors.mansourLightGreyColor_6,
          body: TodoScreenContent(),
      ),
      );
    }


}
  

 


