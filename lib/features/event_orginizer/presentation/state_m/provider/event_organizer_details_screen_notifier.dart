import 'package:flutter/material.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';
import 'package:starter_application/core/errors/app_errors.dart';
import 'package:starter_application/core/results/result.dart';
import 'package:starter_application/di/service_locator.dart';
import 'package:starter_application/features/event/data/model/request/get_my_running_events_param.dart';
import 'package:starter_application/features/event/data/model/request/scan_ticket_qr_code_param.dart';
import 'package:starter_application/features/event_orginizer/data/model/request/event_details_params.dart';
import 'package:starter_application/features/event_orginizer/domain/entity/get_ticket_report_response_entity.dart';
import 'package:starter_application/features/event_orginizer/domain/usecase/get_event_ticketss_usecase.dart';
import 'package:starter_application/features/notification/data/model/request/get_all_notification_param.dart';
import 'package:starter_application/generated/l10n.dart';
import '../../../../../core/common/costum_modules/screen_notifier.dart';
import '../../../../../core/navigation/nav.dart';
import '../../../../Event Organizer/data/models/event_status.dart';
import '../../../../event/presentation/screen/ticket_qrCode_screen.dart';
import '../../../domain/entity/event_tickets_entity.dart';
import '../../../domain/entity/my_running_events_entity.dart';
import '../cubit/event_orginizer_cubit.dart';

class EventOrganizerDetailsScreenNotifier extends ScreenNotifier {
  /// Fields
  late BuildContext context;
  late EventItemEntity eventItemEntity;
  RefreshController refreshController = RefreshController();
  TextEditingController search = TextEditingController();
  bool isLoading = true;
  bool isSearch = false;
  String? sorting;
  String? keySorting;
  bool isSearchBody = false;
  int? ticketTypes = null;
  bool? isScanned = null;
  final List<String> ticketList = [
    'Silver',
    'Golden',
    'Platinum',
    'VIP',
    'Free'
  ];
  List<String> tickeTrtList = [
    Translation.current.silver_ticket,
    Translation.current.gold_ticket,
    Translation.current.platinum_ticket,
    Translation.current.vip_ticket,
    Translation.current.free_ticket,
  ];
  String? searchText;
  SnackBar snackBar = SnackBar(
    backgroundColor: const Color(0xFF039855),
    elevation: 0,
    content: Row(
      children: [
        Image.asset(
          "assets/images/circle_check.png",
          height: 28,
          width: 28,
        ),
        const Padding(
          padding: EdgeInsets.only(left: 8.0),
          child: Text('Checked-In!\nTap here to open ticket details !',
              style: TextStyle(color: Colors.white)),
        ),
        const Spacer(),
        const Icon(
          Icons.close,
          color: Colors.white,
        )
      ],
    ),
  );
  SnackBar snackBar2 = SnackBar(
    backgroundColor: const Color(0xFFD92D20),
    elevation: 0,
    content: Row(
      children: [
        Image.asset(
          "assets/images/error.png",
          height: 28,
          width: 28,
        ),
        const Padding(
          padding: EdgeInsets.only(left: 8.0),
          child: Text('Cannot Read Ticket!\nTap to checkin manually!',
              style: TextStyle(color: Colors.white)),
        ),
        const Spacer(),
        const Icon(
          Icons.close,
          color: Colors.white,
        )
      ],
    ),
  );

  // late EventTicketssEntity eventTicketsEntity;
  final List<EventStatus> eventList = [];
  List<EventTickettEntity> eventTicket = [];
  EventOrginizerCubit eventCubit = EventOrginizerCubit();
  GetTicketReportResponseEntity? getTicketReportResponseEntity;
  List<String> itemList = [
    'Name: A-Z',
    'Name: Z-A',
    'Price: low to high',
    'Price: high to low'
  ];
  List<String> itemTrList = [
    Translation.current.Name_A_Z,
    Translation.current.Name_Z_A,
    Translation.current.Price_low_to_high,
    Translation.current.Price_high_to_low
  ];

  /// Getters and Setters

  setTicketReportResponseEntity(
      GetTicketReportResponseEntity getTicketReportResponseEntity) {
    this.getTicketReportResponseEntity = getTicketReportResponseEntity;
    notifyListeners();
  }

  /// Methods
  void changeSearchBody() {
    isSearchBody = !isSearchBody;
    notifyListeners();
  }

  void changeAll() {
    isSearchBody = false;
    isSearch = false;
    notifyListeners();
  }

  void change() {
    isSearch = !isSearch;
    eventTicket.clear();
    search.clear();
    searchText = null;
    notifyListeners();
  }

  void changeIsSearch() {
    isSearch = !isSearch;
    notifyListeners();
  }

  double getProgress() {
    if (this.getTicketReportResponseEntity != null) {
      if (getTicketReportResponseEntity!.allTicketCount != 0 &&
          getTicketReportResponseEntity!.ticketScannedCount != 0) {
        return getTicketReportResponseEntity!.ticketScannedCount! /
            getTicketReportResponseEntity!.allTicketCount!;
      } else {
        return 0;
      }
    } else {
      return 0;
    }
  }

  sortEventsList(String key) {
    switch (key) {
      case "Name: A-Z":
        {
          sorting = "Title DESC";
          keySorting = "Name: A-Z";
          eventTicket.clear();
          getEventTickets();
          // eventTicket.sort((a, b) {
          //   return a.name.compareTo(b.name);
          // });
          break;
        }
      case "Name: Z-A":
        {
          sorting = "Title ASC";
          keySorting = "Name: Z-A";
          eventTicket.clear();
          getEventTickets();
          // eventTicket.sort((a, b) {
          //   return b.name.compareTo(a.name);
          // });
          break;
        }
      case "Price: low to high":
        {
          sorting = "Price ASC";
          keySorting = "Price: low to high";
          eventTicket.clear();
          getEventTickets();
          break;
        }
      case "Price: high to low":
        {
          sorting = "Price ASC";
          keySorting = "Price: high to low";
          eventTicket.clear();
          getEventTickets();
          break;
        }
    }
    Nav.pop();
    notifyListeners();
  }

  @override
  void closeNotifier() {
    this.dispose();
  }

  fetchData() {
    for (ClientAttEntity clientEntity in eventItemEntity.clients) {
      eventList.add(EventStatus(
        avatar: clientEntity.imageUrl,
        userName: clientEntity.fullName,
        eventId: eventItemEntity.id.toString(),
        status: eventItemEntity.status.toString(),
      ));
    }
  }

  getEventTickets() {
    eventTicket.clear();
    loading(true);
    eventCubit.getEventTicketss(GetEventTicketsParam(
        EventId: eventItemEntity.id,
        sorting: sorting,
        typeId: ticketTypes,
        IsScanned: isScanned,
        keyword: searchText));
  }

  getTicketReport() {
    eventCubit.getTicketReport(EventDetailsParams(id: eventItemEntity.id));
  }

  scanTicketQrCode() {
    eventCubit.scanTicketQrCode(
        ScanTicketQrCodeParam(qrCode: "eventItemEntity.id", eventId: 1));
  }

  onEventTicketsLoaded(EventTicketssEntity entity) {
    eventTicket = entity.items;
    notifyListeners();
  }

  callback() {
    print("asdasdas");
  }

  scan() async {
    Nav.to(TicketQrCodeScreen.routeName,
            arguments: TicketQrCodeScreenParam(
                onDispose: () {}, eventId: eventItemEntity.id))
        .then((value) {
      clearAll();
      getEventTickets();
      getTicketReport();
    });
    /*String barcode = await scanner.scan();
    if (barcode == null) {
      Navigator.of(context).push(
          MaterialPageRoute(builder: (context) => ManualCheckIn())
      );
      ScaffoldMessenger.of(context).showSnackBar(snackBar2);
      print('nothing return.');
    } else {
      Navigator.of(context).push(
          MaterialPageRoute(builder: (context) => const EventDetails())
      );
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
      print("bar============"+barcode);
    }*/
  }

  void loading(value) {
    isLoading = value;
    notifyListeners();
  }

  clearAll() {
    ticketTypes = null;
    isScanned = null;
    sorting = null;
    keySorting = null;
  }

  Future<Result<AppErrors, List<EventTickettEntity>>> getEventsTicketItems(
      int unit) async {
    if (unit == 0) {
      clearAll();
      getTicketReport();
    }
    final result = await getIt<GetEventTicketssUseCase>()(GetEventTicketsParam(
        skipCount: unit * 10,
        maxResultCount: 10,
        EventId: eventItemEntity.id,
        sorting: sorting,
        typeId: ticketTypes,
        IsScanned: isScanned,
        keyword: searchText));

    return Result<AppErrors, List<EventTickettEntity>>(
        data: result.data!.items, error: result.error);
  }

  void onEventsTicketItemsFetched(
      List<EventTickettEntity> items, int nextUnit) {
    eventTicket = items;
    notifyListeners();
  }

  void EventsTicketLoaded(EventTicketssEntity list) {
    eventTicket = list.items;
    notifyListeners();
  }
}
