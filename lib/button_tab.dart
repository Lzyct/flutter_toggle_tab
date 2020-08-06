import 'package:flutter/material.dart';

import 'helper.dart';

class ButtonsTab extends StatefulWidget {
  const ButtonsTab(
      {Key key,
      this.title,
      this.onPressed,
      @required this.width,
      this.height,
      this.isSelected,
      this.radius,
      this.selectedTextStyle,
      this.unSelectedTextStyle,
      @required this.selectedColor,
      this.icons,
      @required this.unSelectedColor})
      : super(key: key);

  final String title;
  final Function onPressed;
  final double width;
  final double height;
  final Color selectedColor;
  final Color unSelectedColor;
  final TextStyle selectedTextStyle;
  final TextStyle unSelectedTextStyle;

//  final BoxDecoration selectedDecoration;
//  final BoxDecoration unSelectedDecoration;
  final bool isSelected;
  final double radius;
  final IconData icons;

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
          ? bdHeader.copyWith(
              borderRadius: BorderRadius.circular(widget.radius),
              color: widget.selectedColor)
          : null,
      child: FlatButton(
          onPressed: widget.onPressed,
          shape: new RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(widget.radius)),
          padding: EdgeInsets.all(0.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              widget.icons != null
                  ? Icon(
                      widget.icons,
                      color: widget.isSelected
                          ? widget.selectedTextStyle.color
                          : widget.unSelectedTextStyle.color,
                    )
                  : Container(),
              Visibility(
                visible: widget.icons != null,
                child: SizedBox(
                  width: 4,
                ),
              ),
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
