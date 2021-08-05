
import 'package:binance_game_app/dto/bedside_statistics/bedside_statistics_dto.dart';
import 'package:binance_game_app/model/base/ret_model.dart';
import 'package:binance_game_app/model/bedside_statistics_model.dart';
import 'package:binance_game_app/utils/http.dart';
import 'package:binance_game_app/view_model/base/base_view_model.dart';

class BedsideStatisticsViewModel extends BaseViewModel {

  List<BedsideStatisticsModel> modelDatas;


  void bedsideBedsidestatisticsIncomestatistics(queryParameters) {
    BedsideStatisticsDto dto = BedsideStatisticsDto.fromJson(queryParameters);
    super.openLoading();
    Http.getInstance().get(dto.toJson(),path: "/bedside/bedsidestatistics/incomestatistics").then((RetModel value){

      modelDatas = [BedsideStatisticsModel.fromJson(value.data)];
      super.closeLoading();
    }).catchError((onError){
      super.closeLoading();
    });
  }


  void bedsideBedsidestatisticsTablestatistics(queryParameters) {
    BedsideStatisticsDto dto = BedsideStatisticsDto.fromJson(queryParameters);
    super.openLoading();
    Http.getInstance().get(dto.toJson(),path: "/bedside/bedsidestatistics/tablestatistics").then((RetModel value){

      modelDatas = [BedsideStatisticsModel.fromJson(value.data)];
      super.closeLoading();
    }).catchError((onError){
      super.closeLoading();
    });
  }

  void bedsideBedsidestatisticsIncomestatisticsMonth(queryParameters) {
    BedsideStatisticsDto dto = BedsideStatisticsDto.fromJson(queryParameters);
    super.openLoading();
    Http.getInstance().get(dto.toJson(),path: "/bedside/bedsidestatistics/incomestatisticsMonth").then((RetModel value){

      modelDatas = [BedsideStatisticsModel.fromJson(value.data)];
      super.closeLoading();
    }).catchError((onError){
      super.closeLoading();
    });
  }

  void bedsideBedsidestatisticsIncomestatisticsYear(queryParameters) {
    BedsideStatisticsDto dto = BedsideStatisticsDto.fromJson(queryParameters);
    super.openLoading();
    Http.getInstance().get(dto.toJson(),path: "/bedside/bedsidestatistics/incomestatisticsYear").then((RetModel value){

      modelDatas = [BedsideStatisticsModel.fromJson(value.data)];
      super.closeLoading();
    }).catchError((onError){
      super.closeLoading();
    });
  }

  void bedsideBedsidestatisticsCommissionStatistics(queryParameters) {
    BedsideStatisticsDto dto = BedsideStatisticsDto.fromJson(queryParameters);
    super.openLoading();
    Http.getInstance().get(dto.toJson(),path: "/bedside/bedsidestatistics/commissionStatistics").then((RetModel value){

      modelDatas = [BedsideStatisticsModel.fromJson(value.data)];
      super.closeLoading();
    }).catchError((onError){
      super.closeLoading();
    });
  }

  void bedsideBedsidestatisticsTableUsageStatistics(queryParameters) {
    BedsideStatisticsDto dto = BedsideStatisticsDto.fromJson(queryParameters);
    super.openLoading();
    Http.getInstance().get(dto.toJson(),path: "/bedside/bedsidestatistics/tableUsageStatistics").then((RetModel value){

      modelDatas = [BedsideStatisticsModel.fromJson(value.data)];
      super.closeLoading();
    }).catchError((onError){
      super.closeLoading();
    });
  }


}