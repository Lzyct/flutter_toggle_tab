import 'package:flutter/material.dart';

import 'helper.dart';

class ButtonsTab extends StatefulWidget {
  const ButtonsTab({Key key,
    this.title,
    this.onPressed,
    @required this.width,
    this.height,
    this.isSelected,
    this.radius,
    this.selectedTextStyle,
    this.unSelectedTextStyle,
    @required this.selectedDecoration,
    @required this.unSelectedDecoration,
    this.isFirst,
    this.isLast,
    this.icon})
      : super(key: key);

  final String title;
  final Function onPressed;
  final double width;
  final double height;
  final TextStyle selectedTextStyle;
  final TextStyle unSelectedTextStyle;
  final BoxDecoration selectedDecoration;
  final BoxDecoration unSelectedDecoration;
  final bool isSelected;
  final bool isFirst;
  final bool isLast;
  final double radius;
  final Icon icon;

  @override
  _ButtonsTabState createState() => _ButtonsTabState();
}

class _ButtonsTabState extends State<ButtonsTab> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: widget.width ?? widthInPercent(100, context),
      height: widget.height ?? 50,
      decoration: widget.isSelected
          ? widget.selectedDecoration.copyWith(
          borderRadius: widget.isFirst
              ? BorderRadius.only(
              topLeft: Radius.circular(widget.radius ?? 15.0),
              bottomLeft: Radius.circular(widget.radius ?? 15.0))
              : widget.isLast
              ? BorderRadius.only(
              topRight: Radius.circular(widget.radius ?? 15.0),
              bottomRight: Radius.circular(widget.radius ?? 15.0))
              : BorderRadius.circular(0))
          : widget.unSelectedDecoration.copyWith(
          borderRadius: widget.isFirst
              ? BorderRadius.only(
              topLeft: Radius.circular(widget.radius ?? 15.0),
              bottomLeft: Radius.circular(widget.radius ?? 15.0))
              : widget.isLast
              ? BorderRadius.only(
              topRight: Radius.circular(widget.radius ?? 15.0),
              bottomRight: Radius.circular(widget.radius ?? 15.0))
              : BorderRadius.circular(0)),
      child: FlatButton(
          onPressed: widget.onPressed,
          shape: new RoundedRectangleBorder(
              borderRadius: widget.isFirst
                  ? BorderRadius.only(
                  topLeft: Radius.circular(widget.radius ?? 15.0),
                  bottomLeft: Radius.circular(widget.radius ?? 15.0))
                  : widget.isLast
                  ? BorderRadius.only(
                  topRight: Radius.circular(widget.radius ?? 15.0),
                  bottomRight: Radius.circular(widget.radius ?? 15.0))
                  : BorderRadius.circular(0)),
          padding: EdgeInsets.all(0.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              widget.icon ?? Container(),
              Visibility(visible: widget.icon != null,
                child: SizedBox(width: 4,),),
              Text(
                widget.title,
                style: widget.isSelected
                    ? widget.selectedTextStyle
                    : widget.unSelectedTextStyle,
                textAlign: TextAlign.center,
              )
            ],
          )),
    );
  }
}
