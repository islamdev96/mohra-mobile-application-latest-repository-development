import 'package:flutter/material.dart';
import 'package:flutter_contacts/contact.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:starter_application/core/ui/widgets/custom_network_image_widget.dart';
import 'package:starter_application/core/ui/widgets/pagination_widget.dart';
import 'package:starter_application/features/messages/domain/entity/friend_entity.dart';
import 'package:starter_application/features/messages/presentation/state_m/provider/my_contacts_screen_notifier.dart';
import 'package:starter_application/features/messages/presentation/widgets/loading_message_widget.dart';

import '../screen/../state_m/provider/friends_screen_notifier.dart';

class MyContactsScreenContent extends StatefulWidget {
  @override
  State<MyContactsScreenContent> createState() =>
      _MyContactsScreenContentState();
}

class _MyContactsScreenContentState extends State<MyContactsScreenContent> {
  late MyContactsScreenNotifier sn;

  @override
  Widget build(BuildContext context) {
    sn = Provider.of<MyContactsScreenNotifier>(context);
    // sn.clients.removeWhere((element) => element.client == null);
    sn.context = context;
    return !sn.canAccess
        ? const Center(child: Text("Please Give Access to Load Your Contacts"))
        : sn.loading
            ? const Center(child: LoadingMessageWidget())
            : Padding(
                padding: EdgeInsets.symmetric(vertical: 20.h),
                child: ListView.separated(
                    itemBuilder: (context, index) =>
                        _buildItem(sn.contacts[index]),
                    separatorBuilder: (context, index) => SizedBox(
                          height: 40.h,
                        ),
                    itemCount: sn.contacts.length),
              );
    // return Padding(
    //   padding: EdgeInsets.only(top: 20.h),
    //   child: PaginationWidget<FriendEntity>(
    //       refreshController: sn.refreshController,
    //       getItems: (unit) {
    //         return sn.returnData(unit);
    //       },
    //       items: sn.clients,
    //       onDataFetched: (items, nextUnit) => sn.onDataFetched(items, nextUnit),
    //       child: ListView.separated(
    //           itemBuilder: (context, index) {
    //
    //            return _buildItem(sn.clients.elementAt(index));
    //           },
    //
    //           separatorBuilder: (context, index) => SizedBox(
    //                 height: 40.h,
    //               ),
    //           itemCount: sn.clients.length)),
    // );
  }

  Widget _buildItem(Contact contact) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 40.w),
      child: GestureDetector(
        onTap: () {},
        child: Row(
          children: [
            contact.photo != null
                ? ClipRRect(
                    borderRadius: BorderRadius.circular(100.r),
                    child: Container(
                      height: 150.w,
                      width: 150.w,
                      child: Image.memory(
                        contact.photo!,
                        fit: BoxFit.cover, // You can adjust the fit as needed
                      ),
                    ),
                  )
                : ClipRRect(
                    borderRadius: BorderRadius.circular(100.r),
                    child: CustomNetworkImageWidget(
                        height: 150.w,
                        width: 150.w,
                        imgPath:
                            "https://cdn.pixabay.com/photo/2015/10/05/22/37/blank-profile-picture-973460_640.png"),
                  ),
            const Spacer(),
            SizedBox(
              width: 0.6.sw,
              child: Text(
                contact.displayName,
                style: TextStyle(fontSize: 50.sp),
              ),
            ),
            const Spacer(
              flex: 6,
            ),
          ],
        ),
      ),
    );
  }
}
