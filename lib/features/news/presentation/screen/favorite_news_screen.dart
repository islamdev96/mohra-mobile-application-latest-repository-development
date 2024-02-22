import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:starter_application/features/favorite/data/model/request/get_favorites_params.dart';
import 'package:starter_application/generated/l10n.dart';

import '../../../../main.dart';
import '../screen/../state_m/provider/favorite_news_screen_notifier.dart';
import 'favorite_news_screen_content.dart';

class FavoriteNewsScreen extends StatefulWidget {
  static const String routeName = "/FavoriteNewsScreen";

  const FavoriteNewsScreen({Key? key}) : super(key: key);

  @override
  _FavoriteNewsScreenState createState() => _FavoriteNewsScreenState();
}

class _FavoriteNewsScreenState extends State<FavoriteNewsScreen> {
  final sn = FavoriteNewsScreenNotifier();

  @override
  void initState() {
    super.initState();
    sn.favoriteCubit.getFavorites(GetFavoritesParams(refType: 2));
  }

  @override
  void dispose() {
    sn.closeNotifier();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<FavoriteNewsScreenNotifier>.value(
      value: sn,
      child: Scaffold(
        appBar: AppBar(
          title: Text(
            Translation.current.favorite,
            style: TextStyle(
              fontSize: 50.sp,
              fontFamily: isArabic ? 'Tajawal' : 'Inter-Regular',
            ),
          ),
        ),
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        body: FavoriteNewsScreenContent(),
      ),
    );
  }
}
