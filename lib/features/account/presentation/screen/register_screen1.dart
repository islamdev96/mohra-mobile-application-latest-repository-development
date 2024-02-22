import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:intl/intl.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';
import 'package:provider/provider.dart';
import 'package:starter_application/core/common/app_colors.dart';
import 'package:starter_application/core/common/provider/session_data.dart';
import 'package:starter_application/core/common/style/dimens.dart';
import 'package:starter_application/core/common/style/gaps.dart';
import 'package:starter_application/core/common/utils.dart';
import 'package:starter_application/core/common/validators.dart';
import 'package:starter_application/core/constants/app/app_constants.dart';
import 'package:starter_application/core/navigation/animations/animated_route.dart';
import 'package:starter_application/core/ui/appbar/appbar.dart';
import 'package:starter_application/core/ui/mansour/button/custom_mansour_button.dart';
import 'package:starter_application/core/ui/mansour/custom_list_tile.dart';
import 'package:starter_application/core/ui/widgets/custom_text_field.dart';
import 'package:starter_application/features/account/presentation/state_m/provider/register_screen_1_notifier.dart';
import 'package:starter_application/generated/l10n.dart';
import 'package:url_launcher/url_launcher.dart';
import 'dart:ui' as ui;
import '../../../../main.dart';
import '../state_m/bloc/account_cubit.dart';

class RegisterScreen1 extends StatefulWidget {
  static const routeName = "/RegisterScreen1";

  @override
  _RegisterScreen1State createState() => _RegisterScreen1State();
}

class _RegisterScreen1State extends State<RegisterScreen1> {
  RegisterScreen1Notifier sn = RegisterScreen1Notifier();

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<RegisterScreen1Notifier>.value(
        value: sn,
        builder: (context, _) {
          context.watch<RegisterScreen1Notifier>();
          sn.context = context;
          return Directionality(
            textDirection: isArabic ? ui.TextDirection.rtl :ui.TextDirection.ltr ,
            child: Scaffold(
              backgroundColor: Theme.of(context).scaffoldBackgroundColor,
              appBar: buildAppbar(
                hideBackButton: false,
              ),
              body: Container(
                child: ModalProgressHUD(
                  inAsyncCall: sn.inAsyncCall,
                  child: BlocListener<AccountCubit, AccountState>(
                    bloc: BlocProvider.of<AccountCubit>(context),
                    listener: (context, state) {},
                    child: _buildScreen(),
                  ),
                ),
              ),
            ),
          );
        });
  }

  _buildScreen() {
    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      child: Container(
        child: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: AppConstants.screenPadding.left,
            vertical: Dimens.dp8,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              buildAppbarTitle(
                (isArabic ? " أخ بس لو في منك اثنين في هالعالم، كان الدنيا بخير" :"I wish their was two \n like you in this world")+
                    ' ' +
                    String.fromCharCode(0x1F61C),
                size: TitleSize.medium,
                padding: EdgeInsets.zero,
              ),
              Gaps.vGap128,
              Text(
                isArabic ? "اسمك طال عمرك":"What’s your name",
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 45.sp,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Gaps.vGap64,
              SlidingAnimated(
                initialOffset: 5,
                intervalStart: 0,
                intervalEnd: 0.1,
                child: _buildNameField(),
              ),
              Gaps.vGap32,
              SlidingAnimated(
                initialOffset: 5,
                intervalStart: 0.1,
                intervalEnd: 0.2,
                child: _buildLastNameField(),
              ),
              Gaps.vGap64,
              Text(
                isArabic ? "يوم ميلادك علشان نحتفل فيك" : "Your birthday so we can celebrate it with you"
                    ' ' +
                    String.fromCharCode(0x1F973),
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 45.sp,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Gaps.vGap64,
              SlidingAnimated(
                initialOffset: 5,
                intervalStart: 0.3,
                intervalEnd: 0.4,
                child: Padding(
                  padding: EdgeInsetsDirectional.only(
                    start: 40.w,
                  ),
                  child: CustomListTile(
                    height: 60.h,
                    title: Text(
                      sn.date != null
                          ? DateFormat('yMd').format(sn.date!)
                          :  isArabic ? "تاريخ الميلاد" : "Birth Date",
                      style: TextStyle(
                        color: sn.date != null
                            ? Colors.black
                            : AppColors.mansourNotSelectedBorderColor,
                        fontSize: 40.sp,
                      ),
                    ),
                    trailing: Icon(
                      Icons.arrow_forward_ios_outlined,
                      color: AppColors.mansourBackArrowColor,
                      size: 45.sp,
                    ),
                    onTap: sn.onDatePickerTap,
                  ),
                ),
              ),
              // if (sn.isDateValidate && sn.date == null) Gaps.vGap32,
              // if (sn.isDateValidate && sn.date == null)
              //   Padding(
              //     padding: EdgeInsetsDirectional.only(
              //       start: 40.w,
              //     ),
              //     child: Text(
              //       Translation.of(context).errorEmptyField,
              //       style: TextStyle(
              //         color: Colors.red,
              //         fontSize: 40.sp,
              //       ),
              //     ),
              //   ),
              Gaps.vGap128,
              _buildTermsAndConditions(),
              Gaps.vGap128,
              SlidingAnimated(
                initialOffset: 5,
                intervalStart: 0.4,
                intervalEnd: 0.5,
                child: Text(
                  isArabic ?  "قلي صحيح، انت؟" :  "Are you a ?",
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 45.sp,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              Gaps.vGap32,
              SlidingAnimated(
                initialOffset: 5,
                intervalStart: 0.5,
                intervalEnd: 0.6,
                child: CustomMansourButton(
                  backgroundColor:AppColors.primaryColorLight,
                  titleText: isArabic ? "كيك": "Cake?",
                  textColor: AppColors.lightFontColor,
                  onPressed: () {
                    if (sn.checkBox) sn.moveToNextPage(1);
                  },
                ),
              ),
              Gaps.vGap32,
              SlidingAnimated(
                initialOffset: 5,
                intervalStart: 0.6,
                intervalEnd: 0.7,
                child: CustomMansourButton(
                  titleText: isArabic ? "بسبوسه" : "Basboosh",
                  backgroundColor: Colors.white,
                  borderColor: AppColors.primaryColorLight,
                  textColor: AppColors.primaryColorLight,
                  onPressed: () {
                    if (sn.checkBox) sn.moveToNextPage(0);
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildTermsAndConditions() {
    return Row(
      mainAxisSize: MainAxisSize.max,
      children: [
        Checkbox(
            value: sn.checkBox,
            onChanged: (val) {
              sn.checkBox = val ?? false;
            }),
        Expanded(
          child: Wrap(
            children: [
              Text(
                isArabic ? "اقبل الشروط والأحكام للمتابعة":"Accept the terms and conditions to proceed",
                style: const TextStyle(
                  color: AppColors.accentColorLight,
                ),
              ),
              InkWell(
                onTap: (){
                  launch('https://mohraapp.com/en/privacy-policy');
                },
                child: Text(
                  ' ' + ( isArabic ? "سياسة الخصوصية" : "Privacy Policy") + ' ',
                  style: const TextStyle(
                    color: AppColors.mansourDarkOrange3,
                  ),
                ),
              ),
              Text(
                " | ",
                style: const TextStyle(
                  color: AppColors.accentColorLight,
                ),
              ),
              InkWell(
                onTap: (){
                  launch('https://docs.google.com/document/d/1yuwjEi0qaPRXRk5fW2gtyHYJsu8VtnwnpoL2aoTH1SM/edit');
                },
                child: Text(
                  ' ' + (isArabic ? "شروط الاستخدام" : "Terms Of Use") + ' ',
                  style: const TextStyle(
                    color: AppColors.mansourDarkOrange3,
                  ),
                ),
              ),
            ],
          ),
        )
      ],
    );
  }

  _buildNameField() {
    return CustomTextField(
      primaryFieldColor: AppColors.regularFontColor,
      textKey: sn.nameKey,
      controller: sn.nameController,
      textInputAction: TextInputAction.next,
      keyboardType: TextInputType.text,
      focusNode: sn.myFocusNodeName,
      hintText: isArabic ? "الاسم الأول" : "First Name",
      contentPadding: EdgeInsets.zero,
      horizontalMargin: 40.w,
      validator: (value) {
        if (Validators.isValidName(value!))
          return null;
        else
          return isArabic ?"لا يمكن لهذا الحقل أن يكون فارغا" : "This field mustn't be empty";
      },
      onFieldSubmitted: (term) {
        fieldFocusChange(context, sn.myFocusNodeName, sn.myFocusNodeLastName);
      },
      onChanged: (value) {
        Provider.of<SessionData>(context, listen: false).firstName = value;
        sn.nameKey.currentState!.validate();
      },
    );
  }

  _buildLastNameField() {
    return CustomTextField(
      primaryFieldColor: AppColors.regularFontColor,
      textKey: sn.lastNameKey,
      controller: sn.lastNameController,
      textInputAction: TextInputAction.next,
      keyboardType: TextInputType.text,
      focusNode: sn.myFocusNodeLastName,
      hintText: isArabic ? "الأسم الأخير" : "Last Name",
      contentPadding: EdgeInsets.zero,
      horizontalMargin: 40.w,
      validator: (value) {
        if (Validators.isValidName(value!))
          return null;
        else
          return isArabic ?"لا يمكن لهذا الحقل أن يكون فارغا" : "This field mustn't be empty";
      },
      onFieldSubmitted: (term) {
        sn.myFocusNodeLastName.unfocus();
      },
      onChanged: (value) {
        Provider.of<SessionData>(context, listen: false).lastName = value;

        sn.lastNameKey.currentState!.validate();
      },
    );
  }

  @override
  void dispose() {
    super.dispose();
    sn.closeNotifier();
  }
}
