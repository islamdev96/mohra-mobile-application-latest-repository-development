import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:starter_application/core/common/app_colors.dart';
import 'package:starter_application/core/common/style/gaps.dart';
import 'package:starter_application/core/constants/app/app_constants.dart';
import 'package:starter_application/core/ui/error_ui/errors_screens/error_widget.dart';
import 'package:starter_application/core/ui/mansour/search_textfield.dart';
import 'package:starter_application/core/ui/screens/empty_screen_wiget.dart';
import 'package:starter_application/core/ui/widgets/waiting_widget.dart';
import 'package:starter_application/features/moment/presentation/state_m/cubit/moment_cubit.dart';
import 'package:starter_application/features/moment/presentation/state_m/provider/select_place_screen_notifier.dart';
import 'package:starter_application/generated/l10n.dart';

class SelectPlaceScreenContent extends StatefulWidget {
  @override
  State<SelectPlaceScreenContent> createState() =>
      _SelectPlaceScreenContentState();
}

class _SelectPlaceScreenContentState extends State<SelectPlaceScreenContent> {
  late SelectPlaceScreenNotifier sn;

  final _refreshContorller = RefreshController();

  @override
  Widget build(BuildContext context) {
    sn = Provider.of<SelectPlaceScreenNotifier>(context);
    sn.context = context;
    return Padding(
      padding: AppConstants.screenPadding,
      child: Column(
        children: [
          Gaps.vGap32,
          _buildSearchTextField(),
          Gaps.vGap32,
          sn.isNear?
          sn.getNearbyplacesLoading
              ? WaitingWidget()
              : _buildNearsetPlacesList():
          __buildPlacesListBlocuilder()
        ],
      ),
    );
  }

  // Widget _buildAppbar() {
  Widget _buildSearchTextField() {
    final border = OutlineInputBorder(
      borderRadius: BorderRadius.circular(100),
      borderSide: const BorderSide(
        color: Colors.transparent,
      ),
    );
    return SearchTextField(
      textKey: sn.searchKey,
      controller: sn.searchController,
      focusNode: sn.searchFocusNode,
      backgroundColor: AppColors.mansourLightGreyColor_18,
      onFieldSubmitted: (v) => sn.onSearchSubmitted(),
      onChange: (p0) {
        if (p0.isEmpty) {
          sn.makeNearTrue();
        }
      },
    );
  }

  Widget _buildEmpyScreen() {
    return EmptyScreenWidget(
      title: Translation.current.no_results_found,
      onButtonPressed: () => sn.onSearchSubmitted(),
    );
  }

  Widget __buildPlacesListBlocuilder() {
    return Expanded(
      child: BlocBuilder<MomentCubit, MomentState>(
        bloc: sn.findPlaceCubit,
        builder: (context, state) {
          return state.maybeMap(
            momentInitState: (s) => EmptyScreenWidget(
              title: Translation.current.search_for_places,
            ),
            momentLoadingState: (s) => WaitingWidget(),
            findPlaceLoaded: (s) => _buildPlacesList(),
            momentErrorState: (s) => ErrorScreenWidget(
              error: s.error,
              callback: s.callback,
            ),
            orElse: () => const ScreenNotImplementedError(),
          );
        },
      ),
    );
  }

  Widget _buildPlacesList() {
    return ListView.separated(
        itemBuilder: (context, index) {
          // final place = sn.places[index];
          return InkWell(
            onTap: () => sn.onSelectPlaceTap(index),
            child: Container(
              padding: EdgeInsets.all(
                30.h,
              ),
              child: Text(
                sn.places[index].name,
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 40.sp,
                ),
              ),
              decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(
                    15.r,
                  ),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.4),
                      blurRadius: 3,
                    )
                  ]),
            ),
          );
        },
        separatorBuilder: (context, index) {
          return Gaps.vGap32;
        },
        itemCount: sn.places.length);
  }

  Widget _buildNearsetPlacesList() {
    return Expanded(
      child: ListView.separated(
          itemBuilder: (context, index) {
            // final place = sn.places[index];
            return InkWell(
              onTap: () => sn.onSelectNeaPlaceTap(index),
              child: Container(
                padding: EdgeInsets.all(
                  30.h,
                ),
                child: Text(
                  sn.nearPlaces[index].name,
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 40.sp,
                  ),
                ),
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(
                      15.r,
                    ),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.4),
                        blurRadius: 3,
                      )
                    ]),
              ),
            );
          },
          separatorBuilder: (context, index) {
            return Gaps.vGap32;
          },
          itemCount: sn.nearPlaces.length),
    );
  }
}
