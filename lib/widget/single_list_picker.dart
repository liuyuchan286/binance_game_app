import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:binance_game_app/model/picker/single_list_picker_model.dart';


class SingleListPicker<T extends SingleListPickerModel> extends StatelessWidget {

  final ValueChanged<int> onSelectedItemChanged;

  final Function onTap;

  final TextEditingController initKey;

  SingleListPicker({this.onSelectedItemChanged,this.initKey,this.onTap});

  int currentIndex;

  int initIndex;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => onTap(context,showSingleListPicker),
      child: Icon(Icons.arrow_drop_down),
    );
  }


  showSingleListPicker(BuildContext context,List<T> list) {
    if(currentIndex == null && list != null && list.isNotEmpty) {
      for(int i = 0; i < list.length;i++) {
        if(initKey.text == list[i].getKey().toString()) {
          initIndex = i;
        }
      }
    }

    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.white,
      elevation: 10,
      builder: (BuildContext context) {
        return Column(
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(width: 15.w,),
                InkWell(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: Text("取消",style: Theme.of(context).textTheme.headline2.copyWith(height: 2),),
                ),
                Spacer(),
                InkWell(
                  onTap: () {
                    if(list != null && list.isNotEmpty) {
                      if(currentIndex != null) {
                        this.onSelectedItemChanged(currentIndex);
                      }else if(currentIndex == null && initIndex == null) {
                        this.onSelectedItemChanged(0);
                      }
                    }
                    Navigator.pop(context);
                  },
                  child: Text("确认",style: Theme.of(context).textTheme.headline2.copyWith(color: Colors.green,height: 2),),
                ),
                SizedBox(width: 15.w,),
              ],
            ),
            Divider(),
            Expanded(
              child: CupertinoPicker(
                useMagnifier: true,
                scrollController: FixedExtentScrollController(initialItem: currentIndex ?? this.initIndex ?? 0),
                itemExtent: 40.h,
                onSelectedItemChanged: (index){
                  currentIndex = index;
                },
                children: <Widget>[
                  for (T value in list)
                    Container(
                      alignment: Alignment.center,
                      height: 40.h,
                      child: Text(value.getValue(),style: const TextStyle(fontSize: 16),),
                    )
                ],
              ),
            )
          ],
        );
      },
    );
  }


}
