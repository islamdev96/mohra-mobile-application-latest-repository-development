import 'dart:io';
import 'dart:typed_data';

import 'package:external_path/external_path.dart';
import 'package:flutter/material.dart';
import 'package:flutter_share/flutter_share.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:permission_handler/permission_handler.dart';
import 'package:starter_application/core/common/dynamic_links.dart';
import 'package:starter_application/core/common/utils.dart';
import 'package:starter_application/core/constants/app/app_constants.dart';
import 'package:starter_application/core/errors/app_errors.dart';
import 'package:starter_application/core/params/screen_params/ticket_details_screen_params.dart';
import 'package:starter_application/core/ui/error_ui/error_viewer/error_viewer.dart';
import 'package:starter_application/features/event/data/model/request/get_event_ticket_request.dart';
import 'package:starter_application/features/event/domain/entity/event_ticket_entity.dart';
import 'package:starter_application/features/event/presentation/state_m/cubit/event_cubit.dart';
import 'package:starter_application/features/event/presentation/widget/event_ticket_details_widget.dart';
import 'package:starter_application/generated/l10n.dart';

import '../../../../../core/common/costum_modules/screen_notifier.dart';

class TicketDetailsScreenNotifier extends ScreenNotifier {
  /// Fields

  late BuildContext context;
  late TicketDetailsScreenParams params;
  bool isLoading = false;
  List<EventTicketEntity> tickets = [];
  EventCubit eventCubit = EventCubit();
  bool _isDownloadPdfLoading = false;
  TicketDetailsScreenNotifier(TicketDetailsScreenParams params) {
    this.params = params;
    print('sddfffsdfdsdfs');
    print(params.id);
    if (params.createEventTicketEntity != null)
      tickets = params.createEventTicketEntity!.tickets;
    else if (params.myTicketsEntity != null)
      tickets = params.myTicketsEntity!.tickets;
    else {
      getTickets();
    }
  }

  /// Getters and Setters
  getTickets() {
    isLoading = true;
    eventCubit.getTicket(GetEventTicketRequest(id: params.id));
    notifyListeners();
  }

  setTickets(EventTicketEntity eventTicketEntity) {
    tickets.add(eventTicketEntity);
    isLoading = false;
    notifyListeners();
  }

  bool get isDownloadPdfLoading => _isDownloadPdfLoading;

  set isDownloadPdfLoading(bool value) {
    _isDownloadPdfLoading = value;
    notifyListeners();
  }

  /// Methods
  int getId() {
    if (params.myTicketsEntity != null)
      return params.myTicketsEntity!.tickets.first.id!;
    if (params.createEventTicketEntity != null)
      return params.createEventTicketEntity!.tickets.first.id!;
    if (params.id != null)
      return params.id!;
    else
      return params.id!;
  }

  void shareTicket() async {
    DynamicLinkService dynamicLinkService = DynamicLinkService();
    Uri uri = await dynamicLinkService.createDynamicLink(
        queryParameters: {'id': getId().toString()},
        type: AppConstants.KEY_DYNAMIC_LINKS_TICKET);
    FlutterShare.share(
      title: uri.toString(),
      linkUrl: uri.toString(),
    );
  }

  void downloadPdf() async {
    if (!await Permission.storage.request().isGranted) return;
    isDownloadPdfLoading = true;
    pw.Document pdf = pw.Document();

    tickets.forEach((element) async {
      Uint8List? data;
      await element.screenShotController
          .captureFromWidget(
        EventTicketDetailsWidget(
          ticket: element,
          con: this.context,
        ),
      )
          .then((value) async {
        data = value;
        if (data != null) {
          pdf.addPage(
            pw.Page(
              pageFormat: PdfPageFormat.a4,
              build: (context) {
                return pw.Expanded(
                  child: pw.Image(pw.MemoryImage(data!.buffer.asUint8List())),
                );
              },
            ),
          );
        }
        if (element.id == tickets.last.id) {
          String path =
              await createFolder(type: ExternalPath.DIRECTORY_DOCUMENTS);
          File pdfFile = File('${path}/tickets_${element.number}.pdf');
          pdfFile.writeAsBytesSync(await pdf.save());
          ErrorViewer.showError(
              context: context,
              error: CustomError(
                  message: Translation.current.pdf_downloaded + path),
              callback: () {});
          isDownloadPdfLoading = false;
        }
      });
    });
  }

  @override
  void closeNotifier() {
    this.dispose();
  }
}
