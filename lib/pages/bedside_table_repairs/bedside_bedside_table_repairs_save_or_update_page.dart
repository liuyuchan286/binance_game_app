import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:binance_game_app/dto/save_or_upadte/save_or_update_dto.dart';
import 'package:binance_game_app/model/bedside_bedside_ops_list_model.dart';
import 'package:binance_game_app/model/bedside_bedside_table_repairs_list_model.dart';
import 'package:binance_game_app/view_model/bedside_bedside_ops_hospital/bedside_bedside_ops_hospital_view_model.dart';
import 'package:binance_game_app/view_model/bedside_bedside_table_repairs/bedside_bedside_table_repairs_view_model.dart';
import 'package:binance_game_app/widget/prefixicon_text_field.dart';
import 'package:binance_game_app/widget/provider/provider_widget.dart';
import 'package:binance_game_app/widget/single_list_picker.dart';


class BedsideBedsideTableRepairsSaveOrUpadtePage extends StatelessWidget {

  static const routeName = '/bedsidetablerepairsSaveOrUpadtePage';

  SaveOrUpdateDto dto;


  BedsideBedsideTableRepairsSaveOrUpadtePage({this.dto});

  final BedsideBedsideTableRepairsViewModel _bedsideBedsideTableRepairsViewModel = BedsideBedsideTableRepairsViewModel();

  final BedsideBedsideOpsHospitalViewModel _bedsideBedsideOpsHospitalViewModel = BedsideBedsideOpsHospitalViewModel();

  final TextEditingController idController = new TextEditingController(text: "");
  final TextEditingController tableIdController = new TextEditingController(text: "");
  final TextEditingController openidController = new TextEditingController(text: "");
  final TextEditingController opsIdController = new TextEditingController(text: "");
  final TextEditingController opsNameController = new TextEditingController(text: "");
  final TextEditingController typeController = new TextEditingController(text: "");
  final TextEditingController statusController = new TextEditingController(text: "");
  final TextEditingController contentController = new TextEditingController(text: "");
  final TextEditingController imgController = new TextEditingController(text: "");
  final TextEditingController createdAtController = new TextEditingController(text: "");
  final TextEditingController updatedAtController = new TextEditingController(text: "");
  final TextEditingController finishAtController = new TextEditingController(text: "");
  final TextEditingController orderIdController = new TextEditingController(text: "");
  final TextEditingController refundMoneyController = new TextEditingController(text: "");
  final TextEditingController repairBadReasonController = new TextEditingController(text: "");
  final TextEditingController repairBadImgController = new TextEditingController(text: "");

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("床头柜报修记录表-${dto.titleStr}",
        ),
      ),
      body: GestureDetector(
        onTap: () {
          //关闭键盘
          FocusScope.of(context).unfocus();
        },
        child: SingleChildScrollView(
          child: Column(
            children: [
              PrefixiconTextField(prefixText: "运维人员",hintText: "请输入运维人员",textEditingController: opsNameController,
                suffixIcon: SingleListPicker<BedsideBedsideOpsListModelData>(
                  initKey: opsNameController,
                  onTap: (context,showSingleListPicker) {
                    showSingleListPicker(context,_bedsideBedsideOpsHospitalViewModel.bedsideBedsideOpsListModelDatas);
                  },
                  onSelectedItemChanged: (index) {
                    BedsideBedsideOpsListModelData data = _bedsideBedsideOpsHospitalViewModel.bedsideBedsideOpsListModelDatas[index];
                    opsNameController.text = data.name;
                    opsIdController.text = data.id.toString();
                  },
                ),
                horizontal: 0,
                readOnly: true,
              ),

              SizedBox(height: 47.h,),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 15.w),
                width: double.infinity,
                child: ProviderWidget(
                  init: (BedsideBedsideTableRepairsViewModel model) {
                    if (this.dto.id != null) {
                      model.bedsideBedsideTableRepairsInfo(dto.id,success: (BedsideBedsideTableRepairsListModelData info) {
                        tableIdController.text = info.tableId.toString();
                        opsIdController.text = info.opsId.toString();
                        _bedsideBedsideOpsHospitalViewModel.bedsideBedsideopshospitalListOpsByTableId(info.tableId);
                      });
                    }
                  },
                  viewModel: _bedsideBedsideTableRepairsViewModel,
                  builder: (c,BedsideBedsideTableRepairsViewModel model,_) {
                    return TextButton(
                      onPressed: (){
                          if(model.loading) {
                            return;
                          }
                        if (tableIdController.text.isEmpty) {
                            EasyLoading.showToast("床头柜ID不能为空");
                            return;
                        }
                        if (opsIdController.text.isEmpty) {
                            EasyLoading.showToast("运维人员ID不能为空");
                            return;
                        }

                        String tableId = tableIdController.text;
                        String opsId = opsIdController.text;

                        BedsideBedsideTableRepairsListModelData data = BedsideBedsideTableRepairsListModelData(
                            id: dto.id,
                            tableId: tableId.isEmpty ? null : int.parse(tableId),
                            opsId: opsId.isEmpty ? null : int.parse(opsId),
                            opsName: opsNameController.text
                        );
                        model.bedsideBedsideTableRepairsAssign(data,success: (value) {
                          EasyLoading.showToast("${dto.titleStr}成功");
                          dto.callback(data);
                          Navigator.pop<String>(context);
                        });
                      },
                      child: model.loading ? CupertinoActivityIndicator() : Text(
                          "确定"
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
