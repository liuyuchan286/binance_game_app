import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:binance_game_app/pages/bedside_agent/bedside_bedside_agent_hospital_page.dart';
import 'package:binance_game_app/pages/bedside_agent/bedside_bedside_agent_page.dart';
import 'package:binance_game_app/pages/bedside_agent/bedside_bedside_agent_save_or_update_page.dart';
import 'package:binance_game_app/pages/bedside_config/bedside_bedside_config_page.dart';
import 'package:binance_game_app/pages/bedside_config/bedside_bedside_config_save_or_update_page.dart';
import 'package:binance_game_app/pages/bedside_daily_statistics/bedside_bedside_daily_statistics_page.dart';
import 'package:binance_game_app/pages/bedside_daily_statistics/bedside_bedside_daily_statistics_save_or_update_page.dart';
import 'package:binance_game_app/pages/bedside_graphic_tutorial/bedside_bedside_graphic_tutorial_page.dart';
import 'package:binance_game_app/pages/bedside_graphic_tutorial/bedside_bedside_graphic_tutorial_save_or_update_page.dart';
import 'package:binance_game_app/pages/bedside_hospital/bedside_bedside_hospital_page.dart';
import 'package:binance_game_app/pages/bedside_hospital/bedside_bedside_hospital_save_or_update_page.dart';
import 'package:binance_game_app/pages/bedside_hospital_bed/bedside_bedside_hospital_bed_page.dart';
import 'package:binance_game_app/pages/bedside_hospital_bed/bedside_bedside_hospital_bed_save_or_update_page.dart';
import 'package:binance_game_app/pages/bedside_hospital_commission_config/bedside_bedside_hospital_commission_config_page.dart';
import 'package:binance_game_app/pages/bedside_hospital_commission_config/bedside_bedside_hospital_commission_config_save_or_update_page.dart';
import 'package:binance_game_app/pages/bedside_hospital_office/bedside_bedside_hospital_office_page.dart';
import 'package:binance_game_app/pages/bedside_hospital_office/bedside_bedside_hospital_office_save_or_update_page.dart';
import 'package:binance_game_app/pages/bedside_hospital_room/bedside_bedside_hospital_room_page.dart';
import 'package:binance_game_app/pages/bedside_hospital_room/bedside_bedside_hospital_room_save_or_update_page.dart';
import 'package:binance_game_app/pages/bedside_index_video_tutorial/bedside_bedside_index_video_tutorial_page.dart';
import 'package:binance_game_app/pages/bedside_index_video_tutorial/bedside_bedside_index_video_tutorial_save_or_update_page.dart';
import 'package:binance_game_app/pages/bedside_ops/bedside_bedside_ops_hospital_page.dart';
import 'package:binance_game_app/pages/bedside_ops/bedside_bedside_ops_page.dart';
import 'package:binance_game_app/pages/bedside_ops/bedside_bedside_ops_save_or_update_page.dart';
import 'package:binance_game_app/pages/bedside_order/bedside_bedside_order_page.dart';
import 'package:binance_game_app/pages/bedside_order/bedside_bedside_order_save_or_update_page.dart';
import 'package:binance_game_app/pages/bedside_order_commission/bedside_bedside_order_commission_page.dart';
import 'package:binance_game_app/pages/bedside_order_commission/bedside_bedside_order_commission_save_or_update_page.dart';
import 'package:binance_game_app/pages/bedside_order_unlock/bedside_bedside_order_unlock_page.dart';
import 'package:binance_game_app/pages/bedside_order_unlock/bedside_bedside_order_unlock_save_or_update_page.dart';
import 'package:binance_game_app/pages/bedside_problem/bedside_bedside_problem_page.dart';
import 'package:binance_game_app/pages/bedside_problem/bedside_bedside_problem_save_or_update_page.dart';
import 'package:binance_game_app/pages/bedside_refund_order/bedside_bedside_refund_order_page.dart';
import 'package:binance_game_app/pages/bedside_refund_order/bedside_bedside_refund_order_save_or_update_page.dart';
import 'package:binance_game_app/pages/bedside_statistics/bedside_statistics_commission_statistics_page.dart';
import 'package:binance_game_app/pages/bedside_statistics/bedside_statistics_income_statistics_month_page.dart';
import 'package:binance_game_app/pages/bedside_statistics/bedside_statistics_income_statistics_year_page.dart';
import 'package:binance_game_app/pages/bedside_statistics/bedside_statistics_incomestatistics_page.dart';
import 'package:binance_game_app/pages/bedside_statistics/bedside_statistics_table_statistics_page.dart';
import 'package:binance_game_app/pages/bedside_statistics/bedside_statistics_table_usage_statistics_page.dart';
import 'package:binance_game_app/pages/bedside_table/bedside_bedside_table_page.dart';
import 'package:binance_game_app/pages/bedside_table/bedside_bedside_table_save_or_update_page.dart';
import 'package:binance_game_app/pages/bedside_table_error/bedside_bedside_table_error_page.dart';
import 'package:binance_game_app/pages/bedside_table_error/bedside_bedside_table_error_save_or_update_page.dart';
import 'package:binance_game_app/pages/bedside_table_repairs/bedside_bedside_table_repairs_page.dart';
import 'package:binance_game_app/pages/bedside_table_repairs/bedside_bedside_table_repairs_save_or_update_page.dart';
import 'package:binance_game_app/pages/bedside_user/bedside_bedside_user_page.dart';
import 'package:binance_game_app/pages/bedside_user/bedside_bedside_user_save_or_update_page.dart';
import 'package:binance_game_app/pages/bedside_user_hospital_deposit/bedside_bedside_user_hospital_deposit_page.dart';
import 'package:binance_game_app/pages/bedside_user_hospital_deposit/bedside_bedside_user_hospital_deposit_save_or_update_page.dart';
import 'package:binance_game_app/pages/bedside_user_hospital_deposit_refund_order/bedside_bedside_user_hospital_deposit_refund_order_page.dart';
import 'package:binance_game_app/pages/bedside_user_hospital_deposit_refund_order/bedside_bedside_user_hospital_deposit_refund_order_save_or_update_page.dart';
import 'package:binance_game_app/pages/bedside_user_notice/bedside_bedside_user_notice_page.dart';
import 'package:binance_game_app/pages/bedside_user_notice/bedside_bedside_user_notice_save_or_update_page.dart';
import 'package:binance_game_app/pages/boot/boot_page.dart';
import 'package:binance_game_app/pages/hospital/hospital_update_page.dart';
import 'package:binance_game_app/pages/index/index_page.dart';
import 'package:binance_game_app/pages/login/login_page.dart';
import 'package:binance_game_app/pages/order/order_list_page.dart';
import 'package:binance_game_app/pages/reset_pwd/reset_pwd.dart';



Map<String, WidgetBuilder> routes = {
  BootPage.routeName : (context) => BootPage(),
  LoginPage.routeName : (context) => LoginPage(),
  IndexPage.routeName : (context) => IndexPage(),
  ResetPwd.routeName : (context,{arguments}) => ResetPwd(username: arguments,),
  OrderListPage.routeName : (context) => OrderListPage(),
  HospitalUpdatePage.routeName : (context) => HospitalUpdatePage(),
  BedsideBedsideOpsPage.routeName : (context) => BedsideBedsideOpsPage(),
  //运维
  BedsideBedsideOpsSaveOrUpadtePage.routeName : (context,{arguments}) => BedsideBedsideOpsSaveOrUpadtePage(dto: arguments,),
  BedsideBedsideOpsHospitalPage.routeName : (context,{arguments}) => BedsideBedsideOpsHospitalPage(dto: arguments,),
  //设备表
  BedsideBedsideTablePage.routeName : (context) => BedsideBedsideTablePage(),
  BedsideBedsideTableSaveOrUpadtePage.routeName : (context,{arguments}) => BedsideBedsideTableSaveOrUpadtePage(dto: arguments,),
  //开锁记录
  BedsideBedsideOrderUnlockPage.routeName : (context,{arguments}) => BedsideBedsideOrderUnlockPage(number: arguments,),
  BedsideBedsideOrderUnlockSaveOrUpadtePage.routeName : (context,{arguments}) => BedsideBedsideOrderUnlockSaveOrUpadtePage(dto: arguments,),
  //设备维修
  BedsideBedsideTableRepairsPage.routeName : (context,{arguments}) => BedsideBedsideTableRepairsPage(),
  BedsideBedsideTableRepairsSaveOrUpadtePage.routeName : (context,{arguments}) => BedsideBedsideTableRepairsSaveOrUpadtePage(dto: arguments,),
  //设备绑定错误
  BedsideBedsideTableErrorPage.routeName : (context,{arguments}) => BedsideBedsideTableErrorPage(),
  BedsideBedsideTableErrorSaveOrUpadtePage.routeName : (context,{arguments}) => BedsideBedsideTableErrorSaveOrUpadtePage(dto: arguments,),
  //代理商
  BedsideBedsideAgentPage.routeName : (context,{arguments}) => BedsideBedsideAgentPage(),
  BedsideBedsideAgentSaveOrUpadtePage.routeName : (context,{arguments}) => BedsideBedsideAgentSaveOrUpadtePage(dto: arguments,),
  BedsideBedsideAgentHospitalPage.routeName : (context,{arguments}) => BedsideBedsideAgentHospitalPage(dto: arguments,),

  //用户
  BedsideBedsideUserPage.routeName : (context,{arguments}) => BedsideBedsideUserPage(),
  BedsideBedsideUserSaveOrUpadtePage.routeName : (context,{arguments}) => BedsideBedsideUserSaveOrUpadtePage(dto: arguments,),

  //用户医院押金退款
  BedsideBedsideUserHospitalDepositRefundOrderPage.routeName : (context,{arguments}) => BedsideBedsideUserHospitalDepositRefundOrderPage(),
  BedsideBedsideUserHospitalDepositRefundOrderSaveOrUpadtePage.routeName : (context,{arguments}) => BedsideBedsideUserHospitalDepositRefundOrderSaveOrUpadtePage(dto: arguments,),

  //用户医院押金
  BedsideBedsideUserHospitalDepositPage.routeName : (context,{arguments}) => BedsideBedsideUserHospitalDepositPage(),
  BedsideBedsideUserHospitalDepositSaveOrUpadtePage.routeName : (context,{arguments}) => BedsideBedsideUserHospitalDepositSaveOrUpadtePage(dto: arguments,),

  //医院
  BedsideBedsideHospitalPage.routeName : (context,{arguments}) => BedsideBedsideHospitalPage(),
  BedsideBedsideHospitalSaveOrUpadtePage.routeName : (context,{arguments}) => BedsideBedsideHospitalSaveOrUpadtePage(dto: arguments,),

  //医院房间
  BedsideBedsideHospitalRoomPage.routeName : (context,{arguments}) => BedsideBedsideHospitalRoomPage(arguments),
  BedsideBedsideHospitalRoomSaveOrUpadtePage.routeName : (context,{arguments}) => BedsideBedsideHospitalRoomSaveOrUpadtePage(dto: arguments,),


  //医院科室
  BedsideBedsideHospitalOfficePage.routeName : (context,{arguments}) => BedsideBedsideHospitalOfficePage(arguments),
  BedsideBedsideHospitalOfficeSaveOrUpadtePage.routeName : (context,{arguments}) => BedsideBedsideHospitalOfficeSaveOrUpadtePage(dto: arguments,),

  //医院床位
  BedsideBedsideHospitalBedPage.routeName : (context,{arguments}) => BedsideBedsideHospitalBedPage(arguments),
  BedsideBedsideHospitalBedSaveOrUpadtePage.routeName : (context,{arguments}) => BedsideBedsideHospitalBedSaveOrUpadtePage(dto: arguments,),

  //医院分佣比例
  BedsideBedsideHospitalCommissionConfigPage.routeName : (context,{arguments}) => BedsideBedsideHospitalCommissionConfigPage(),
  BedsideBedsideHospitalCommissionConfigSaveOrUpadtePage.routeName : (context,{arguments}) => BedsideBedsideHospitalCommissionConfigSaveOrUpadtePage(dto: arguments,),

  //order
  BedsideBedsideOrderPage.routeName : (context,{arguments}) => BedsideBedsideOrderPage(),
  BedsideBedsideOrderSaveOrUpadtePage.routeName : (context,{arguments}) => BedsideBedsideOrderSaveOrUpadtePage(dto: arguments,),

    //refund order
  BedsideBedsideRefundOrderPage.routeName : (context,{arguments}) => BedsideBedsideRefundOrderPage(),
  BedsideBedsideRefundOrderSaveOrUpadtePage.routeName : (context,{arguments}) => BedsideBedsideRefundOrderSaveOrUpadtePage(dto: arguments,),

  //问题
  BedsideBedsideProblemPage.routeName : (context,{arguments}) => BedsideBedsideProblemPage(),
  BedsideBedsideProblemSaveOrUpadtePage.routeName : (context,{arguments}) => BedsideBedsideProblemSaveOrUpadtePage(dto: arguments,),

  //配置
  BedsideBedsideConfigPage.routeName : (context,{arguments}) => BedsideBedsideConfigPage(),
  BedsideBedsideConfigSaveOrUpadtePage.routeName : (context,{arguments}) => BedsideBedsideConfigSaveOrUpadtePage(dto: arguments,),

  //用户端公告
  BedsideBedsideUserNoticePage.routeName : (context,{arguments}) => BedsideBedsideUserNoticePage(),
  BedsideBedsideUserNoticeSaveOrUpadtePage.routeName : (context,{arguments}) => BedsideBedsideUserNoticeSaveOrUpadtePage(dto: arguments,),

  //用户端首页视频
  BedsideBedsideIndexVideoTutorialPage.routeName : (context,{arguments}) => BedsideBedsideIndexVideoTutorialPage(),
  BedsideBedsideIndexVideoTutorialSaveOrUpadtePage.routeName : (context,{arguments}) => BedsideBedsideIndexVideoTutorialSaveOrUpadtePage(dto: arguments,),


  //用户端图文
  BedsideBedsideGraphicTutorialPage.routeName : (context,{arguments}) => BedsideBedsideGraphicTutorialPage(),
  BedsideBedsideGraphicTutorialSaveOrUpadtePage.routeName : (context,{arguments}) => BedsideBedsideGraphicTutorialSaveOrUpadtePage(dto: arguments,),

  //order commission
  BedsideBedsideOrderCommissionPage.routeName : (context,{arguments}) => BedsideBedsideOrderCommissionPage(),
  BedsideBedsideOrderCommissionSaveOrUpadtePage.routeName : (context,{arguments}) => BedsideBedsideOrderCommissionSaveOrUpadtePage(dto: arguments,),

  //statistics
  BedsideBedsideDailyStatisticsPage.routeName : (context,{arguments}) => BedsideBedsideDailyStatisticsPage(),
  BedsideBedsideDailyStatisticsSaveOrUpadtePage.routeName : (context,{arguments}) => BedsideBedsideDailyStatisticsSaveOrUpadtePage(dto: arguments,),//statistics

  BedsideStatisticsIncomestatisticsPage.routeName : (context,{arguments}) => BedsideStatisticsIncomestatisticsPage(),
  BedsideStatisticsTableStatisticsPage.routeName : (context,{arguments}) => BedsideStatisticsTableStatisticsPage(),
  BedsideStatisticsIncomeStatisticsMonthPage.routeName : (context,{arguments}) => BedsideStatisticsIncomeStatisticsMonthPage(),
  BedsideStatisticsIncomeStatisticsYearPage.routeName : (context,{arguments}) => BedsideStatisticsIncomeStatisticsYearPage(),
  BedsideStatisticsCommissionStatisticsPage.routeName : (context,{arguments}) => BedsideStatisticsCommissionStatisticsPage(),
  BedsideStatisticsTableUsageStatisticsPage.routeName : (context,{arguments}) => BedsideStatisticsTableUsageStatisticsPage(),
};


final RouteFactory onGenerateRoute = (RouteSettings settings) {
  final String name = settings.name;
  final Function pageHandler = routes[name];
  if (pageHandler != null) {
    if (settings.arguments != null) {
      final Route route = CupertinoPageRoute(builder: (context) => pageHandler(context,arguments: settings.arguments));
      return route;
    }else {
      final Route route = CupertinoPageRoute(builder: (context) => pageHandler(context));
      return route;
    }
  }
};