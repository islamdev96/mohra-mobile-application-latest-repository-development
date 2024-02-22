import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:starter_application/core/common/app_colors.dart';
import 'package:starter_application/core/constants/app/app_constants.dart';
import 'package:starter_application/core/localization/flutter_localization.dart';
import 'package:starter_application/generated/l10n.dart';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';


class BaseErrorWidget extends StatefulWidget {
  final GestureTapCallback? onTap;
  final String? title;
  final String? subtitle;
  final Widget? icon;
  final Widget? button;

  const BaseErrorWidget({
    Key? key,
    this.onTap,
    this.title,
    this.subtitle,
    this.icon,
    this.button,
  }) : super(key: key);

  @override
  State<BaseErrorWidget> createState() => _BaseErrorWidgetState();
}

class _BaseErrorWidgetState extends State<BaseErrorWidget> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: SizedBox(
        width: 1.0.sw,
        child: InkWell(
          highlightColor: AppColors.mansourBackArrowColor2,
          onTap: widget.onTap,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: <Widget>[
              Padding(
                padding: EdgeInsets.all(0.01),
                child: widget.icon,
              ),
              Text(
                widget.title ?? '',
                style: TextStyle(
                  fontSize: 20,
                  color: AppColors.mansourBackArrowColor2,
                ),
                textAlign: TextAlign.center,
                //       )AppTheme.headline3
              ),
              // Text(
              //   widget.subtitle ?? "",
              //   style: TextStyle(
              //     color: AppColors.primary[100],
              //     fontSize: 20,
              //   ),
              //   //AppTheme.headline4,
              //   textAlign: TextAlign.center,
              // ),
              widget.button ?? Container()
            ],
          ),
        ),
      ),
    );
  }
}

class NoDataWidget extends StatelessWidget {
  final String? message;
  final NoData? noData;
  const NoDataWidget({Key? key, this.message, this.noData}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return BaseErrorWidget(
      onTap: null,
      title: noData?.message ?? message ?? Translation.current.no_data,
      subtitle: '',
      icon: SvgPicture.asset(
        noData?.image ?? AppConstants.no_data,
        height: 0.25.sh,
      ),
    );
  }
}

class AppAssets {
}
class NoData{
  final String? image;
  final String? message;

  NoData({this.image, this.message});
}