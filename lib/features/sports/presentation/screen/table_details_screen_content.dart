import 'package:flutter/material.dart';
import 'package:flutter_html/flutter_html.dart';
import 'package:provider/provider.dart';
import 'package:starter_application/core/common/app_colors.dart';
import 'package:starter_application/generated/l10n.dart';

import '../screen/../state_m/provider/table_details_screen_notifier.dart';

class TableDetailsScreenContent extends StatelessWidget {
  late TableDetailsScreenNotifier sn;

  @override
  Widget build(BuildContext context) {
    sn = Provider.of<TableDetailsScreenNotifier>(context);
    sn.context = context;
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Container()



/*
       DataTable2(
          columnSpacing: 12,
          horizontalMargin: 12,
          smRatio: 0.75,
          lmRatio: 1.5,
          headingTextStyle: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 15,
              color: AppColors.white),
          headingRowColor: MaterialStateProperty.all(AppColors.greenColor),
          columns: [
            const DataColumn2(
              size: ColumnSize.S,
              label: Text(''),
            ),
            DataColumn2(
              size: ColumnSize.L,
              label: Text(
                Translation.current.team,
                style: const TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 15,
                ),
              ),
            ),
            const DataColumn2(
              size: ColumnSize.S,
              label: Text(
                'W',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 15,
                ),
              ),
            ),
            const DataColumn2(
              size: ColumnSize.S,
              label: Text(
                'D',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 15,
                ),
              ),
            ),
            const DataColumn2(
              size: ColumnSize.S,
              label: Text(
                'L',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 15,
                ),
              ),
              numeric: true,
            ),
            const DataColumn2(
              label: Text(
                'GF',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 15,
                ),
              ),
              numeric: true,
              size: ColumnSize.S,
            ),
            const DataColumn2(
              label: Text(
                'GA',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 15,
                ),
              ),
              numeric: true,
              size: ColumnSize.S,
            ),
            const DataColumn2(
              label: Text(
                'PTS',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 15,
                ),
              ),
              numeric: true,
              size: ColumnSize.S,
            ),
          ],
          rows: List<DataRow>.generate(
              20,
              (index) => DataRow(cells: [
                    DataCell(Text('$index ')),
                    DataCell(Text('Real Mardid')),
                    DataCell(Text('37')),
                    DataCell(Text('9')),
                    DataCell(Text('4')),
                    DataCell(Text('73')),
                    DataCell(Text('23')),
                    DataCell(Text('81')),
                  ])))
*/
    );
  }



}
