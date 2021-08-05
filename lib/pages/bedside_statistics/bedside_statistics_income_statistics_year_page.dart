import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:binance_game_app/model/bedside_bedside_ops_list_model.dart';
import 'package:binance_game_app/model/search_model.dart';
import 'package:binance_game_app/pages/bedside_statistics/simple_line.dart';
import 'package:binance_game_app/view_model/bedside_bedside_ops/bedside_bedside_ops_view_model.dart';
import 'package:binance_game_app/view_model/bedside_statistics/bedside_statistics_viewmodel.dart';
import 'package:binance_game_app/widget/list_search_hospital_select.dart';
import 'package:binance_game_app/widget/list_search_text_field.dart';
import 'package:binance_game_app/widget/list_select.dart';
import 'package:binance_game_app/widget/provider/provider_widget.dart';



class BedsideStatisticsIncomeStatisticsYearPage extends StatelessWidget {

  static const routeName = '/bedsidestatisticsincomestatisticsyearPage';


  BedsideBedsideOpsPage() {
    print("print");
  }

  BedsideStatisticsViewModel _bedsideStatisticsViewModel = BedsideStatisticsViewModel();

  final TextEditingController searchController = TextEditingController();

  DateTimeRange _range;
  List<SearchModel> searchList = [
    SearchModel(key: 1,value: "参数名",param: "name"),
  ];

  Map searchParam = {
  };

  int currentSearchListIndex = 0;

  final double lineHeight = 30.h;
  final double preferredSizeBoxh = 15.h;
  bool check = false;

  @override
  Widget build(BuildContext context) {
    double preferredSizeHeight = (lineHeight + preferredSizeBoxh) * 2 - lineHeight;
    return Scaffold(
        appBar: AppBar(
          title: GestureDetector(
              onDoubleTap: () {
              },
              child: Text("收入统计(按年)",)
          ),
          bottom: PreferredSize(
            preferredSize: Size(double.infinity, preferredSizeHeight),
            child: Container(
              padding: EdgeInsets.symmetric(vertical: preferredSizeBoxh,horizontal: 15.w),
              child: Column(
                children: [
                  // Container(
                  //   height: lineHeight,
                  //   child: Row(
                  //     children: [
                  //       ListSelect(topHeight: preferredSizeHeight,list: searchList,onChange: (value){
                  //         this.currentSearchListIndex = value;
                  //       },),
                  //       SizedBox(width: 8.w,),
                  //       ListSearchTextField(
                  //         width: 190.w,
                  //         controller: searchController,
                  //         onTap: () {
                  //           refreshList();
                  //         },
                  //       ),
                  //       SizedBox(width: 15.w,),
                  //       GestureDetector(
                  //         onTap: () async {
                  //           DateTimeRange range = await showDateRangePicker(
                  //             context: context,
                  //             firstDate: DateTime(DateTime.now().year - 10),
                  //             lastDate: DateTime(DateTime.now().year + 2),
                  //             initialDateRange: _range,
                  //             saveText: "确定",
                  //           );
                  //           _range = range;
                  //           print(range.start);
                  //           print(range.end);
                  //
                  //           searchParam['startTime'] = range.start.toString();
                  //           searchParam['endTime'] = range.end.toString();
                  //
                  //         },
                  //         child: Image.asset("assets/images/date-icon.png",
                  //           width: 22.w,
                  //           height: 22.h,
                  //         ),
                  //       )
                  //     ],
                  //   ),
                  // ),
                  SizedBox(height: preferredSizeBoxh,),
                  ListSearchHospitalSelect(lineHeight: lineHeight, preferredSizeBoxh: preferredSizeBoxh, searchParam: searchParam,topHeight: preferredSizeHeight,hiddens: [false,false,true],onChange: () {
                    refreshList();
                  },),
                ],
              ),
            ),
          ),
        ),
        body: Container(
          padding: EdgeInsets.symmetric(vertical: 20.h),
          child: ProviderWidget(
            viewModel: _bedsideStatisticsViewModel,
            init: (BedsideStatisticsViewModel model){
              _range = DateTimeRange(start: DateTime.now().subtract(Duration(days:720)), end: DateTime.now().add(Duration(days:360)));
              searchParam['startTime'] = _range.start.toString();;
              searchParam['endTime'] = _range.end.toString();
              model.bedsideBedsidestatisticsIncomestatisticsYear(searchParam);
            },
            builder: (_,BedsideStatisticsViewModel model,c){
              if(model.loading) {
                return Center(child: CupertinoActivityIndicator());
              }
              return SimpleLineChart.withSampleData(model.modelDatas.first.createSampleData());
            },
          ),
        )
    );
  }

  refreshList() {
    _bedsideStatisticsViewModel.bedsideBedsidestatisticsIncomestatisticsYear(searchParam);
  }
}
