import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:binance_game_app/constant/theme_colors.dart';

class ListSearchTextField extends StatelessWidget {

  final double width;

  final Color defaultColor =  ThemeColors.COLOR_CDCDCD;

  GestureTapCallback onTap;

  final TextEditingController controller;

  ListSearchTextField({this.width,this.onTap,this.controller});

  @override
  Widget build(BuildContext context) {
    final InputBorder border = OutlineInputBorder(
        borderSide: BorderSide(color: defaultColor),
        borderRadius: BorderRadius.all(Radius.circular(100.ssp))
    );

    return Theme(
      data: ThemeData(
        inputDecorationTheme: Theme.of(context).inputDecorationTheme.copyWith(
          contentPadding: EdgeInsets.symmetric(vertical: 0.h,horizontal: 15.w),
          fillColor: defaultColor,
          enabledBorder: border,
          focusedBorder: border,
        )
      ),
      child: Row(
        children: [
          Container(
            height: 30.h,
            width: width ?? 171.w,
            child: TextField(
              controller: controller,
              decoration: InputDecoration(
                prefixIcon: Icon(Icons.search,size: 20.ssp,color: ThemeColors.COLOR_999999,),
                hintText: '请输入',
                // suffixIcon: GestureDetector(
                //   child: Icon(Icons.cancel,color: ThemeColors.COLOR_999999,size: 20.ssp,),
                //   onTap: () {
                //     controller.text = "";
                //   },
                // )
              ),
            ),
          ),
          SizedBox(width: 5.w,),
          InkWell(
            onTap: this.onTap,
            child: Text("查询",
              style: Theme.of(context).textTheme.headline1.copyWith(
                fontSize: 14.ssp,
              ),
            ),
          )
        ],
      ),
    );
  }
}
