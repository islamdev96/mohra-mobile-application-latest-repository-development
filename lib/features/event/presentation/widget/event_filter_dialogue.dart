import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:starter_application/core/common/app_colors.dart';
import 'package:starter_application/core/navigation/nav.dart';
import 'package:starter_application/core/ui/error_ui/errors_screens/error_widget.dart';
import 'package:starter_application/core/ui/mansour/button/custom_mansour_button.dart';
import 'package:starter_application/core/ui/widgets/waiting_widget.dart';
import 'package:starter_application/features/location/data/model/request/get_locations_lite_params.dart';
import 'package:starter_application/features/location/domain/entity/location_lite_entity.dart';
import 'package:starter_application/features/location/domain/entity/locations_lite_entity.dart';
import 'package:starter_application/features/location/presentation/state_m/cubit/location_cubit.dart';
import 'package:starter_application/generated/l10n.dart';

class EventFilterDialogue extends StatefulWidget {
  final Function(LocationLiteEntity? locationLiteEntity) search;
  final LocationLiteEntity? locationLiteEntity;
  const EventFilterDialogue(
      {Key? key, required this.search, required this.locationLiteEntity})
      : super(key: key);

  @override
  State<EventFilterDialogue> createState() => _EventFilterDialogueState();
}

class _EventFilterDialogueState extends State<EventFilterDialogue> {
  LocationLiteEntity? _locationLiteEntity;
  LocationCubit _locationCubit = LocationCubit();
  @override
  void initState() {
    super.initState();
    _locationLiteEntity = widget.locationLiteEntity;
    _locationCubit.getLocationsLite(GetLocationsLiteParams(
      maxResultCount: 1000,
      type: 1,
    ));
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(40.r),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          ConstrainedBox(
            constraints: BoxConstraints(
                maxHeight: 0.6.sh, minHeight: 0.2.sh, minWidth: 0.9.sw),
            child: BlocBuilder<LocationCubit, LocationState>(
              bloc: _locationCubit,
              builder: (context, state) => state.maybeMap(
                  locationInitState: (value) => WaitingWidget(),
                  locationLoadingState: (value) => WaitingWidget(),
                  locationErrorState: (value) => ErrorScreenWidget(
                        callback: value.callback,
                        error: value.error,
                      ),
                  locationsLoadedState: (value) =>
                      _buildWidget(value.locationsLiteEntity),
                  orElse: SizedBox.shrink,
              ),
            ),
          )
        ],
      ),
    );
  }

  Widget _buildWidget(LocationsLiteEntity locationsLiteEntity) {
    // locationsLiteEntity.items.insert(0, LocationLiteEntity(text: Translation.current.all,value: "0"));
    return Padding(
      padding: const EdgeInsets.all(30.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(Translation.current.city , style: TextStyle(
            fontSize: 38.sp,

          ),),
          SizedBox(
            height: 30.h,
          ),
          UnconstrainedBox(
            child: Container(
              decoration: BoxDecoration(
                  color: AppColors.white,
                  borderRadius: BorderRadius.all(Radius.circular(12.0)),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(.1),
                      offset: Offset(0, 0),
                      blurRadius: 4,
                      spreadRadius: 4,
                    ),
                  ]),
              padding:const EdgeInsets.symmetric(horizontal: 10),
              constraints: BoxConstraints(
                maxHeight: 60,
                maxWidth: .55.sw,
                minHeight: 60,
                minWidth: .55.sw,
              ),
              child: Center(
                child: DropdownSearch<LocationLiteEntity>(
                  dropdownButtonProps: IconButtonProps(
                    icon: Icon(Icons.arrow_drop_down, color: AppColors.mansourDarkOrange,size: 30,),

                  ),
                  itemAsString: (c){
                    return c!.text;
                  },
                  filterFn: (city, text){
                    return city == null ? true : applyFilter(city , text);
                  },
                  searchFieldProps:  TextFieldProps(
                      cursorColor: AppColors.mansourDarkOrange,
                      decoration: InputDecoration(
                          border: OutlineInputBorder(
                              borderSide: BorderSide(
                                width: 1,
                                color: AppColors.mansourDarkOrange,
                                style: BorderStyle.solid,
                              )),
                          enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                width: 1,
                                color: AppColors.mansourDarkOrange,
                                style: BorderStyle.solid,
                              )),
                          focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(
                                width: 1,
                                color: AppColors.mansourDarkOrange,
                                style: BorderStyle.solid,
                              )))),
                  dropdownSearchBaseStyle: TextStyle(

                  ),
                  searchDelay: Duration.zero,
                  showSearchBox: true,
                  maxHeight: 0.5.sh,
                  dropdownSearchTextAlignVertical:
                  TextAlignVertical.center,
                  mode: Mode.BOTTOM_SHEET,
                  items:locationsLiteEntity.items,
                  onChanged: (c){
                    if(c!.value != "0")
                    chooseLocation(c);
                  },
                  showSelectedItems: false,
                  dropdownSearchDecoration: InputDecoration.collapsed(
                    hintText: 'city',
                    hintStyle: TextStyle(
                      fontFamily: "OpenSansRegular",
                      color: AppColors.white,
                      fontSize: 14.sp,
                    ),
                  ),
                ),
              ),
            ),
          ),
        /*  DropdownButton<LocationLiteEntity>(
            value: _locationLiteEntity,
            items: locationsLiteEntity.items
                .map(
                  (e) => DropdownMenuItem<LocationLiteEntity>(
                    child: Text(e.text),
                    value: e,
                  ),
                )
                .toList(),
            onChanged: (value) => chooseLocation(value),
          ),*/
          SizedBox(
            height: 0.1.sh,
          ),
          Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CustomMansourButton(
                titleText: Translation.current.search,
                width: 0.3.sw,
                onPressed: () {
                  search();
                },
              ),
            ],
          )
        ],
      ),
    );
  }

  chooseLocation(LocationLiteEntity? locationLiteEntity) {
    setState(() {
      this._locationLiteEntity = locationLiteEntity;
    });
  }

  search() {
    if(_locationLiteEntity != null) {
      if (_locationLiteEntity!.value != '0')
        widget.search(_locationLiteEntity);
      else
        widget.search(null);
    }else
      widget.search(null);
    Nav.pop();
  }

  applyFilter(LocationLiteEntity locationLiteEntity, String? text) {
    return locationLiteEntity.isContain(text);
  }
}
