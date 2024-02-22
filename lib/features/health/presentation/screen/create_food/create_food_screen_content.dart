import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:starter_application/core/common/app_colors.dart';
import 'package:starter_application/core/common/style/gaps.dart';
import 'package:starter_application/core/constants/app/app_constants.dart';
import 'package:starter_application/core/ui/mansour/button/custom_mansour_button.dart';
import 'package:starter_application/features/health/presentation/state_m/provider/create_food_screen_notifier.dart';
import 'package:starter_application/features/health/presentation/widget/health_amount_unit_picker.dart';
import 'package:starter_application/features/moment/presentation/widget/pick_images_grid.dart';

class CreateFoodScreenContent extends StatefulWidget {
  @override
  State<CreateFoodScreenContent> createState() =>
      _CreateFoodScreenContentState();
}

class _CreateFoodScreenContentState extends State<CreateFoodScreenContent> {
  late CreateFoodScreenNotifier sn;
  final border = const UnderlineInputBorder(
    borderSide: BorderSide.none,
  );
  final hintStyle = TextStyle(
    color: AppColors.accentColorLight,
    fontSize: 45.sp,
  );

  @override
  Widget build(BuildContext context) {
    sn = Provider.of<CreateFoodScreenNotifier>(context);

    sn.context = context;
    return LayoutBuilder(builder: (context, cons) {
      return SingleChildScrollView(
        padding: AppConstants.screenPadding,
        child: ConstrainedBox(
          constraints: BoxConstraints(
            minHeight: cons.maxHeight,
          ),
          child: Column(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Gaps.vGap64,
                  _buildImagePickerGridView(),
                  Gaps.vGap64,
                  _buildBasicInformaiton(),
                  Gaps.vGap64,
                  _buildServing(),
                  Gaps.vGap64,
                  _buildServing(),
                  Gaps.vGap64,
                ],
              ),
              Column(
                children: [
                  Align(
                    alignment: AlignmentDirectional.centerEnd,
                    child: CustomMansourButton(
                      width: 350.w,
                      backgroundColor: AppColors.mansourLightGreyColor_3,
                      titleText: "Next",
                    ),
                  ),
                  Gaps.vGap64,
                ],
              ),
            ],
          ),
        ),
      );
    });
  }

  Widget _buildImagePickerGridView() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Upload Image",
          style: TextStyle(
            color: Colors.black,
            fontSize: 45.sp,
            fontWeight: FontWeight.bold,
          ),
        ),
        Gaps.vGap32,
        PickImagesGrid(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          onImagesPicked: sn.onImagesPicked,
          imagesPaths: sn.imagesPaths,
          cameraButtonIcon: AppConstants.SVG_CAMERA_FILL2,
          cameraButtonColor: AppColors.mansourDarkGreenColor3,
          cameraButtonBackgroundColor:
              AppColors.mansourLightGreenColor.withOpacity(
            0.05,
          ),
          onImageDeleted: sn.onImageDeleted,
        ),
      ],
    );
  }

  Widget _buildBasicInformaiton() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildTitleText("BASIC INFORMATIONS"),
        Gaps.vGap32,
        _buildTextField(
          labelText: "Name",
          hintText: "Enter Food Name",
        ),
        Gaps.vGap32,
        _buildTextField(
          labelText: "Brand",
          hintText: "Enter Food Brand",
        ),
        Gaps.vGap32,
        _buildSelectCategoriesRow(),
        Gaps.vGap32,
      ],
    );
  }

  Widget _buildTitleText(String title) {
    return Text(
      title,
      style: TextStyle(
        color: AppColors.mansourLightGreenColor,
        fontSize: 45.sp,
        fontWeight: FontWeight.bold,
      ),
    );
  }

  Widget _buildTextField(
      {required String labelText, required String hintText}) {
    return Row(
      children: [
        Text(
          labelText,
          style: TextStyle(
            color: Colors.black,
            fontSize: 45.sp,
            fontWeight: FontWeight.bold,
          ),
        ),
        Expanded(
          child: TextField(
            textInputAction: TextInputAction.done,
            keyboardType: TextInputType.number,
            focusNode: FocusNode(),
            textAlign: TextAlign.end,
            style: TextStyle(
              color: Colors.black,
              fontSize: 50.sp,
            ),
            decoration: InputDecoration(
              border: border,
              errorBorder: border,
              enabledBorder: border,
              focusedBorder: border,
              disabledBorder: border,
              focusedErrorBorder: border,
              hintStyle: hintStyle,
              hintText: hintText,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildSelectCategoriesRow() {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: () {},
        child: Padding(
          padding: EdgeInsets.symmetric(
            vertical: 20.h,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Categories",
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 45.sp,
                  fontWeight: FontWeight.bold,
                ),
              ),
              Row(
                children: [
                  Text(
                    "Select Categories",
                    style: hintStyle,
                  ),
                  Gaps.hGap15,
                  Icon(
                    Icons.arrow_forward_ios,
                    color: AppColors.mansourBackArrowColor,
                    size: 60.sp,
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildServing() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildTitleText("CONTENT PER SERVINGS"),
        Gaps.vGap32,
        Row(
          children: [
            Text(
              "1 Servings = ",
              style: TextStyle(
                color: Colors.black,
                fontSize: 45.sp,
                fontWeight: FontWeight.bold,
              ),
            ),
            Gaps.hGap12,
            Expanded(
              child: HealthAmountUnitPicker(
                units: [
                  "10",
                  "5",
                  "6",
                ],
                hint: "grams",
                valueFlex: 3,
                unitFlex: 4,
                hintStyle: hintStyle,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(
                    30.r,
                  ),
                  borderSide: BorderSide(
                    color: AppColors.accentColorLight.withOpacity(
                      0.05,
                    ),
                  ),
                ),
                backgroundColor: AppColors.accentColorLight.withOpacity(
                  0.05,
                ),
                dropdownIconColor: AppColors.mansourBackArrowColor,
              ),
            ),
          ],
        ),
      ],
    );
  }
}
