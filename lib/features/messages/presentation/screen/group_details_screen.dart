import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';
import 'package:starter_application/core/common/app_colors.dart';
import 'package:starter_application/core/navigation/nav.dart';
import 'package:starter_application/core/params/screen_params/group_details_screen_param.dart';
import 'package:starter_application/core/ui/error_ui/error_viewer/error_viewer.dart';
import 'package:starter_application/features/messages/presentation/state_m/cubit/messages_cubit.dart';
import 'package:starter_application/features/messages/presentation/state_m/provider/global_messages_notifier.dart';
import 'package:starter_application/features/upload/presentation/state_m/cubit/upload_cubit.dart';

import '../screen/../state_m/provider/group_details_screen_notifier.dart';
import 'group_details_screen_content.dart';

class GroupDetailsScreen extends StatefulWidget {
  static const String routeName = "/GroupDetailsScreen";
  final GroupDetailsScreenParams params;
  const GroupDetailsScreen({Key? key, required this.params}) : super(key: key);

  @override
  _GroupDetailsScreenState createState() => _GroupDetailsScreenState();
}

class _GroupDetailsScreenState extends State<GroupDetailsScreen> {
  final sn = GroupDetailsScreenNotifier();

  @override
  void initState() {
    super.initState();
    sn.params = widget.params;
    sn.friends = widget.params.friends;
    if (widget.params.isEditGroup) sn.setGroupTitle(widget.params.name!);
    if (widget.params.isEditGroup) sn.setGroupDetails(widget.params.details!);
    if (widget.params.isEditGroup) sn.setGroupImage(widget.params.image!);
  }

  @override
  void dispose() {
    sn.closeNotifier();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<GroupDetailsScreenNotifier>.value(
      value: sn,
      child: Scaffold(
          backgroundColor: AppColors.mansourLightGreyColor_4,
          body: MultiBlocListener(
            listeners: [
              BlocListener<UploadCubit, UploadState>(
                bloc: sn.uploadCubit,
                listener: (context, state) =>
                    state.whenOrNull(uploadImageLoaded: (imageUrlsEntity) {
                  sn.createGroup(imageUrlsEntity.url);
                }, uploadErrorState: (error, callback) {
                  sn.showHud = false;
                  ErrorViewer.showError(
                      context: context, error: error, callback: callback);
                }),
              ),
              BlocListener<MessagesCubit, MessagesState>(
                bloc: sn.messagesCubit,
                listener: (context, state) => state.mapOrNull(
                  messagesErrorState: (value) {
                    sn.showHud = false;
                    ErrorViewer.showError(
                        context: context,
                        error: value.error,
                        callback: value.callback);
                  },
                  groupCreatedState: (value) {
                    sn.showHud = false;
                    /*Provider.of<GlobalMessagesNotifier>(context, listen: false)
                        .joinChannel(value.groupEntity.id!);*/
                    Nav.pop();
                  },
                  groupUpdatedState: (value) {
                    Provider.of<GlobalMessagesNotifier>(context, listen: false)
                        .editGroup(value.groupEntity);
                    Nav.pop(context, value.groupEntity);
                  },
                ),
              ),
            ],
            child: GroupDetailsScreenContent(),
          )),
    );
  }
}
/*listener: (context, state) => state.mapOrNull(
                      messagesErrorState: (value) => ErrorViewer.showError(
                          context: context,
                          error: value.error,
                          callback: value.callback),
                      groupCreatedState: (value) {
                        Provider.of<GlobalMessagesNotifier>(context,
                                listen: false)
                            .joinChannel(value.groupEntity.id!);
                        Nav.pop();
                      },
                    ),*/
