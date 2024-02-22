import 'package:dartz/dartz.dart';
import 'package:starter_application/core/models/empty_response.dart';
import 'package:starter_application/features/help/data/model/request/create_contact_us_ticket_params.dart';
import '../../../../core/datasources/remote_data_source.dart';
import '../../../../core/errors/app_errors.dart';
import '../../../../core/params/no_params.dart';
import '../model/response/about_us.dart';
import '../model/response/faq_model.dart';
import '../model/response/reasons_model.dart';

abstract class IHelpRemoteSource extends RemoteDataSource {
  Future<Either<AppErrors, FaqListModel>> getAllFaqs(NoParams param);

  Future<Either<AppErrors, ReasonsListModel>> getAllReasons(NoParams param);

  Future<Either<AppErrors, AboutUsModel>> getAboutUs(NoParams param);

  Future<Either<AppErrors, EmptyResponse>> createContactUsTicket(
      CreateContactUsTicketParams param);
}
