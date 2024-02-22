import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:starter_application/core/common/app_colors.dart';
import 'package:starter_application/core/common/style/gaps.dart';
import 'package:starter_application/core/constants/app/app_constants.dart';
import 'package:starter_application/core/navigation/nav.dart';
import 'package:starter_application/core/ui/error_ui/errors_screens/error_widget.dart';
import 'package:starter_application/core/ui/screens/empty_screen_wiget.dart';
import 'package:starter_application/core/ui/widgets/empty_error_widget.dart';
import 'package:starter_application/core/ui/widgets/waiting_widget.dart';
import 'package:starter_application/features/news/data/model/request/news_single_category_param.dart';
import 'package:starter_application/features/news/data/model/request/news_single_params.dart';
import 'package:starter_application/features/news/domain/entity/news_of_category_entity.dart';
import 'package:starter_application/features/news/presentation/screen/see_all_news_page.dart';
import 'package:starter_application/features/news/presentation/state_m/cubit/news_cubit.dart';
import 'package:starter_application/features/news/presentation/widget/category_item.dart';
import 'package:starter_application/features/news/presentation/widget/health_item.dart';
import 'package:starter_application/features/news/presentation/widget/images_slider.dart';
import 'package:starter_application/features/news/presentation/widget/last_news_item.dart';
import 'package:starter_application/features/news/presentation/widget/latest_news_item.dart';
import 'package:starter_application/features/news/presentation/widget/may_like_item.dart';
import 'package:starter_application/features/news/presentation/widget/spot_item.dart';
import 'package:starter_application/generated/l10n.dart';

import '../../../../main.dart';
import '../screen/../state_m/provider/news_home_screen_notifier.dart';
import 'news_single_screen.dart';
import 'news_sub_category_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:provider/provider.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:starter_application/core/common/app_colors.dart';
import 'package:starter_application/core/common/app_config.dart';
import 'package:starter_application/core/common/style/gaps.dart';
import 'package:starter_application/core/constants/app/app_constants.dart';
import 'package:starter_application/core/constants/enums/notification_type.dart';
import 'package:starter_application/core/navigation/nav.dart';
import 'package:starter_application/core/ui/widgets/pagination_widget.dart';
import 'package:starter_application/core/ui/widgets/waiting_widget.dart';
import 'package:starter_application/features/health/presentation/widget/profile/circled_profile_pic.dart';
import 'package:starter_application/features/news/domain/entity/news_category_entity.dart';
import 'package:starter_application/features/news/domain/entity/news_of_category_entity.dart';
import 'package:starter_application/features/news/presentation/state_m/provider/news_home_screen_notifier.dart';
import 'package:starter_application/features/news/presentation/widget/category_item.dart';
import 'package:starter_application/features/notification/domain/entity/notification_entity.dart';
import 'package:starter_application/features/notification/presentation/widget/notification_card.dart';
import 'package:starter_application/generated/l10n.dart';

import 'news_sub_category_screen.dart';

class NewsHomeScreenContent extends StatefulWidget {
  @override
  State<NewsHomeScreenContent> createState() => _NewsHomeScreenContentState();
}

class _NewsHomeScreenContentState extends State<NewsHomeScreenContent> {
  late NewsHomeScreenNotifier sn;
  EdgeInsets paddingRow1 = EdgeInsets.symmetric(horizontal: 40.w);
  EdgeInsets paddingRow3 = EdgeInsets.symmetric(horizontal: 80.w);

  @override
  Widget build(BuildContext context) {
    sn = Provider.of<NewsHomeScreenNotifier>(context);
    sn.context = context;
    return Container(
      width: 1.sw,
      height: 1.sh,
      child: sn.isSearch
          ? searchResult()
          : sn.isSearchBody
              ? BlocConsumer<NewsCubit, NewsState>(
                  bloc: sn.newsSearchCubit,
                  listener: (context, state) {
                    if (state is CreationTimeNewsLoaded) {
                      sn.onSearchNewsLoaded(
                          state.newsOfCategory1Entity.result.items!);
                      sn.loadingSearchNews(false);
                    }
                    if (state is NewsErrorState) {
                      sn.loadingSearchNews(false);
                    }
                  },
                  builder: (context, state) {
                    if (state is CreationTimeNewsLoaded) {
                      return Container(
                          width: 1.sw,
                          height: 1.sh,
                          margin: EdgeInsets.all(8),
                          child: sn.isLoadingSearchNews
                              ? WaitingWidget()
                              : PaginationWidget<NewsItemOfCategoryEntity>(
                                  scrollDirection: Axis.vertical,
                                  items: sn.NewsOfCreationTime,
                                  getItems: sn.getSearchNewsItems,
                                  onDataFetched: sn.onSearchNewsItemsFetched,
                                  refreshController:
                                      sn.momentsRefreshController,
                                  footer: ClassicFooter(
                                    loadingText: "",
                                    noDataText:
                                        Translation.of(context).noDataRefresher,
                                    failedText:
                                        Translation.of(context).failedRefresher,
                                    idleText: "",
                                    canLoadingText: "",
                                    height:
                                        AppConstants.bottomNavigationBarHeight +
                                            300.h,
                                  ),
                                  child: sn.NewsOfCreationTime.length > 0
                                      ? ListView.separated(
                                          itemBuilder: (context, index) {
                                            return InkWell(
                                              onTap: () {
                                                Nav.to(
                                                  SingleNewsScreen.routeName,
                                                  arguments: SingleNewsParams(
                                                      id: sn
                                                          .NewsOfCreationTime[
                                                              index]
                                                          .id!),
                                                );
                                              },
                                              child: HealthNewsItem(
                                                image: sn
                                                    .NewsOfCreationTime[index]
                                                    .imageUrl!,
                                                icon: sn
                                                        .NewsOfCreationTime[
                                                            index]
                                                        .category
                                                        ?.imageUrl ??
                                                    "",
                                                title: sn
                                                    .NewsOfCreationTime[index]
                                                    .arTitle!,
                                                iconName: sn
                                                        .NewsOfCreationTime[
                                                            index]
                                                        .category
                                                        ?.imageUrl ??
                                                    "",
                                                date: sn
                                                    .NewsOfCreationTime[index]
                                                    .creationTime!,
                                              ),
                                            );
                                          },
                                          separatorBuilder: (context, index) {
                                            return Gaps.vGap64;
                                          },
                                          itemCount:
                                              sn.NewsOfCreationTime.length,
                                        )
                                      : _buildEmptyWidget(),
                                ));
                    }
                    if (state is NewsLoadingState) {
                      return WaitingWidget();
                    }
                    if (state is NewsErrorState) {
                      return ErrorScreenWidget(
                        error: state.error,
                        callback: state.callback,
                      );
                    }
                    if (state is NewsInitState) {
                      return WaitingWidget();
                    }
                    return SizedBox();
                  },
                )
              : Padding(
                  padding:
                      EdgeInsets.symmetric(horizontal: 50.w, vertical: 30.h),
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          //todo change it
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Text(
                              // Translation.current.what_is_new,
                              "ما الأخبار اليوم !",
                              style: TextStyle(
                                color: AppColors.mansourLightGreyColor_16,
                                fontSize: 60.sp,
                                fontWeight: FontWeight.bold,
                                fontFamily:
                                    isArabic ? 'Tajawal' : 'Inter-Regular',
                              ),
                            ),
                          ],
                        ),
                        Gaps.vGap64,
                        ImageSlider(
                          images: sn.imgList,
                          onPress: sn.onSummery,
                          news: sn.NewsOfCreationTime,
                        ),
                        Gaps.vGap64,
                        Padding(
                          padding: EdgeInsets.symmetric(
                            horizontal: 50.w,
                          ),
                          child: Text(
                            // Translation.current.categories,
                            "التصنيفات",
                            style: TextStyle(
                              fontSize: 50.sp,
                              color: Colors.black,
                              fontWeight: FontWeight.bold,
                              fontFamily:
                                  isArabic ? 'Tajawal' : 'Inter-Regular',
                            ),
                          ),
                        ),
                        Gaps.vGap24,
                        Container(
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(40.r),
                              color: AppColors.mansourLightGreyColor_2),
                          child: BlocConsumer<NewsCubit, NewsState>(
                            bloc: sn.newsCubit,
                            listener: (context, state) {
                              if (state is NewsCategoryLoaded) {
                                sn.onCategoriesLoaded(
                                    state.newsCategoryEntity.result.items);
                                // sn.getNewsHome();
                                sn.loading(false);
                              }
                              if (state is NewsErrorState) {
                                sn.loading(false);
                              }
                              // if (state is CreationTimeNewsLoaded) {
                              //   sn.newsOfCreationTimeLoaded(
                              //       state.newsOfCategory1Entity.result.items!);
                              // }
                            },
                            builder: (context, state) {
                              return state.maybeMap(
                                newsInitState: (s) => WaitingWidget(),
                                newsLoadingState: (s) => WaitingWidget(),
                                newsErrorState: (s) => ErrorScreenWidget(
                                  error: s.error,
                                  callback: s.callback,
                                ),
                                newsCategoryLoaded: (s) => Container(
                                    height: 300.w,
                                    decoration: BoxDecoration(
                                        borderRadius:
                                            BorderRadius.circular(40.r),
                                        color:
                                            AppColors.mansourLightGreyColor_2),
                                    child: sn.isLoading
                                        ? WaitingWidget()
                                        : PaginationWidget<
                                            NewsCategoryItemEntity>(
                                            scrollDirection: Axis.horizontal,
                                            items: sn.allCategories,
                                            getItems: sn.getCategoriesItems,
                                            onDataFetched:
                                                sn.onCategoriesItemsFetched,
                                            refreshController:
                                                sn.momentsRefreshController,
                                            footer: ClassicFooter(
                                              loadingText: "",
                                              noDataText:
                                                  Translation.of(context)
                                                      .noDataRefresher,
                                              failedText:
                                                  Translation.of(context)
                                                      .failedRefresher,
                                              idleText: "",
                                              canLoadingText: "",
                                              height: AppConstants
                                                      .bottomNavigationBarHeight +
                                                  300.h,
                                            ),
                                            child: ListView.builder(
                                              itemCount:
                                                  sn.allCategories.length,
                                              itemBuilder:
                                                  (BuildContext context,
                                                      int index) {
                                                return CategoryItem(
                                                  onPress: () {
                                                    Nav.to(
                                                      NewsSubCategoryScreen
                                                          .routeName,
                                                      arguments:
                                                          SingleCategoryParams(
                                                              entity:
                                                                  sn.allCategories[
                                                                      index]),
                                                    );
                                                  },
                                                  // name: sn.categories3[index].name!,
                                                  name: sn.allCategories[index]
                                                      .arName!,
                                                  image: sn.allCategories[index]
                                                      .imageUrl!,
                                                );
                                              },
                                            ),
                                          )),
                                orElse: () {
                                  return SizedBox();
                                },
                              );
                            },
                          ),
                        ),
                        Gaps.vGap96,
                        for (int i = 0; i < sn.allCategories.length; i++)
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 16),
                            child: BlocConsumer<NewsCubit, NewsState>(
                              bloc: NewsCubit()
                                ..newsOfCategory1Home(NewsSingleCategoryParam(
                                    id: sn.allCategories[i].id!)),
                              listener: (context, state) {},
                              builder: (context, state) {
                                if (state is NewsOfCategory1HomeLoaded) {
                                  if (i.isEven) {
                                    return Container(
                                      decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(40.r),
                                          color: AppColors
                                              .mansourLightGreyColor_2),
                                      child: Padding(
                                        padding: EdgeInsets.symmetric(
                                            horizontal: 40.w, vertical: 40.h),
                                        child: Column(
                                          children: [
                                            Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment
                                                      .spaceBetween,
                                              children: [
                                                InkWell(
                                                  onTap: () {
                                                    Nav.to(
                                                      NewsSubCategoryScreen
                                                          .routeName,
                                                      arguments:
                                                          SingleCategoryParams(
                                                              entity:
                                                                  sn.allCategories[
                                                                      i]),
                                                    );
                                                  },
                                                  child: Text(
                                                    // Translation.current.see_all,
                                                    "إظهار الكل",
                                                    style: TextStyle(
                                                      fontSize: 40.sp,
                                                      color:
                                                          AppColors.textLight2,
                                                      fontFamily: isArabic
                                                          ? 'Tajawal'
                                                          : 'Inter-Regular',
                                                    ),
                                                  ),
                                                ),
                                                Text(
                                                  state
                                                          .newsOfCategory1Entity
                                                          .result
                                                          .items
                                                          ?.first
                                                          .category
                                                          ?.arName ??
                                                      "",
                                                  style: TextStyle(
                                                    fontSize: 40.sp,
                                                    color: AppColors.textLight2,
                                                    fontWeight: FontWeight.bold,
                                                    fontFamily: isArabic
                                                        ? 'Tajawal'
                                                        : 'Inter-Regular',
                                                  ),
                                                ),
                                              ],
                                            ),
                                            Gaps.vGap64,
                                            ListView.separated(
                                              shrinkWrap: true,
                                              physics:
                                                  const NeverScrollableScrollPhysics(),
                                              padding: EdgeInsets.zero,
                                              itemBuilder: (context, index) {
                                                return InkWell(
                                                  onTap: () {
                                                    Nav.to(
                                                      SingleNewsScreen
                                                          .routeName,
                                                      arguments: SingleNewsParams(
                                                          id: state
                                                              .newsOfCategory1Entity
                                                              .result
                                                              .items![index]
                                                              .id!),
                                                    );
                                                  },
                                                  child: HealthNewsItem(
                                                    image: state
                                                        .newsOfCategory1Entity
                                                        .result
                                                        .items![index]
                                                        .imageUrl!,
                                                    icon: state
                                                            .newsOfCategory1Entity
                                                            .result
                                                            .items?[index]
                                                            .category
                                                            ?.imageUrl ??
                                                        "",
                                                    title: state
                                                        .newsOfCategory1Entity
                                                        .result
                                                        .items![index]
                                                        .arTitle!,
                                                    iconName: state
                                                            .newsOfCategory1Entity
                                                            .result
                                                            .items?[index]
                                                            .category
                                                            ?.imageUrl ??
                                                        "",
                                                    date: state
                                                        .newsOfCategory1Entity
                                                        .result
                                                        .items![index]
                                                        .creationTime!,
                                                  ),
                                                );
                                              },
                                              separatorBuilder:
                                                  (context, index) {
                                                return Gaps.vGap64;
                                              },
                                              itemCount: state
                                                  .newsOfCategory1Entity
                                                  .result
                                                  .items!
                                                  .length,
                                            ),
                                          ],
                                        ),
                                      ),
                                    );
                                  } else {
                                    return Container(
                                      decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(40.r),
                                          color: AppColors
                                              .mansourLightGreyColor_2),
                                      child: Padding(
                                        padding: EdgeInsets.symmetric(
                                            horizontal: 40.w, vertical: 40.h),
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.end,
                                          children: [
                                            Padding(
                                              padding: EdgeInsets.symmetric(
                                                horizontal: 20.w,
                                              ),
                                              child: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  InkWell(
                                                    onTap: () {
                                                      Nav.to(
                                                        NewsSubCategoryScreen
                                                            .routeName,
                                                        arguments:
                                                            SingleCategoryParams(
                                                                entity:
                                                                    sn.allCategories[
                                                                        i]),
                                                      );
                                                    },
                                                    child: Text(
                                                      // Translation.current.see_all,
                                                      "إظهار الكل",
                                                      style: TextStyle(
                                                        fontSize: 40.sp,
                                                        color: AppColors
                                                            .textLight2,
                                                        fontFamily: isArabic
                                                            ? 'Tajawal'
                                                            : 'Inter-Regular',
                                                      ),
                                                    ),
                                                  ),
                                                  Text(
                                                    state
                                                            .newsOfCategory1Entity
                                                            .result
                                                            .items
                                                            ?.first
                                                            .category
                                                            ?.arName ??
                                                        "",
                                                    style: TextStyle(
                                                      fontSize: 40.sp,
                                                      color:
                                                          AppColors.textLight2,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      fontFamily: isArabic
                                                          ? 'Tajawal'
                                                          : 'Inter-Regular',
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                            Padding(
                                              padding: EdgeInsets.symmetric(
                                                  horizontal: 20.w,
                                                  vertical: 50.h),
                                              child: Text(
                                                // Translation.current.you_may_like,
                                                "قد يعجبك",
                                                style: TextStyle(
                                                    fontSize: 50.sp,
                                                    color: AppColors
                                                        .dark_text_gray,
                                                    fontWeight:
                                                        FontWeight.bold),
                                              ),
                                            ),
                                            SingleChildScrollView(
                                              scrollDirection: Axis.horizontal,
                                              child: Row(
                                                children: [
                                                  SizedBox(
                                                    height: 400.h,
                                                    child: ListView.separated(
                                                      shrinkWrap: true,
                                                      scrollDirection:
                                                          Axis.horizontal,
                                                      physics:
                                                          const NeverScrollableScrollPhysics(),
                                                      itemBuilder:
                                                          (context, index) {
                                                        return MayLikeItem(
                                                          date: state
                                                              .newsOfCategory1Entity
                                                              .result
                                                              .items![index]
                                                              .creationTime!,
                                                          image: state
                                                              .newsOfCategory1Entity
                                                              .result
                                                              .items![index]
                                                              .imageUrl!,
                                                          icon: state
                                                                  .newsOfCategory1Entity
                                                                  .result
                                                                  .items?[index]
                                                                  .category
                                                                  ?.imageUrl ??
                                                              "",
                                                          title: state
                                                              .newsOfCategory1Entity
                                                              .result
                                                              .items![index]
                                                              .arTitle!,
                                                          iconName: state
                                                                  .newsOfCategory1Entity
                                                                  .result
                                                                  .items?[index]
                                                                  .category
                                                                  ?.imageUrl ??
                                                              "",
                                                          onTap: () {
                                                            Nav.to(
                                                              SingleNewsScreen
                                                                  .routeName,
                                                              arguments: SingleNewsParams(
                                                                  id: state
                                                                      .newsOfCategory1Entity
                                                                      .result
                                                                      .items![
                                                                          index]
                                                                      .id!),
                                                            );
                                                          },
                                                        );
                                                      },
                                                      separatorBuilder:
                                                          (context, index) {
                                                        return Gaps.hGap32;
                                                      },
                                                      itemCount: state
                                                          .newsOfCategory1Entity
                                                          .result
                                                          .items!
                                                          .length,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    );
                                  }
                                }
                                if (state is NewsLoadingState) {
                                  return i == 0 ? WaitingWidget() : SizedBox();
                                }
                                if (state is NewsErrorState) {
                                  return ErrorScreenWidget(
                                    error: state.error,
                                    callback: state.callback,
                                  );
                                }
                                if (state is NewsInitState) {
                                  return WaitingWidget();
                                }
                                return SizedBox();
                                return state.maybeMap(
                                  newsInitState: (s) => WaitingWidget(),
                                  newsLoadingState: (s) => WaitingWidget(),
                                  newsErrorState: (s) => ErrorScreenWidget(
                                    error: s.error,
                                    callback: s.callback,
                                  ),
                                  orElse: () {
                                    return SizedBox();
                                  },
                                );
                              },
                            ),
                          ),
                        SizedBox(
                          height: AppConstants.bottomNavigationBarHeight,
                        )
                      ],
                    ),
                  ),
                ),
    );
  }

  Widget _buildEmptyWidget() {
    return SizedBox(
      height: 0.2.sh,
      child: Center(
        child: EmptyErrorScreenWidget(
          message: Translation.current.no_data,
          textColor: AppColors.black,
        ),
      ),
    );
  }

  Widget searchResult() {
    return SingleChildScrollView(
      child: Padding(
        padding: EdgeInsets.only(
            left: 30.w, right: 30.w, top: 70.h, bottom: 0.11.sh),
        child: Column(
          children: [
            ListView.separated(
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              padding: EdgeInsets.zero,
              itemBuilder: (context, index) {
                return InkWell(
                  onTap: () {
                    Nav.to(
                      SingleNewsScreen.routeName,
                      arguments:
                          SingleNewsParams(id: sn.searchResult![index].id!),
                    );
                  },
                  child: HealthNewsItem(
                    image: sn.searchResult![index].imageUrl!,
                    icon: sn.searchResult![index].sourceLogo!,
                    title: sn.searchResult![index].enTitle!,
                    iconName: sn.searchResult![index].sourceName!,
                    date: sn.searchResult![index].creationTime!,
                  ),
                );
              },
              separatorBuilder: (context, index) {
                return Gaps.vGap64;
              },
              itemCount: sn.searchResult!.length,
            ),
          ],
        ),
      ),
    );
  }
}
