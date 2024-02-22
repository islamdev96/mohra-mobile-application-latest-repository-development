import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:starter_application/core/errors/app_errors.dart';
import 'package:starter_application/core/models/empty_response.dart';
import 'package:starter_application/core/params/no_params.dart';
import 'package:starter_application/features/help/data/model/request/create_contact_us_ticket_params.dart';
import 'package:starter_application/features/help/data/model/response/faq_model.dart';
import 'package:starter_application/features/help/data/model/response/reasons_model.dart';

import '../../../../core/constants/enums/http_method.dart';
import '../../../../core/net/api_url.dart';
import '../../../../core/net/create_model_interceptor/null_response_model_interceptor.dart';
import '../model/response/about_us.dart';
import 'ihelp_remote.dart';

@Singleton(as: IHelpRemoteSource)
class HelpRemoteSource extends IHelpRemoteSource {
  @override
  Future<Either<AppErrors, FaqListModel>> getAllFaqs(NoParams param) {
    return request(
      converter: (json) => FaqListModel.fromJson(json),
      method: HttpMethod.GET,
      url: APIUrls.getAllFaqs,
    );
  }

  @override
  Future<Either<AppErrors, ReasonsListModel>> getAllReasons(NoParams param) {
    return request(
      converter: (json) => ReasonsListModel.fromJson(json),
      method: HttpMethod.GET,
      url: APIUrls.getAllReasons,
    );
  }

  @override
  Future<Either<AppErrors, EmptyResponse>> createContactUsTicket(
      CreateContactUsTicketParams param) {
    return request(
      converter: (json) => EmptyResponse.fromMap(json),
      method: HttpMethod.POST,
      url: APIUrls.createContactUsTicket,
      body: param.toMap(),
      createModelInterceptor: NullResponseModelInterceptor(),
    );
  }

  Future<Either<AppErrors, AboutUsModel>> getAboutUs(NoParams param) {
    return request(
      converter: (json) {
        return AboutUsModel.fromJson(json);
      },
      method: HttpMethod.GET,
      url: APIUrls.getAboutUs,
    );
  }
}
