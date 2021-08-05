import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:image_picker/image_picker.dart';
import 'package:binance_game_app/constant/theme_colors.dart';
import 'package:binance_game_app/dto/save_or_upadte/save_or_update_dto.dart';
import 'package:binance_game_app/model/bedside_bedside_index_video_tutorial_hospital_list_model.dart';
import 'package:binance_game_app/model/bedside_bedside_index_video_tutorial_list_model.dart';
import 'package:binance_game_app/pages/bedside_agent/widget/bedside_bedside_agent_hospital_table_column.dart';
import 'package:binance_game_app/view_model/bedside_bedside_index_video_tutorial/bedside_bedside_index_video_tutorial_view_model.dart';
import 'package:binance_game_app/view_model/bedside_bedside_index_video_tutorial_hospital/bedside_bedside_index_video_tutorial_hospital_view_model.dart';
import 'package:binance_game_app/view_model/bedside_upload/bedside_upload_viewmodel.dart';
import 'package:binance_game_app/widget/list_upload_video.dart';
import 'package:binance_game_app/widget/prefixicon_text_field.dart';
import 'package:binance_game_app/widget/provider/provider_widget.dart';
import 'package:video_player/video_player.dart';


class BedsideBedsideIndexVideoTutorialSaveOrUpadtePage extends StatelessWidget {

  static const routeName = '/bedsideindexvideotutorialSaveOrUpadtePage';

  SaveOrUpdateDto dto;


  final picker = ImagePicker();

  BedsideBedsideIndexVideoTutorialSaveOrUpadtePage({this.dto});

  final BedsideBedsideIndexVideoTutorialViewModel _bedsideBedsideIndexVideoTutorialViewModel = BedsideBedsideIndexVideoTutorialViewModel();
  final BedsideUploadViewModel _bedsideUploadViewModel = BedsideUploadViewModel();

  final BedsideBedsideIndexVideoTutorialHospitalViewModel _bedsideBedsideIndexVideoTutorialHospitalViewModel = BedsideBedsideIndexVideoTutorialHospitalViewModel();

  final TextEditingController idController = new TextEditingController(text: "");
  final TextEditingController videoController = new TextEditingController(text: "");
  final TextEditingController remarkController = new TextEditingController(text: "");
  final TextEditingController createdAtController = new TextEditingController(text: "");
  final TextEditingController updatedAtController = new TextEditingController(text: "");
  final TextEditingController deletedAtController = new TextEditingController(text: "");

  @override
  Widget build(BuildContext context) {
    final TextStyle titleStyle =
    Theme.of(context).textTheme.headline1.copyWith(fontSize: 14.ssp);

    final TextStyle lineStyle = Theme.of(context).textTheme.headline5;

    return Scaffold(
      appBar: AppBar(
        title: Text("首页视频教程-${dto.titleStr}",
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

              PrefixiconTextField(prefixText: "视频",hintText: "",readOnly:true,textEditingController: videoController,),

              Container(
                width: 375.w,
                color: Colors.white,
                child: Align(
                  alignment: Alignment.centerLeft,
                  child: GestureDetector(
                    onDoubleTap: () async {
                      final pickedFile = await picker.getVideo(source: ImageSource.gallery);
                      if (pickedFile != null) {
                        _bedsideUploadViewModel.upload(pickedFile.path,success: (value){
                          videoController.text = value;
                        },error: (error){
                          print(error);
                        });
                      } else {
                        print('No image selected.');
                      }
                    },
                    child: Container(
                      margin: EdgeInsets.symmetric(vertical: 15.h,horizontal: 15.w),
                      padding: EdgeInsets.symmetric(vertical: 25.h),
                      width: 107.w,
                      height: 107.h,
                      decoration: BoxDecoration(
                        border: Border.all(color: ThemeColors.COLOR_E2E2E2)
                      ),
                      child: ValueListenableBuilder<TextEditingValue>(
                          valueListenable: videoController,
                          builder: (_,__,___){
                            if(dto.id != null && videoController.text.isEmpty) {
                              return CupertinoActivityIndicator();
                            }
                            if (videoController.text.isEmpty) {
                              return ValueListenableBuilder(
                                  valueListenable: _bedsideUploadViewModel.valueNotifier,
                                  builder: (_,__,___){
                                    print("_bedsideUploadViewModel.valueNotifier.value = ${_bedsideUploadViewModel.valueNotifier.value}");
                                    if(_bedsideUploadViewModel.valueNotifier.value) {
                                      return CupertinoActivityIndicator();
                                    }
                                    return Column(
                                      children: [
                                        Image.asset("assets/images/upload_camera_logo.png"),
                                        Spacer(),
                                        Text("添加视频",style: Theme.of(context).textTheme.headline3,)
                                      ],
                                    );
                                  }
                              );
                            }
                            return ListUploadVideo(videoUrl: videoController.text,);
                          }
                      ),
                    ),
                  ),
                ),
              ),

              PrefixiconTextField(prefixText: "备注",hintText: "请输入备注",textEditingController: remarkController,),

              ProviderWidget(
                viewModel: _bedsideBedsideIndexVideoTutorialHospitalViewModel,
                init: (BedsideBedsideIndexVideoTutorialHospitalViewModel model) {
                  model.initBedsideBedsideIndexVideoTutorialHospitalListAll(dto.id);
                },
                builder: (c,BedsideBedsideIndexVideoTutorialHospitalViewModel model,_){
                  if(model.loading) {
                    return CupertinoActivityIndicator();
                  }
                  return BedsideBedsideAgentHospitalTableColumn<BedsideBedsideIndexVideoTutorialHospitalListModelData>(titleStyle: titleStyle, lineStyle: lineStyle,
                    listData: model.bedsideBedsideIndexVideoTutorialHospitalListModelDatas,
                    selectsId: model.selectIds,
                  );
                },
              ),

              SizedBox(height: 47.h,),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 15.w),
                width: double.infinity,
                child: ProviderWidget(
                  init: (BedsideBedsideIndexVideoTutorialViewModel model) {
                    if (this.dto.id != null) {
                      model.bedsideBedsideIndexVideoTutorialInfo(dto.id,success: (BedsideBedsideIndexVideoTutorialListModelData info) {
                        videoController.text = info.video;
                        remarkController.text = info.remark;
                        createdAtController.text = info.createdAt;
                        updatedAtController.text = info.updatedAt;
                        deletedAtController.text = info.deletedAt;

                      });
                    }
                  },
                  viewModel: _bedsideBedsideIndexVideoTutorialViewModel,
                  builder: (c,BedsideBedsideIndexVideoTutorialViewModel model,_) {
                    return TextButton(
                      onPressed: (){
                          if(model.loading) {
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

                        String video = videoController.text;
                        String remark = remarkController.text;
                        String createdAt = createdAtController.text;
                        String updatedAt = updatedAtController.text;
                        String deletedAt = deletedAtController.text;

                        BedsideBedsideIndexVideoTutorialListModelData data = BedsideBedsideIndexVideoTutorialListModelData(
                          id: dto.id,
                            video: video,
                            remark: remark,
                            createdAt: createdAt,
                            updatedAt: updatedAt,
                            deletedAt: deletedAt,
                          selectHospitalIds: _bedsideBedsideIndexVideoTutorialHospitalViewModel.selectIds,
                        );
                        model.bedsideBedsideIndexVideoTutorialSaveUpdate(data,success: (value) {
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
