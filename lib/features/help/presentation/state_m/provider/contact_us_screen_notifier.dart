import 'package:flutter/material.dart';
import 'package:starter_application/core/common/app_config.dart';
import 'package:starter_application/core/models/user_session_data_model.dart';
import 'package:starter_application/core/params/no_params.dart';
import 'package:starter_application/core/ui/snackbars/show_snackbar.dart';
import 'package:starter_application/features/help/data/model/request/create_contact_us_ticket_params.dart';
import 'package:starter_application/generated/l10n.dart';
import '../../../../../core/common/costum_modules/screen_notifier.dart';
import '../../../domain/entity/reasons_entity.dart';
import '../cubit/help_cubit.dart';

class ContactUsScreenNotifier extends ScreenNotifier {
  /// Fields
  late BuildContext context;
  late ReasonsListEntity reasonsListEntity ;

  final helpCubit=HelpCubit();
  TextEditingController subjectController=TextEditingController();
  TextEditingController descriptionController=TextEditingController();
  late ReasonsItemEntity _selectedReason ;
  int selectedReasonId=-1;
  List<String> reasonsStrings=[];

  /// Getters and Setters

  /// Methods

  getAllReasonsList(){
    helpCubit.getAllReasons(NoParams());
  }
  onReasonsListLoaded(ReasonsListEntity entity) async{
    reasonsListEntity=entity;
    if(reasonsListEntity.items.isNotEmpty){
      selectedReason=reasonsListEntity.items[0];
      selectedReasonId=reasonsListEntity.items[0].id!;
      await fetchReasons();
    }
    notifyListeners();
  }

  onCreateTapped(){
    print(selectedReasonId);
    if(subjectController.text.isEmpty || descriptionController.text.isEmpty || selectedReasonId == -1){
      showSnackbar(Translation.current.all_fields_required);
    }
    else{
      create();
    }
  }

  create(){
    CreateContactUsTicketParams contactUsTicketParams = CreateContactUsTicketParams(type: selectedReasonId, userId: UserSessionDataModel.userId, title: subjectController.text, textTicket: descriptionController.text);
    helpCubit.createTicket(contactUsTicketParams);
  }

  onTicketCreated(){
    subjectController.clear();
    descriptionController.clear();
  }

  fetchReasons() async{
    if(reasonsListEntity.items!=null){
      for(ReasonsItemEntity reason in reasonsListEntity.items){
        reasonsStrings.add(reason.enTitle!);
      }
    }

  }

  @override
  void closeNotifier() {
    this.dispose();
  }


  getText(ReasonsItemEntity reasonsItemEntity){
    if(AppConfig().appLanguage == 'en'){
      return reasonsItemEntity.enTitle;
    }
    else{
      return reasonsItemEntity.arTitle;
    }
  }

  ReasonsItemEntity get selectedReason => _selectedReason;

  set selectedReason(ReasonsItemEntity value) {
    _selectedReason = value;
    selectedReasonId = selectedReason.id!;
    notifyListeners();
  }
}
