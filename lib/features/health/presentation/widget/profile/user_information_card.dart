import 'package:flutter/material.dart';
import 'package:starter_application/features/health/presentation/widget/profile/one_user_info_carrd.dart';
import 'package:starter_application/generated/l10n.dart';

class UserInformationCard extends StatelessWidget {
  //final double? height;
  final double width;
  final String firstName, lastName, dateOfBirth, sex, medicalCondition;

  UserInformationCard({
    // this.height,
    required this.width,
    required this.firstName,
    required this.lastName,
    required this.dateOfBirth,
    required this.sex,
    required this.medicalCondition,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
        //height: height,
        width: width,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: Color(0xff15994D),
        ),
        child: Column(
          children: [
            OneUserInfoCard(
                infoKey: Translation.current.firstName,
                infoValue: '$firstName',
                dividerWidth: width * .95),
            OneUserInfoCard(
                infoKey: Translation.current.lastName,
                infoValue: '$lastName',
                dividerWidth: width * .95),
            OneUserInfoCard(
                infoKey: Translation.current.birth_date,
                infoValue: '$dateOfBirth',
                dividerWidth: width * .95),
            OneUserInfoCard(
                infoKey: Translation.current.gender,
                infoValue: '$sex',
                dividerWidth: width * .95),
            OneUserInfoCard(
              infoKey: Translation.current.medical_conditions,
              infoValue: '$medicalCondition',
              dividerWidth: width * .95,
              withDivider: false,
            ),
          ],
        ));
  }
}
