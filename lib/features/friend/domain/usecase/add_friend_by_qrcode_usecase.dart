import 'package:injectable/injectable.dart';
import 'package:starter_application/core/errors/app_errors.dart';
import 'package:starter_application/core/models/empty_response.dart';
import 'package:starter_application/core/results/result.dart';
import 'package:starter_application/core/usecases/usecase.dart';
import 'package:starter_application/features/friend/data/model/request/add_friend_by_qrcode_param.dart';
import 'package:starter_application/features/friend/domain/repository/ifriend_repository.dart';
@injectable
class AddFriendByQrCodeUseCase
    extends UseCase<EmptyResponse, AddFriendByQrCodeParam> {
  final IFriendRepository repository;

  AddFriendByQrCodeUseCase(this.repository);
  @override
  Future<Result<AppErrors, EmptyResponse>> call(AddFriendByQrCodeParam param) {
    return repository.addFriendByQrCode(param);
  }
}
