import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:starter_application/core/common/app_colors.dart';
import 'package:starter_application/core/constants/app/app_constants.dart';
import 'package:starter_application/features/event/presentation/widget/event_title_widget.dart';
import 'package:starter_application/generated/l10n.dart';

class EventSeatsWidget extends StatefulWidget {
  const EventSeatsWidget({Key? key}) : super(key: key);

  @override
  _EventSeatsWidgetState createState() => _EventSeatsWidgetState();
}

class _EventSeatsWidgetState extends State<EventSeatsWidget> {
  List<SeatModel> _seats = [];

  @override
  void initState() {
    super.initState();
    _initSeats();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.symmetric(horizontal: 60.w),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              EventTitleWidget(
                title: Translation.of(context).select_seat,
                textColor: AppColors.black_text,
                padding: EdgeInsets.only(bottom: 20.h),
              ),
              Text(
                Translation.of(context).select_available_seats,
                style: const TextStyle(
                  color: AppColors.accentColorLight,
                ),
              ),
              SizedBox(
                height: 60.h,
              ),
              Image.asset(
                AppConstants.IMG_EVENT_ROOF,
                width: 1.sw,
              ),
              SizedBox(
                height: 40.h,
              ),
              GridView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 12,
                    crossAxisSpacing: 30.w,
                    mainAxisSpacing: 30.w,
                    childAspectRatio: 1.2),
                itemBuilder: (context, index) {
                  return _buildSeatWidget(_seats.elementAt(index).type, index);
                },
                itemCount: _seats.length,
              ),
              SizedBox(
                height: 40.h,
              ),
              _buildSeatDemoRow(),
              SizedBox(
                height: 40.h,
              ),
            ],
          ),
        ),
        _buildSelectedSeatsList(),
      ],
    );
  }

  Widget _buildSeatWidget(int type, int index) {
    return GestureDetector(
      onTap: () {
        if (type == 0)
          setState(() {
            _seats.removeAt(index);
            _seats.insertAll(index, [SeatModel(type: 2)]);
          });
        else if (type == 2)
          setState(() {
            _seats.removeAt(index);
            _seats.insertAll(index, [SeatModel(type: 0)]);
          });
      },
      child: Container(
        decoration: BoxDecoration(
            color: type == 0
                ? AppColors.mansourLightGreyColor_15
                : type == 1
                    ? AppColors.black
                    : type == 2
                        ? AppColors.mansourDarkOrange3
                        : AppColors.transparent,
            borderRadius: BorderRadius.only(
              topRight: Radius.circular(20.r),
              topLeft: Radius.circular(20.r),
            )),
      ),
    );
  }

  Widget _buildSeatDemoRow() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        _buildSeatDemoWidget(
            dotColor: AppColors.mansourLightGreyColor_15,
            textColor: AppColors.accentColorLight,
            text: Translation.of(context).available),
        SizedBox(
          width: 40.h,
        ),
        _buildSeatDemoWidget(
            dotColor: AppColors.black,
            textColor: AppColors.black,
            text: Translation.of(context).booked),
        SizedBox(
          width: 40.h,
        ),
        _buildSeatDemoWidget(
            dotColor: AppColors.mansourDarkOrange3,
            textColor: AppColors.mansourDarkOrange3,
            text: Translation.of(context).your_selection),
      ],
    );
  }

  Widget _buildSelectedSeatsList() {
    return SizedBox(
      height: 90.h,
      child: ListView.separated(
          scrollDirection: Axis.horizontal,
          itemBuilder: (context, index) {
            return Padding(
              padding: EdgeInsets.only(
                  right: index ==
                          _seats
                                  .where((element) => element.type == 2)
                                  .toList()
                                  .length -
                              1
                      ? 60.w
                      : 0,
                  left: index == 0 ? 60.w : 0),
              child: _buildSelectedSeatWidget(),
            );
          },
          separatorBuilder: (context, index) {
            return SizedBox(
              width: 30.w,
            );
          },
          itemCount:
              _seats.where((element) => element.type == 2).toList().length),
    );
  }

  Widget _buildSelectedSeatWidget() {
    return Container(
      height: 150.h,
      decoration: BoxDecoration(
        color: AppColors.mansourDarkOrange3,
        borderRadius: BorderRadius.circular(60.r),
      ),
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 50.w),
        child: Row(
          children: [
            const Text(
              'A1 Row 3',
              style: TextStyle(
                color: AppColors.white_text,
              ),
            ),
            SizedBox(
              width: 30.w,
            ),
            GestureDetector(
              onTap: () {
                setState(() {
                  int index = 0;
                  int selectedIndex = 0;
                  bool found = false;
                  _seats.forEach((element) {
                    if (element.type == 2 && !found) {
                      found = true;
                      selectedIndex = index;
                    }
                    index++;
                  });

                  _seats.removeAt(selectedIndex);
                  _seats.insert(selectedIndex, SeatModel(type: 0));
                });
              },
              child: const Icon(
                Icons.close,
                color: AppColors.white,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSeatDemoWidget({
    required Color dotColor,
    required Color textColor,
    required String text,
  }) {
    return Row(
      children: [
        Container(
          height: 30.w,
          width: 30.w,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: dotColor,
          ),
        ),
        SizedBox(
          width: 20.w,
        ),
        Text(
          text,
          style: TextStyle(
            color: textColor,
          ),
        )
      ],
    );
  }

  void _initSeats() {
    _seats = [
      SeatModel(
        type: 3,
      ),
      SeatModel(
        type: 3,
      ),
      SeatModel(
        type: 0,
      ),
      SeatModel(
        type: 3,
      ),
      SeatModel(
        type: 0,
      ),
      SeatModel(
        type: 0,
      ),
      SeatModel(
        type: 0,
      ),
      SeatModel(
        type: 0,
      ),
      SeatModel(
        type: 3,
      ),
      SeatModel(
        type: 0,
      ),
      SeatModel(
        type: 3,
      ),
      SeatModel(
        type: 3,
      ),
      //----
      SeatModel(
        type: 3,
      ),
      SeatModel(
        type: 0,
      ),
      SeatModel(
        type: 0,
      ),
      SeatModel(
        type: 3,
      ),
      SeatModel(
        type: 0,
      ),
      SeatModel(
        type: 0,
      ),
      SeatModel(
        type: 1,
      ),
      SeatModel(
        type: 1,
      ),
      SeatModel(
        type: 3,
      ),
      SeatModel(
        type: 0,
      ),
      SeatModel(
        type: 0,
      ),
      SeatModel(
        type: 3,
      ),
      //-------
      SeatModel(
        type: 0,
      ),
      SeatModel(
        type: 0,
      ),
      SeatModel(
        type: 0,
      ),
      SeatModel(
        type: 3,
      ),
      SeatModel(
        type: 0,
      ),
      SeatModel(
        type: 0,
      ),
      SeatModel(
        type: 1,
      ),
      SeatModel(
        type: 1,
      ),
      SeatModel(
        type: 3,
      ),
      SeatModel(
        type: 0,
      ),
      SeatModel(
        type: 0,
      ),
      SeatModel(
        type: 0,
      ),
      //-----------
      SeatModel(
        type: 1,
      ),
      SeatModel(
        type: 1,
      ),
      SeatModel(
        type: 1,
      ),
      SeatModel(
        type: 3,
      ),
      SeatModel(
        type: 0,
      ),
      SeatModel(
        type: 0,
      ),
      SeatModel(
        type: 1,
      ),
      SeatModel(
        type: 1,
      ),
      SeatModel(
        type: 3,
      ),
      SeatModel(
        type: 0,
      ),
      SeatModel(
        type: 1,
      ),
      SeatModel(
        type: 1,
      ),
      //----------
      SeatModel(
        type: 0,
      ),
      SeatModel(
        type: 0,
      ),
      SeatModel(
        type: 0,
      ),
      SeatModel(
        type: 3,
      ),
      SeatModel(
        type: 1,
      ),
      SeatModel(
        type: 1,
      ),
      SeatModel(
        type: 1,
      ),
      SeatModel(
        type: 1,
      ),
      SeatModel(
        type: 3,
      ),
      SeatModel(
        type: 0,
      ),
      SeatModel(
        type: 1,
      ),
      SeatModel(
        type: 1,
      ),
      //--------
      SeatModel(
        type: 3,
      ),
      SeatModel(
        type: 3,
      ),
      SeatModel(
        type: 3,
      ),
      SeatModel(
        type: 3,
      ),
      SeatModel(
        type: 1,
      ),
      SeatModel(
        type: 1,
      ),
      SeatModel(
        type: 0,
      ),
      SeatModel(
        type: 0,
      ),
      SeatModel(
        type: 3,
      ),
      SeatModel(
        type: 3,
      ),
      SeatModel(
        type: 3,
      ),
      SeatModel(
        type: 3,
      ),
      //----------
      SeatModel(
        type: 0,
      ),
      SeatModel(
        type: 0,
      ),
      SeatModel(
        type: 0,
      ),
      SeatModel(
        type: 3,
      ),
      SeatModel(
        type: 1,
      ),
      SeatModel(
        type: 1,
      ),
      SeatModel(
        type: 0,
      ),
      SeatModel(
        type: 0,
      ),
      SeatModel(
        type: 3,
      ),
      SeatModel(
        type: 0,
      ),
      SeatModel(
        type: 0,
      ),
      SeatModel(
        type: 0,
      ),
      //-----------
      SeatModel(
        type: 0,
      ),
      SeatModel(
        type: 0,
      ),
      SeatModel(
        type: 1,
      ),
      SeatModel(
        type: 3,
      ),
      SeatModel(
        type: 0,
      ),
      SeatModel(
        type: 0,
      ),
      SeatModel(
        type: 1,
      ),
      SeatModel(
        type: 1,
      ),
      SeatModel(
        type: 3,
      ),
      SeatModel(
        type: 0,
      ),
      SeatModel(
        type: 0,
      ),
      SeatModel(
        type: 0,
      ),
      //--------
      SeatModel(
        type: 0,
      ),
      SeatModel(
        type: 0,
      ),
      SeatModel(
        type: 1,
      ),
      SeatModel(
        type: 3,
      ),
      SeatModel(
        type: 0,
      ),
      SeatModel(
        type: 0,
      ),
      SeatModel(
        type: 1,
      ),
      SeatModel(
        type: 1,
      ),
      SeatModel(
        type: 3,
      ),
      SeatModel(
        type: 0,
      ),
      SeatModel(
        type: 0,
      ),
      SeatModel(
        type: 0,
      ),
      //--------------------
      SeatModel(
        type: 3,
      ),
      SeatModel(
        type: 3,
      ),
      SeatModel(
        type: 3,
      ),
      SeatModel(
        type: 3,
      ),
      SeatModel(
        type: 3,
      ),
      SeatModel(
        type: 3,
      ),
      SeatModel(
        type: 3,
      ),
      SeatModel(
        type: 3,
      ),
      SeatModel(
        type: 3,
      ),
      SeatModel(
        type: 3,
      ),
      SeatModel(
        type: 3,
      ),
      SeatModel(
        type: 3,
      ),
      //-------------
      SeatModel(
        type: 0,
      ),
      SeatModel(
        type: 0,
      ),
      SeatModel(
        type: 1,
      ),
      SeatModel(
        type: 3,
      ),
      SeatModel(
        type: 0,
      ),
      SeatModel(
        type: 0,
      ),
      SeatModel(
        type: 1,
      ),
      SeatModel(
        type: 1,
      ),
      SeatModel(
        type: 3,
      ),
      SeatModel(
        type: 0,
      ),
      SeatModel(
        type: 0,
      ),
      SeatModel(
        type: 0,
      ),

      SeatModel(
        type: 0,
      ),
      SeatModel(
        type: 0,
      ),
      SeatModel(
        type: 1,
      ),
      SeatModel(
        type: 3,
      ),
      SeatModel(
        type: 0,
      ),
      SeatModel(
        type: 0,
      ),
      SeatModel(
        type: 1,
      ),
      SeatModel(
        type: 1,
      ),
      SeatModel(
        type: 3,
      ),
      SeatModel(
        type: 0,
      ),
      SeatModel(
        type: 0,
      ),
      SeatModel(
        type: 0,
      ),
    ];
  }
}

//todo refactoring

class SeatModel {
  int type;

  SeatModel({required this.type});
}
