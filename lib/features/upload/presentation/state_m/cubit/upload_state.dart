part of 'upload_cubit.dart';

@freezed
class UploadState with _$UploadState {
  const factory UploadState.uploadInitState() = UploadInitState;

  const factory UploadState.uploadLoadingState() = UploadLoadingState;

  const factory UploadState.uploadErrorState(
    AppErrors error,
    VoidCallback callback,
  ) = UploadErrorState;
  const factory UploadState.uploadImageLoaded(
      UploadFileResponseEntity uploadFileResponseEntity) = UploadFileLoaded;
}
