import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:binance_game_app/constant/theme_colors.dart';
import 'package:binance_game_app/model/search_model.dart';
import 'dart:ui';

class ListSelect extends StatefulWidget {

  final double topHeight;

  List<SearchModel> list;

  Function onChange;


  ListSelect({this.topHeight,@required this.list,this.onChange});

  @override
  _ListSelectState createState() => _ListSelectState();
}

class _ListSelectState extends State<ListSelect> {
  int currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        show(context);
      },
      child: Text.rich(TextSpan(
          text: widget.list[currentIndex].getValue(),
          style: Theme.of(context).textTheme.headline3,
          children: [
            WidgetSpan(
                child: Icon(Icons.arrow_drop_down),
                alignment: PlaceholderAlignment.middle
            )
          ]
      ),
        textAlign: TextAlign.center,
      ),
    );
  }

  show(BuildContext context) {
    double top = MediaQueryData.fromWindow(window).padding.top;
    double h = kToolbarHeight + top;
    TextStyle defaultHeadline2 = Theme.of(context).textTheme.headline2.copyWith(
      color: ThemeColors.COLOR_333333
    );
    TextStyle defaultHeadlineSelect = Theme.of(context).textTheme.headline2.copyWith(
        color: ThemeColors.COLOR_539FF6
    );
    showGeneralDialog(
        context: context,
        barrierDismissible:true,
        barrierLabel: '',
        transitionDuration: Duration(milliseconds: 200),
        barrierColor: Colors.transparent,
        pageBuilder: (BuildContext context, Animation<double> animation,
            Animation<double> secondaryAnimation) {
          widget.list.forEach((element) {print(element.toJson());});
          return Scaffold(
            backgroundColor: Colors.transparent,
            body: Align(
              alignment: Alignment.topLeft,
              child: Column(
                children: [
                  Container(
                    height: h + widget.topHeight,
                    color: Colors.transparent,
                  ),
                  Container(
                    width: 375.w,
                    height: (widget.list.length * 60.h) > 260.h ? 260.h : (widget.list.length * 60).h,
                    padding: EdgeInsets.symmetric(horizontal: 16.w),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.only(bottomLeft: Radius.circular(10.r),bottomRight: Radius.circular(10.r),),
                      color: Colors.white,
                    ),
                    child: ListView.builder(itemCount: widget.list.length,itemBuilder: (BuildContext context, int index) {
                      return GestureDetector(
                        onTap: () {
                          setState(() {
                            this.currentIndex = index;
                          });
                          widget.onChange(index);
                          Navigator.of(context).pop();
                        },
                        child: Container(
                          // color: Colors.primaries[index],
                          child: ListTile(
                            dense: true,
                            contentPadding: EdgeInsets.symmetric(horizontal: 0.0,vertical: 0.0),
                            title: Text(widget.list[index].getValue(),
                              style: index == currentIndex ? defaultHeadlineSelect :defaultHeadline2,
                            ),
                          ),
                        ),
                      );
                    },
                      padding: EdgeInsets.zero,
                    ),
                  ),
                  Expanded(child: GestureDetector(onTap: () {Navigator.of(context).pop();},child: Container(color: const Color(0x80000000),)))
                ],
              ),
            ),
          );
        });
  }
}
