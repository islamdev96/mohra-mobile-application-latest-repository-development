import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';
import 'package:starter_application/core/common/app_colors.dart';
import 'package:starter_application/core/constants/app/app_constants.dart';
import 'package:starter_application/core/navigation/nav.dart';
import 'package:starter_application/core/ui/widgets/waiting_widget.dart';
import 'package:starter_application/features/news/data/model/request/news_single_category_param.dart';
import 'package:starter_application/features/news/domain/entity/news_of_category_entity.dart';
import 'package:starter_application/features/news/presentation/state_m/cubit/news_cubit.dart';
import 'package:starter_application/features/news/presentation/widget/news_home_appbar.dart';
import '../../../../main.dart';
import '../screen/../state_m/provider/single_category_screen_notifier.dart';
import 'news_subcategory_screen_content.dart';

class NewsSubCategoryScreen extends StatefulWidget {
  static const String routeName = "/NewsSubCategoryScreen";

  const NewsSubCategoryScreen({Key? key, required this.entity})
      : super(key: key);
  final SingleCategoryParams entity;

  @override
  _NewsSubCategoryScreenState createState() => _NewsSubCategoryScreenState();
}

class _NewsSubCategoryScreenState extends State<NewsSubCategoryScreen> {
  final sn = SingleCategoryScreenNotifier();

  @override
  void initState() {
    sn.getNewsOfSingleCategory(widget.entity.entity.id.toString());
    super.initState();
  }

  @override
  void dispose() {
    sn.closeNotifier();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: ChangeNotifierProvider<SingleCategoryScreenNotifier>.value(
          value: sn,
          child: BlocConsumer<NewsCubit, NewsState>(
            bloc: sn.newsCubit,
            builder: (context, state) {
              return state is NewsLoadingState
                  ? Container(color: Colors.white, child: WaitingWidget())
                  : Scaffold(
                      appBar: NewsHomeAppBar(
                        title: Text(
                          // widget.entity.entity.name!,
                          widget.entity.entity.arName!,
                          style: TextStyle(
                            fontSize: 50.sp,
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                            fontFamily: isArabic ? 'Tajawal' : 'Inter-Regular',
                          ),
                        ),
                        isLeading: sn.isSearch,
                        controller: sn.search,
                        isHasLeading: true,
                        onPress: () {
                          sn.change();
                          sn.keyword = null;
                          // sn.getNewsOfSingleCategory(widget.entity.entity.id.toString()) ;
                          setState(() {});
                        },
                        onSearch: () {
                          sn.change();
                        },
                        onSubmitted: (String value) {
                          sn.change();
                          sn.keyword = value;
                          sn.getNewsOfSingleCategory(
                              widget.entity.entity.id.toString());
                        },
                        onClose: () {
                          Nav.pop();
                          // sn.keyword  = null;
                          // sn.getNewsOfSingleCategory(widget.entity.entity.id.toString()) ;
                          // Navigator.of(context).pushAndRemoveUntil(
                          //     MaterialPageRoute(builder: (context) => HomeScreen()),
                          //         (Route<dynamic> route) => false);
                        },
                      ),

                      // AppBar(
                      //   backgroundColor: Colors.white,
                      //   elevation: 0.0,
                      //   leading: InkWell(
                      //       onTap: () {
                      //         Nav.pop();
                      //       },
                      //       child: const Icon(
                      //         AppConstants.getIconBack(),
                      //         color: Colors.black,
                      //       )),
                      //   title: Text(
                      //     // widget.entity.entity.name!,
                      //     widget.entity.entity.arName!,
                      //     style: TextStyle(fontSize: 50.sp,
                      //       color: Colors.black,
                      //       fontWeight: FontWeight.bold),),
                      //   centerTitle: true,
                      //   actions: [
                      //     Padding(
                      //       padding: EdgeInsets.symmetric(horizontal: 40.h),
                      //       child: Row(
                      //         children: [
                      //           SvgPicture.asset(
                      //             AppConstants.SVG_SEAECH,
                      //             color: AppColors.black_text,
                      //             height: 60.h,
                      //             width: 60.h,
                      //           ),
                      //         ],
                      //       ),
                      //     ),
                      //   ],
                      // ),
                      backgroundColor:
                          Theme.of(context).scaffoldBackgroundColor,
                      body: NewsSubCategoryScreenContent(),
                    );
            },
            listener: (context, state) {
              if (state is NewsOfSingleCategoryLoaded) {
                sn.NewsOfCategories = state.newsOfCategoryEntity.result.items!;
              }
            },
          )),
    );
  }
}
