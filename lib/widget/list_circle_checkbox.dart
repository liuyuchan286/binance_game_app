import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:binance_game_app/constant/theme_colors.dart';


class ListCircleCheckbox extends StatefulWidget {

  final double topPadding;

  bool check;

  final ValueChanged<bool> onChanged;

  ListCircleCheckbox({this.topPadding,this.check=false,this.onChanged});

  @override
  _ListCircleCheckboxState createState() => _ListCircleCheckboxState();
}

class _ListCircleCheckboxState extends State<ListCircleCheckbox> {

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: widget.topPadding ?? 5.h),
      child: SizedBox(
        width: 22.w,
        height: 22.h,
        child: Checkbox(
            tristate: false,
          autofocus: true,
          shape: CircleBorder(),
          value: widget.check, onChanged: (bool value){
            setState(() {
              widget.check = value;
              widget.onChanged(value);
            });
          },
        ),
      ),
    );
  }
}
