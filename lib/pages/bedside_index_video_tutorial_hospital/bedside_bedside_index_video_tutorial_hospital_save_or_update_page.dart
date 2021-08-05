import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:binance_game_app/dto/save_or_upadte/save_or_update_dto.dart';
import 'package:binance_game_app/model/bedside_bedside_index_video_tutorial_hospital_list_model.dart';
import 'package:binance_game_app/view_model/bedside_bedside_index_video_tutorial_hospital/bedside_bedside_index_video_tutorial_hospital_view_model.dart';
import 'package:binance_game_app/widget/prefixicon_text_field.dart';
import 'package:binance_game_app/widget/provider/provider_widget.dart';


class BedsideBedsideIndexVideoTutorialHospitalSaveOrUpadtePage extends StatelessWidget {

  static const routeName = '/bedsideindexvideotutorialhospitalSaveOrUpadtePage';

  SaveOrUpdateDto dto;


  BedsideBedsideIndexVideoTutorialHospitalSaveOrUpadtePage({this.dto});

  final BedsideBedsideIndexVideoTutorialHospitalViewModel _bedsideBedsideIndexVideoTutorialHospitalViewModel = BedsideBedsideIndexVideoTutorialHospitalViewModel();

  final TextEditingController idController = new TextEditingController(text: "");
  final TextEditingController nameController = new TextEditingController(text: "");
  final TextEditingController indexVideoTutorialIdController = new TextEditingController(text: "");
  final TextEditingController videoController = new TextEditingController(text: "");
  final TextEditingController remarkController = new TextEditingController(text: "");
  final TextEditingController createdAtController = new TextEditingController(text: "");
  final TextEditingController updatedAtController = new TextEditingController(text: "");
  final TextEditingController deletedAtController = new TextEditingController(text: "");

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("首页视频教程医院中间表-${dto.titleStr}",
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

              PrefixiconTextField(prefixText: "名称",hintText: "请输入名称",textEditingController: nameController,),
              PrefixiconTextField(prefixText: "首页视频id",hintText: "请输入首页视频id",textEditingController: indexVideoTutorialIdController,),
              PrefixiconTextField(prefixText: "视频",hintText: "请输入视频",textEditingController: videoController,),
              PrefixiconTextField(prefixText: "备注",hintText: "请输入备注",textEditingController: remarkController,),
              PrefixiconTextField(prefixText: "创建时间",hintText: "请输入创建时间",textEditingController: createdAtController,),
              PrefixiconTextField(prefixText: "修改时间",hintText: "请输入修改时间",textEditingController: updatedAtController,),
              PrefixiconTextField(prefixText: "删除时间",hintText: "请输入删除时间",textEditingController: deletedAtController,),
              SizedBox(height: 47.h,),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 15.w),
                width: double.infinity,
                child: ProviderWidget(
                  init: (BedsideBedsideIndexVideoTutorialHospitalViewModel model) {
                    if (this.dto.id != null) {
                      model.bedsideBedsideIndexVideoTutorialHospitalInfo(dto.id,success: (BedsideBedsideIndexVideoTutorialHospitalListModelData info) {
                        nameController.text = info.name;
                        indexVideoTutorialIdController.text = info.indexVideoTutorialId.toString();
                        videoController.text = info.video;
                        remarkController.text = info.remark;
                        createdAtController.text = info.createdAt;
                        updatedAtController.text = info.updatedAt;
                        deletedAtController.text = info.deletedAt;
                      });
                    }
                  },
                  viewModel: _bedsideBedsideIndexVideoTutorialHospitalViewModel,
                  builder: (c,BedsideBedsideIndexVideoTutorialHospitalViewModel model,_) {
                    return TextButton(
                      onPressed: (){
                          if(model.loading) {
                            return;
                          }
                        if (nameController.text.isEmpty) {
                            EasyLoading.showToast("名称不能为空");
                            return;
                        }
                        if (indexVideoTutorialIdController.text.isEmpty) {
                            EasyLoading.showToast("首页视频id不能为空");
                            return;
                        }
                        if (videoController.text.isEmpty) {
                            EasyLoading.showToast("视频不能为空");
                            return;
                        }
                        if (remarkController.text.isEmpty) {
                            EasyLoading.showToast("备注不能为空");
                            return;
                        }
                        if (createdAtController.text.isEmpty) {
                            EasyLoading.showToast("创建时间不能为空");
                            return;
                        }
                        if (updatedAtController.text.isEmpty) {
                            EasyLoading.showToast("修改时间不能为空");
                            return;
                        }
                        if (deletedAtController.text.isEmpty) {
                            EasyLoading.showToast("删除时间不能为空");
                            return;
                        }

                        String name = nameController.text;
                        String indexVideoTutorialId = indexVideoTutorialIdController.text;
                        String video = videoController.text;
                        String remark = remarkController.text;
                        String createdAt = createdAtController.text;
                        String updatedAt = updatedAtController.text;
                        String deletedAt = deletedAtController.text;

                        BedsideBedsideIndexVideoTutorialHospitalListModelData data = BedsideBedsideIndexVideoTutorialHospitalListModelData(
                          id: dto.id,
                            name: name,
                            indexVideoTutorialId: indexVideoTutorialId.isEmpty ? null : int.parse(indexVideoTutorialId),
                            video: video,
                            remark: remark,
                            createdAt: createdAt,
                            updatedAt: updatedAt,
                            deletedAt: deletedAt,
                        );
                        model.bedsideBedsideIndexVideoTutorialHospitalSaveUpdate(data,success: (value) {
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
