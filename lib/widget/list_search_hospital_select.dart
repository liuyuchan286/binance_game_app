
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:binance_game_app/view_model/bedside_bedside_hospital_select/bedside_bedside_hospital_select_view_model.dart';
import 'package:binance_game_app/widget/list_select.dart';
import 'package:binance_game_app/widget/provider/provider_widget.dart';


class ListSearchHospitalSelect extends StatelessWidget {
  const ListSearchHospitalSelect({
    Key key,
    @required this.lineHeight,
    @required this.preferredSizeBoxh,
    @required this.topHeight,
    @required this.searchParam,
    this.onChange,
    this.hiddens
  }): super(key: key);

  final double lineHeight;
  final double preferredSizeBoxh;
  final double topHeight;
  final Map searchParam;
  final List<bool> hiddens;
  final Function onChange;

  @override
  Widget build(BuildContext context) {
    final List<bool> defaultHiddens = [false,false,false];
    return ProviderWidget(
      viewModel: BedsideBedsideHospitalSelectViewModel(),
      init: (BedsideBedsideHospitalSelectViewModel model) {
        model.bedsideBedsideHospitalListAll();
      },
      builder: (c,BedsideBedsideHospitalSelectViewModel model,_){
        if (model.loading) {
          return CupertinoActivityIndicator();
        }
        return Container(
          height: lineHeight,
          child: Row(
            children: [
              (hiddens ?? defaultHiddens)[0] ? Container() : Expanded(
                child: ListSelect(topHeight: topHeight,list: model.bedsideBedsideHospitalListModelDatas,onChange: (value){
                  if (model.bedsideBedsideHospitalListModelDatas[value].getKey() == null) {
                    searchParam.remove(model.bedsideBedsideHospitalListModelDatas[value].getParam());
                  }else {
                    searchParam[model.bedsideBedsideHospitalListModelDatas[value].getParam()] = model.bedsideBedsideHospitalListModelDatas[value].getKey();
                  }
                  if (onChange != null) {
                    this.onChange();
                  }
                  model.bedsideBedsideHospitalOfficeListAll(model.bedsideBedsideHospitalListModelDatas[value].getKey());
                }),
              ),
              (hiddens ?? defaultHiddens)[1] ? Container() : Expanded(
                child: ValueListenableBuilder(
                  valueListenable: model.officeValueNotifier,
                  builder: (_,__,___){
                    return model.officeValueNotifier.value.isEmpty ? CupertinoActivityIndicator() : ListSelect(topHeight: topHeight,list: model.officeValueNotifier.value,onChange: (value){
                      if (model.officeValueNotifier.value[value].getKey() == null) {
                        searchParam.remove(model.officeValueNotifier.value[value].getParam());
                      }else {
                        searchParam[model.officeValueNotifier.value[value].getParam()] = model.officeValueNotifier.value[value].getKey();
                      }
                      if (onChange != null) {
                        this.onChange();
                      }
                      model.bedsideBedsideHospitalRoomListAll(model.officeValueNotifier.value[value].getKey());
                    },);
                  },
                ),
              ),
              (hiddens ?? defaultHiddens)[2] ? Container() : Expanded(
                child: ValueListenableBuilder(
                  valueListenable: model.roomValueNotifier,
                  builder: (_,__,___){
                    return model.roomValueNotifier.value.isEmpty ? CupertinoActivityIndicator() : ListSelect(topHeight: topHeight,list: model.roomValueNotifier.value,onChange: (value){
                      if (model.roomValueNotifier.value[value].getKey() == null) {
                        searchParam.remove(model.roomValueNotifier.value[value].getParam());
                      }else {
                        searchParam[model.roomValueNotifier.value[value].getParam()] = model.roomValueNotifier.value[value].getKey();
                      }
                      if (onChange != null) {
                        this.onChange();
                      }
                    },);
                  },
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}