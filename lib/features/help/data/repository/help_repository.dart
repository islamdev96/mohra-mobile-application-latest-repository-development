import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:starter_application/core/common/extensions/either_error_model_extension.dart';
import 'package:starter_application/core/errors/app_errors.dart';
import 'package:starter_application/core/models/empty_response.dart';
import 'package:starter_application/core/params/no_params.dart';
import 'package:starter_application/core/results/result.dart';
import 'package:starter_application/features/help/data/model/request/create_contact_us_ticket_params.dart';
import 'package:starter_application/features/help/domain/entity/faq_entity.dart';
import 'package:starter_application/features/help/domain/entity/reasons_entity.dart';
import '../../domain/entity/about_us_entity.dart';
import '../datasource/../../domain/repository/ihelp_repository.dart';
import '../datasource/ihelp_remote.dart';

@Singleton(as: IHelpRepository)
class HelpRepository extends IHelpRepository {
  final IHelpRemoteSource iHelpRemoteSource;

  HelpRepository(this.iHelpRemoteSource);

  @override
  Future<Result<AppErrors, FaqListEntity>> getAllFaqs(NoParams param) async {
    final remote = await iHelpRemoteSource.getAllFaqs(param);
    return remote.result<FaqListEntity>();
  }

  @override
  Future<Result<AppErrors, ReasonsListEntity>> getAllReasons(
      NoParams param) async {
    final remote = await iHelpRemoteSource.getAllReasons(param);
    return remote.result<ReasonsListEntity>();
  }

  @override
  Future<Result<AppErrors, EmptyResponse>> createContactUsTicket(
      CreateContactUsTicketParams param) async {
    final remote = await iHelpRemoteSource.createContactUsTicket(param);
    return remote.result<EmptyResponse>();
  }

  @override
  Future<Result<AppErrors, AboutUsEntity>> getAboutUs(NoParams param) async {
    final remote = await iHelpRemoteSource.getAboutUs(param);
    return remote.result<AboutUsEntity>();
  }
}
