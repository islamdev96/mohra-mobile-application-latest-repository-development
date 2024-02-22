import 'package:dartz/dartz.dart';
import 'package:starter_application/core/models/empty_response.dart';
import 'package:starter_application/features/help/data/model/request/create_contact_us_ticket_params.dart';

import '../../../../core/errors/app_errors.dart';
import '../../../../core/params/no_params.dart';
import '../../../../core/repositories/repository.dart';
import '../../../../core/results/result.dart';
import '../../data/model/response/about_us.dart';
import '../entity/about_us_entity.dart';
import '../entity/faq_entity.dart';
import '../entity/reasons_entity.dart';

abstract class IHelpRepository extends Repository {
  Future<Result<AppErrors, FaqListEntity>> getAllFaqs(NoParams param);

  Future<Result<AppErrors, ReasonsListEntity>> getAllReasons(NoParams param);

  Future<Result<AppErrors, EmptyResponse>> createContactUsTicket(
      CreateContactUsTicketParams param);

  Future<Result<AppErrors, AboutUsEntity>> getAboutUs(NoParams param);
}
