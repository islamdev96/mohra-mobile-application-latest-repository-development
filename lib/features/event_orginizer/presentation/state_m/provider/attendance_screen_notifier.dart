import 'package:flutter/material.dart';
import 'package:starter_application/features/event/data/model/request/get_event_ticket_request.dart';
import 'package:starter_application/features/event_orginizer/data/model/request/manual_event_check_params.dart';
import 'package:starter_application/features/event_orginizer/presentation/state_m/cubit/event_orginizer_cubit.dart';
import '../../../../../core/common/costum_modules/screen_notifier.dart';
import '../../../../event/domain/entity/event_ticket_entity.dart';
import '../../../domain/entity/event_tickets_entity.dart';

class AttendanceScreenNotifier extends ScreenNotifier {
  /// Fields
  late BuildContext context;

  late EventTickettEntity eventTickettEntity;
  late EventTicketEntity eventTicketEntity;
  final eventOrginizerCubit = EventOrginizerCubit();
  /// Getters and Setters

  /// Methods

  @override
  void closeNotifier() {
    this.dispose();
  }

  getTicketDetails(){
    eventOrginizerCubit.getTicketDetails(GetEventTicketRequest(id :eventTickettEntity.id ));
  }

  onTicketDetailsLoaded(EventTicketEntity entity){
    this.eventTicketEntity = entity;
    notifyListeners();
  }
  
  onCheckTapped(){
    if(!eventTicketEntity.scanned){
      eventOrginizerCubit.manualCheckTicket(ManualCheckEventParams(eventId: eventTicketEntity.eventId!, ticketNumber: eventTicketEntity.number, isScanned: true));
    }
    else{

    }
  }

  onCheckedDone(){
    getTicketDetails();
  }

}
