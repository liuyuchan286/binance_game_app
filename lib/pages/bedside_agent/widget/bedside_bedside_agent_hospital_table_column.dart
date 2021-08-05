import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:binance_game_app/model/bedside_agent_hospital_table_column_model.dart';
import 'package:binance_game_app/model/bedside_bedside_hospital_list_model.dart';
import 'package:binance_game_app/model/bedside_bedside_ops_hospital_listbyopsid_model.dart';
import 'package:binance_game_app/widget/list_circle_checkbox.dart';

class BedsideBedsideAgentHospitalTableColumn<T extends BedsideAgentHospitalTableColumnModel> extends StatelessWidget {

  const BedsideBedsideAgentHospitalTableColumn({
    Key key,
    @required this.titleStyle,
    @required this.lineStyle,
    this.listData,
    this.selectsId,
  });

  final List<T> listData;
  final TextStyle titleStyle;
  final TextStyle lineStyle;
  final List<int> selectsId;

  @override
  Widget build(BuildContext context) {
    return Table(
      defaultVerticalAlignment: TableCellVerticalAlignment.middle,
      columnWidths: {
        0: FlexColumnWidth(2),
        1: FlexColumnWidth(7),
        2: FlexColumnWidth(1),
        3: FlexColumnWidth(1),
      },
      children: [
        // TableRow(children: [
        //   TableCell(child: Container(height: 40.h, child: Text('', style: titleStyle, textAlign: TextAlign.center,),),),
        //   TableCell(child: Text('', style: titleStyle, textAlign: TextAlign.center,),),
        //   TableCell(child: Text('',)),
        //   TableCell(child: Text('',)),
        // ]),
        for (int i = 0; i < (listData ?? []).length; i++)
          TableRow(
              decoration: BoxDecoration(color: Colors.white),
              children: [
                TableCell(
                  child: listData[i].disabled()? Icon(Icons.disabled_by_default) :ListCircleCheckbox(check:  selectsId.contains(listData[i].id),topPadding: 0,onChanged: (bool) {
                    if(bool) {
                      selectsId.add(listData[i].id);
                    }else {
                      selectsId.remove(listData[i].id);
                    }
                  },),
                ),
                TableCell(
                  child: Container(
                    padding: EdgeInsets.symmetric(vertical: 10.h),
                    height: 40.h,
                    child: Text(
                      listData[i].name,
                      style: lineStyle,
                      textAlign: TextAlign.left,
                    ),
                  ),
                ),
                TableCell(child: Text(""),),
                TableCell(child: Text("")),
              ]),
      ],
    );
  }
}
