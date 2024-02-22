import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';
import 'package:starter_application/core/common/app_colors.dart';
import 'package:starter_application/core/navigation/nav.dart';
import 'package:starter_application/core/ui/appbar/appbar.dart';
import 'package:starter_application/core/ui/error_ui/error_viewer/error_viewer.dart';
import 'package:starter_application/core/ui/snackbars/show_snackbar.dart';
import 'package:starter_application/features/shop/domain/entity/shipping_addresses_list_entity.dart';
import 'package:starter_application/features/shop/presentation/state_m/cubit/shop_cubit.dart';
import 'package:starter_application/generated/l10n.dart';

import '../../screen/../state_m/provider/add_edit_shipping_address_screen_notifier.dart';
import 'add_edit_shipping_address_screen_content.dart';

class AddEditShippingAddressScreenParam {
  final ShippingAddressEntity? address;
  final Function(ShippingAddressEntity entity, bool isEdit)? onSuccess;
  AddEditShippingAddressScreenParam({
    this.address,
    this.onSuccess,
  });

  bool get isEditAddress => address != null;
}

class AddEditShippingAddressScreen extends StatefulWidget {
  static const String routeName = "/AddEditShippingAddressScreen";
  final AddEditShippingAddressScreenParam param;

  const AddEditShippingAddressScreen({
    Key? key,
    required this.param,
  }) : super(key: key);

  @override
  _AddEditShippingAddressScreenState createState() =>
      _AddEditShippingAddressScreenState();
}

class _AddEditShippingAddressScreenState
    extends State<AddEditShippingAddressScreen> {
  late final AddEditShippingAddressScreenNotifier sn;

  @override
  void initState() {
    super.initState();
    sn = AddEditShippingAddressScreenNotifier(
      widget.param,
    );
  }

  @override
  void dispose() {
    sn.closeNotifier();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<AddEditShippingAddressScreenNotifier>.value(
      value: sn,
      child: Scaffold(
        appBar: buildCustomAppbar(
          titleText: Translation.current.add_shipping_info,
        ),
        backgroundColor: AppColors.mansourLightGreyColor_4,
        body: BlocListener<ShippingAddressCubit, ShippingAddressState>(
          bloc: sn.addressCubit,
          listener: (context, state) {
            state.mapOrNull(
              createShippingAddressSuccess: (s) {
                widget.param.onSuccess?.call(s.address, false);
                Nav.pop();
                showSnackbar(Translation.current.success_add_address);
              },
              updateShippingAddressSuccess: (s) {
                widget.param.onSuccess?.call(s.address, true);
                Nav.pop();
                showSnackbar(Translation.current.success_update_address);
              },
              shippingAddressErrorState: (s) => ErrorViewer.showError(
                context: context,
                error: s.error,
                callback: s.callback,
              ),
            );
          },
          child: AddEditShippingAddressScreenContent(),
        ),
      ),
    );
  }
}
