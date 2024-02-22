import 'package:flutter/material.dart';
import 'package:starter_application/core/params/screen_params/remove_group_member_params.dart';
import 'package:starter_application/features/friend/domain/entity/client_entity.dart';

import '../../../../../core/common/costum_modules/screen_notifier.dart';

class RemoveGroupMembersScreenNotifier extends ScreenNotifier {
  /// Fields
  late BuildContext context;

  late RemoveGroupMemberParams params;

  /// Getters and Setters

  /// Methods

  @override
  void closeNotifier() {
    this.dispose();
  }

  void onMemberRemoved(ClientEntity removedMember) {
    params.clients.removeWhere((element) => element.id == removedMember.id);
    notifyListeners();
  }
}
