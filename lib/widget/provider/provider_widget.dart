import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:binance_game_app/view_model/base/base_view_model.dart';

class ProviderWidget<T extends BaseViewModel> extends StatefulWidget {

  T viewModel;

  Widget child;

  Function builder;

  Function init;

  Function dispose;


  ProviderWidget({
    @required this.viewModel,
    this.child,
    @required this.builder,
    this.init,this.dispose});

  @override
  _ProviderWidgetState createState() => _ProviderWidgetState();
}

class _ProviderWidgetState<T extends BaseViewModel> extends State<ProviderWidget> {

  @override
  void initState() {
    super.initState();
    if (widget.init != null) {
      widget.init(widget.viewModel);
    }
  }

  @override
  Widget build(BuildContext context) {
    print("ChangeNotifierProvider build");
    return ChangeNotifierProvider(
      create: (context) => widget.viewModel,
      child: Consumer<T>(
        builder: (context, value, child){
          return widget.builder(context, value, child);
        },
        child: widget.child,
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
    print("ProviderWidget dispose +++++++");
    if(widget.dispose != null) {
      widget.dispose();
    }
  }

}
