import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:provider/provider.dart';
import 'package:starter_application/core/common/app_config.dart';
import 'package:starter_application/core/constants/enums/chat_message_enum.dart';
import 'package:starter_application/core/ui/error_ui/error_viewer/error_viewer.dart';
import 'package:starter_application/di/service_locator.dart';
import 'package:starter_application/features/messages/presentation/state_m/provider/global_messages_notifier.dart';
import 'package:starter_application/features/upload/data/model/request/upload_image_param.dart';
import 'package:starter_application/features/upload/domain/entity/upload_file_response_entity.dart';
import 'package:starter_application/features/upload/domain/usecase/upload_usecase.dart';

import '../../../../../core/errors/app_errors.dart';

part 'upload_cubit.freezed.dart';
part 'upload_state.dart';

class UploadCubit extends Cubit<UploadState> {
  UploadCubit() : super(const UploadState.uploadInitState());

  void uploadFile(UploadFileParams params) async {
    emit(const UploadState.uploadLoadingState());
    final result = await getIt<UploadFileUseCase>()(params);
    result.pick(
      onData: (data) => emit(UploadState.uploadImageLoaded(data)),
      onError: (error) => emit(
        UploadState.uploadErrorState(error, () => this.uploadFile(params)),
      ),
    );
  }

  void uploadMessagingFile({
    required UploadFileParams params,
    required int id,
    required int loadingIndex,
    required ChatMessageType chatType,
    required String roomName,
    required String roomImage,
    required int roomId,
    bool isGroup = false,
  }) async {
    final result = await getIt<UploadFileUseCase>()(params);
    result.pick(onData: (data) {
      Provider.of<GlobalMessagesNotifier>(AppConfig().appContext, listen: false)
          .onFileLoaded(
              id: id,
              isGroup: isGroup,
              loadingId: loadingIndex,
              url: data.url,
              type: chatType,
              roomImage: roomImage,
              roomName: roomName,
              roomId: roomId);
    }, onError: (error) {
      Provider.of<GlobalMessagesNotifier>(AppConfig().appContext, listen: false)
          .onFileNotLoaded(
        id: id,
        isGroup: isGroup,
        loadingId: loadingIndex,
        type: chatType,
      );
      ErrorViewer.showError(
          context: AppConfig().appContext, error: error, callback: () {});
    });
  }
}
