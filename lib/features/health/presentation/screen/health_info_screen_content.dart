import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:starter_application/core/common/app_colors.dart';
import 'package:starter_application/core/common/debouncer.dart';
import 'package:starter_application/core/common/style/gaps.dart';
import 'package:starter_application/core/common/validators.dart';
import 'package:starter_application/core/constants/app/app_constants.dart';
import 'package:starter_application/core/navigation/animations/animated_route.dart';
import 'package:starter_application/core/ui/dialogs/show_custom_date_picker.dart';
import 'package:starter_application/core/ui/mansour/button/custom_mansour_button.dart';
import 'package:starter_application/core/ui/snackbars/show_snackbar.dart';
import 'package:starter_application/core/ui/widgets/custom_text_field.dart';
import 'package:starter_application/features/health/presentation/widget/health_dropdown.dart';
import 'package:starter_application/features/health/presentation/widget/health_textfield.dart';
import 'package:starter_application/generated/l10n.dart';

import '../../../../main.dart';
import '../screen/../state_m/provider/health_info_screen_notifier.dart';

class HealthInfoScreenContent extends StatefulWidget {
  @override
  State<HealthInfoScreenContent> createState() =>
      _HealthInfoScreenContentState();
}

class _HealthInfoScreenContentState extends State<HealthInfoScreenContent> {
  late HealthInfoScreenNotifier sn;

  @override
  void initState() {
    super.initState();
  }

  TextEditingController? controllerWeight = TextEditingController();
  TextEditingController? controllerHeight = TextEditingController();
  final _debouncerWeight = Debouncer(milliseconds: 900);
  final _debouncerHeight = Debouncer(milliseconds: 900);
  @override
  Widget build(BuildContext context) {
    sn = Provider.of<HealthInfoScreenNotifier>(context);
    sn.context = context;
    return SingleChildScrollView(
      padding: AppConstants.screenPadding,
      child: Column(
        children: [
          Gaps.vGap128,
          _buildGenderDropDown(),
          Gaps.vGap64,
          _buildDatePicker(),
          Form(
              key: sn.formkey,
              child: Column(
                children: [
                  Gaps.vGap64,
                  _buildAnimation(
                    num: 2,
                    child: HealthTextField(
                      hint: Translation.current.enter_your_weight + " - " +"[ 30  -  300]" + "",
                      suffix: "kg",
                      controller: controllerWeight,
                      onChange: (value) {
                        sn.weight = 0.0;
                        _debouncerWeight.run(() {
                          if (value.isEmpty) {
                            controllerWeight!.clear();
                          } else {
                            if ((double.tryParse(value)??0)  >= 30 && (double.tryParse(value)??0)  <= 300) {
                              sn.weight = double.parse(value);
                            }
                            else {
                              showSnackbar(Translation.current.The_weight_must_be_real_not_imaginary + " - " +"[ 30  -  300]" + "");
                            }
                          }
                          sn.formkey.currentState!.validate();
                        });

                      },
                      validator: (value) {
                        if ((double.tryParse(value ?? "0")??0)  >= 30 && (double.tryParse(value??"0")??0)  <= 300){
                          return null;
                        }
                        else {
                          return Translation.current.The_weight_must_be_real_not_imaginary + " - " +"[ 30  -  300]" + "";
                        }
                      },
                    ),
                  ),
                  Gaps.vGap64,
                  _buildAnimation(
                    num: 3,
                    child: HealthTextField(
                      hint: Translation.current.enter_your_height + " - "+ "[ 70  -  220]"+ "",
                      suffix: "cm",
                      controller: controllerHeight,
                      onChange: (value) {
                        sn.height = 0.0;
                        _debouncerHeight.run(() {
                          if (value.isEmpty) {
                            controllerHeight!.clear();
                          } else {
                            if ((double.tryParse(value)??0)  >= 70 && (double.tryParse(value)??0)  <= 220) {
                              sn.height = double.parse(value);
                            }
                            else {
                              showSnackbar(Translation.current.The_height_must_be_real_not_imaginary+ " - "+ "[ 70  -  220]"+ "");
                            }
                          }
                          sn.formkey.currentState!.validate();
                        });
                      },
                      validator: (value) {
                        if ((double.tryParse(value ?? "0")??0)  >= 70 && (double.tryParse(value?? "0")??0)  <= 220) {
                          return null;
                        }
                        else {
                          return Translation.current.The_height_must_be_real_not_imaginary+ " - "+ "[ 70  -  220]"+ "";
                        }
                      },
                    ),
                  ),
                  Gaps.vGap64,
                ],
              )),

          _buildMedicalConditionsDropDown(),
          Gaps.vGap96,
          _buildContinueButton(),
        ],
      ),
    );
  }

  Widget _buildAnimation({
    required Widget child,
    required int num,
    double step = 0.1,
  }) {
    final intervalStart = step * num;

    return SlidingAnimated(
      direction: Axis.vertical,
      initialOffset: 5,
      intervalStart: intervalStart,
      intervalEnd: intervalStart + step,
      child: child,
    );
  }

  Widget _buildGenderDropDown() {
    return _buildAnimation(
      num: 0,
      child: HealthDropdown(
        items: [Translation.current.female, Translation.current.male],
        hint: Translation.current.gender,
        onChange: (value) {
          sn.gender = value ?? 0;
          print(sn.gender);
        },
      ),
    );
  }

  Widget _buildMedicalConditionsDropDown() {
    return _buildAnimation(
        num: 4,
        child: HealthDropdown(
          items: [
            Translation.current.healthy,
            Translation.current.very_healthy,
            Translation.current.normal,
          ],
          hint: Translation.current.medical_conditions,
          onChange: (value) {
            sn.healthSituation = value ?? 0;
            print(sn.healthSituation);
          },
        ));
  }

  Widget _buildDropDown({required List<String> items, required String hint}) {
    return HealthDropdown(
      items: items,
      hint: hint,
      onChange: (value) {
        sn.gender = value ?? 0;
        print(sn.gender);
      },
    );
  }

  /* Widget _buildTextField({
    required String hint,
    String? suffix,
  }) {
    return
  }*/

  Widget _buildContinueButton() {
    return _buildAnimation(
      num: 5,
      child: Align(
        alignment: AlignmentDirectional.centerEnd,
        child: CustomMansourButton(
          width: 300.h,
          borderRadius: Radius.circular(
            20.r,
          ),
          titleText: Translation.current.continuee,
          backgroundColor: AppColors.mansourDarkGreenColor,
          onPressed: sn.onContinueTap,
        ),
      ),
    );
  }

  Widget _buildDatePicker() {
    return Container(
      height: 150.h,
      decoration: const BoxDecoration(
        color: AppColors.mansourLightGreyColor,
        borderRadius: const BorderRadius.all(
          Radius.circular(5),
        ),
      ),
      child: Stack(
        children: [
          Container(
            height: 150.h,
            decoration: const BoxDecoration(
              color: AppColors.mansourLightGreyColor,
              borderRadius: const BorderRadius.all(
                Radius.circular(5),
              ),
            ),
            child: CustomTextField(
              keyboardType: TextInputType.none,
              textInputAction: TextInputAction.none,
              enabled: false,
              hintText: '${sn.dateOfBirth}',
            ),
          ),
          GestureDetector(
            onTap: () async {
             sn.onDatePick();
            },
            child: Container(
              height: 150.h,
              color: Colors.transparent,
            ),
          )
        ],
      ),
    );
  }


}
