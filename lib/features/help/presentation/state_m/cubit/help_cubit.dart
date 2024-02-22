import 'package:bloc/bloc.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:meta/meta.dart';
import 'package:starter_application/core/params/no_params.dart';
import 'package:starter_application/features/help/data/model/request/create_contact_us_ticket_params.dart';
import 'package:starter_application/features/help/domain/entity/faq_entity.dart';
import 'package:starter_application/features/help/domain/usecase/create_contact_us_ticket_use_case.dart';
import 'package:starter_application/features/help/domain/usecase/getAllReasons.dart';
import '../../../../../core/errors/app_errors.dart';
import '../../../../../di/service_locator.dart';
import '../../../domain/entity/about_us_entity.dart';
import '../../../domain/entity/reasons_entity.dart';
import '../../../domain/usecase/getAboutUs.dart';
import '../../../domain/usecase/getAllFaqs.dart';
import 'help_cubit.dart';

part 'help_state.dart';

part 'help_cubit.freezed.dart';

class HelpCubit extends Cubit<HelpState> {
  HelpCubit() : super(const HelpState.helpInitState());

  getAllFaqs(NoParams param) async {
    emit(const HelpState.helpLoadingState());
    final result = await getIt<GetAllFaqsUseCase>()(param);
    result.pick(
      onData: (data) => emit(HelpState.faqListLoaded(data)),
      onError: (error) => emit(HelpState.helpErrorState(error, () {
        this.getAllFaqs(param);
      })),
    );
  }

  getAllReasons(NoParams param) async {
    emit(const HelpState.helpLoadingState());
    final result = await getIt<GetAllReasonsUseCase>()(param);
    result.pick(
      onData: (data) => emit(HelpState.reasonsListLoaded(data)),
      onError: (error) => emit(HelpState.helpErrorState(error, () {
        this.getAllReasons(param);
      })),
    );
  }

  createTicket(CreateContactUsTicketParams param) async {
    emit(const HelpState.createContactUsTicketLoading());
    final result = await getIt<CreateContactUSTicketUseCase>()(param);
    result.pick(
      onData: (data) => emit(const HelpState.createContactUsTicketLoaded()),
      onError: (error) => emit(HelpState.helpErrorState(error, () {
        this.createTicket(param);
      })),
    );
  }

  getAboutUs(NoParams param) async {
    emit(const HelpState.helpLoadingState());
    final result = await getIt<GetAboutUsUseCase>()(param);
    result.pick(
      onData: (data) => emit(HelpState.getAboutUsLoaded(data)),
      onError: (error) => emit(HelpState.helpErrorState(error, () {
        this.getAboutUs(param);
      })),
    );
  }
}
