import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:binance_game_app/model/bedside_bedside_ops_hospital_listbyopsid_model.dart';
import 'package:binance_game_app/widget/list_circle_checkbox.dart';

class BedsideBedsideOpsHospitalTableColumn extends StatelessWidget {

  const BedsideBedsideOpsHospitalTableColumn({
    Key key,
    @required this.titleStyle,
    @required this.lineStyle,
    this.listData,
  });

  final List<BedsideBedsideOpsHospitalListbyopsidModel> listData;
  final TextStyle titleStyle;
  final TextStyle lineStyle;

  @override
  Widget build(BuildContext context) {
    return Table(
      defaultVerticalAlignment: TableCellVerticalAlignment.middle,
      columnWidths: {
        0: FlexColumnWidth(1),
        1: FlexColumnWidth(3),
        2: FlexColumnWidth(1),
        3: FlexColumnWidth(1),
      },
      children: [
        TableRow(children: [
          TableCell(child: Container(height: 40.h, child: Text('', style: titleStyle, textAlign: TextAlign.center,),),),
          TableCell(child: Text('医院名称', style: titleStyle, textAlign: TextAlign.center,),),
          TableCell(child: Text('自动推送', style: titleStyle, textAlign: TextAlign.center,),),
          TableCell(child: Text('自动派单', style: titleStyle, textAlign: TextAlign.center,),),
        ]),
        for (int i = 0; i < (listData ?? []).length; i++)
          TableRow(
              decoration: BoxDecoration(color: Colors.white),
              children: [
                TableCell(
                  child: ListCircleCheckbox(check:  listData[i].hospitalId,topPadding: 0,onChanged: (bool) {
                    this.listData[i].hospitalId = bool;
                  },),
                ),
                TableCell(
                  child: Container(
                    padding: EdgeInsets.symmetric(vertical: 10.h),
                    height: 40.h,
                    child: Text(
                      listData[i].name,
                      style: lineStyle,
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
                TableCell(
                  child: ListCircleCheckbox(topPadding: 0,check:  listData[i].autoPush,onChanged: (bool) {
                    this.listData[i].autoPush = bool;
                  },),
                ),
                TableCell(
                  child: ListCircleCheckbox(topPadding: 0,check:  listData[i].autoAssign,onChanged: (bool) {
                    this.listData[i].autoAssign = bool;
                  },),
                ),
              ]),
      ],
    );
  }
}
