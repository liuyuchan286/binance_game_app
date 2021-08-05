import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:binance_game_app/constant/theme_colors.dart';
import 'package:binance_game_app/model/list_table_column_model.dart';


class ListTableColumn extends StatelessWidget {

  final double leftWidth;
  final double rightWidth;

  List<ListTableColumnModel> dataList;

  ListTableColumn({this.leftWidth = 2, this.rightWidth = 3,this.dataList});

  @override
  Widget build(BuildContext context) {
    final TextStyle leftStyle = Theme.of(context).textTheme.headline2.copyWith(fontWeight: FontWeight.w500,height: 2);
    final TextStyle rightStyle = Theme.of(context).textTheme.headline2.copyWith(color: ThemeColors.COLOR_333333,height: 2);

    final TextStyle onTabStyle = Theme.of(context).textTheme.headline2.copyWith(color: Colors.blue,height: 2);
    return Expanded(
      child: Table(
        columnWidths: {
          0 : FlexColumnWidth(this.leftWidth),
          1 : FlexColumnWidth(this.rightWidth),
        },
        defaultVerticalAlignment: TableCellVerticalAlignment.bottom,
        children: [
          for (ListTableColumnModel data in dataList ?? [])
            TableRow(
                children: [
                  TableCell(child: Text('${data.key}' ,style: leftStyle),verticalAlignment: TableCellVerticalAlignment.top,),
                  TableCell(
                    child: data.onTab != null ? InkWell(
                      onTap: () {
                        data.onTab();
                      },
                      child: Text('${data.value}',
                          style: onTabStyle,
                      ),
                    ) : SelectableText('${data.value}',
                      style: rightStyle,
                    ),
                    verticalAlignment: TableCellVerticalAlignment.top,
                  ),
                ]
            ),
        ],
      ),
    );
  }
}
