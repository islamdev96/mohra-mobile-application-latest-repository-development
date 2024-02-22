import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';
import 'package:starter_application/core/common/app_colors.dart';
import 'package:starter_application/core/navigation/nav.dart';
import 'package:starter_application/core/ui/appbar/appbar.dart';
import 'package:starter_application/core/ui/error_ui/error_viewer/error_viewer.dart';
import 'package:starter_application/core/ui/error_ui/errors_screens/error_widget.dart';
import 'package:starter_application/core/ui/widgets/waiting_widget.dart';
import 'package:starter_application/features/shop/presentation/state_m/cubit/shop_cubit.dart';
import 'package:starter_application/generated/l10n.dart';

import '../../screen/../state_m/provider/favorite_products_screen_notifier.dart';
import 'favorite_products_screen_content.dart';

class FavoriteProductsScreen extends StatefulWidget {
  static const String routeName = "/FavoriteProductsScreen";

  const FavoriteProductsScreen({Key? key}) : super(key: key);

  @override
  _FavoriteProductsScreenState createState() => _FavoriteProductsScreenState();
}

class _FavoriteProductsScreenState extends State<FavoriteProductsScreen> {
  final sn = FavoriteProductsScreenNotifier();

  @override
  void initState() {
    sn.getFavoritesProducts();
    super.initState();
  }

  @override
  void dispose() {
    sn.closeNotifier();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<FavoriteProductsScreenNotifier>.value(
      value: sn,
      child: MultiBlocListener(
        listeners: [
          BlocListener<ShopCubit, ShopState>(
            bloc: sn.favoriteProductsCubit,
            listener: (context, state) {
              if(state is GetProductsLoadedState){
                sn.NotificationsLoaded(state.topProductsEntity);
                sn.loading(false);
              }
              if(state is ShopErrorState) {
                sn.loading(false);
                ErrorViewer.showError(
                  context: context,
                  error: state.error,
                  callback: state.callback,
                );
              }
            },
          )
        ],
        child: Scaffold(
          appBar: buildCustomAppbar(
            titleText: Translation.current.favorite,
            // onBackTap: (){
            //   // sn.getFavoritesProducts();
            //   Nav.pop();
            // }
          ),
          backgroundColor: AppColors.white,
          body: BlocBuilder<ShopCubit, ShopState>(
            bloc: sn.favoriteProductsCubit,
            builder: (context, state) {
              if(state is ShopLoadingState)
                return  WaitingWidget();
              if(state is GetProductsLoadedState)
                return FavoriteProductsScreenContent();
              if(state is ShopErrorState)
                return ErrorScreenWidget(error: state.error, callback: state.callback);
              return const SizedBox();
            },
          ),




        ),
      ),
    );
  }
}
