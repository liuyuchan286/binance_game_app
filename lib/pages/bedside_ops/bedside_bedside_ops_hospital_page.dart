import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:binance_game_app/dto/bedside_bedside_ops/bedside_bedsideopshospital_save_dto.dart';
import 'package:binance_game_app/dto/save_or_upadte/save_or_update_dto.dart';
import 'package:binance_game_app/model/bedside_bedside_ops_hospital_listbyopsid_model.dart';
import 'package:binance_game_app/model/bedside_bedside_ops_list_model.dart';
import 'package:binance_game_app/pages/bedside_ops/widget/bedside_bedside_ops_hospital_table_column.dart';
import 'package:binance_game_app/pages/hospital/widget/hospital_usetime_list.dart';
import 'package:binance_game_app/view_model/bedside_bedside_ops/bedside_bedside_ops_view_model.dart';
import 'package:binance_game_app/widget/list_circle_checkbox.dart';
import 'package:binance_game_app/widget/prefixicon_text_field.dart';
import 'package:binance_game_app/widget/provider/provider_widget.dart';

class BedsideBedsideOpsHospitalPage extends StatelessWidget {
  static const routeName = '/bedsideBedsideOpsHospitalPage';

  SaveOrUpdateDto dto;

  BedsideBedsideOpsHospitalPage({this.dto});

  final BedsideBedsideOpsViewModel _bedsideBedsideOpsViewModel =
      BedsideBedsideOpsViewModel();

  final TextEditingController nameController =
      new TextEditingController(text: "");

  @override
  Widget build(BuildContext context) {
    final TextStyle titleStyle =
        Theme.of(context).textTheme.headline1.copyWith(fontSize: 14.ssp);

    final TextStyle lineStyle = Theme.of(context).textTheme.headline5;
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "运维-设置医院",
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            PrefixiconTextField(
              prefixText: "运维人员名称",
              hintText: "请输入运维人员名称",
              readOnly: true,
              textEditingController: nameController,
            ),
            PrefixiconTextField(prefixText: "医院", hintText: "", readOnly: true),
            ProviderWidget(
                init: (BedsideBedsideOpsViewModel model) {
                  if (this.dto.id != null) {
                    model.bedsideBedsideopshospitalListByOpsId(dto.id);
                    model.bedsideBedsideOpsInfo(dto.id,
                        success: (BedsideBedsideOpsListModelData info) {
                          nameController.text = info.name;
                        });
                  }
                },
                viewModel: _bedsideBedsideOpsViewModel,
                builder: (c,BedsideBedsideOpsViewModel model,_) {
                  print("model AnimatedSwitcher");
                  return AnimatedSwitcher(
                    duration: Duration(seconds: 2),
                    child: model.loading ? CupertinoActivityIndicator() : BedsideBedsideOpsHospitalTableColumn(
                      titleStyle: titleStyle,
                      lineStyle: lineStyle,
                      listData: model.bedsideBedsideOpsHospitalListbyopsidModels,
                    ),
                  );
                },
            ),
            SizedBox(
              height: 47.h,
            ),
            Container(
              padding: EdgeInsets.symmetric(horizontal: 15.w),
              width: double.infinity,
              child: ValueListenableBuilder(
                valueListenable: _bedsideBedsideOpsViewModel.valueNotifier,
                builder: (BuildContext context, value, Widget child) {
                  return TextButton(
                    onPressed: () {
                      if(_bedsideBedsideOpsViewModel.loading) {
                        return;
                      }
                      EasyLoading.show(status: "保存中");
                      BedsideBedsideopshospitalSaveDto saveDto = BedsideBedsideopshospitalSaveDto();
                      saveDto.opsId = dto.id;
                      saveDto.hospitals = _bedsideBedsideOpsViewModel.bedsideBedsideOpsHospitalListbyopsidModels;
                      _bedsideBedsideOpsViewModel.bedsideBedsideopshospitalSave(saveDto,success: (value){
                        EasyLoading.dismiss();
                        EasyLoading.showToast("保存成功");
                        Navigator.pop(context);
                      },error: (err) {
                        EasyLoading.dismiss();
                      });
                    },
                    child: _bedsideBedsideOpsViewModel.loading
                        ? CupertinoActivityIndicator()
                        : Text("确定"),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}

