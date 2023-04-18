import 'package:flutter/material.dart';

import 'helper.dart';

class ButtonsTab extends StatefulWidget {
  /// Define attribute Widget and State
  ///
  const ButtonsTab({
    Key? key,
    this.title,
    this.onPressed,
    required this.width,
    this.height,
    this.isSelected,
    this.radius,
    this.selectedTextStyle,
    this.unSelectedTextStyle,
    required this.selectedColors,
    this.icons,
    this.iconSize,
    required this.unSelectedColors,
    this.begin,
    this.end,
    this.marginSelected = EdgeInsets.zero,
  }) : super(key: key);

  final String? title;
  final Function? onPressed;
  final double? width;
  final double? height;
  final List<Color>? selectedColors;
  final List<Color>? unSelectedColors;
  final TextStyle? selectedTextStyle;
  final TextStyle? unSelectedTextStyle;

//  final BoxDecoration selectedDecoration;
//  final BoxDecoration unSelectedDecoration;
  final bool? isSelected;
  final double? radius;
  final IconData? icons;
  final double? iconSize;

  final Alignment? begin;
  final Alignment? end;

  final EdgeInsets? marginSelected;

  @override
  _ButtonsTabState createState() => _ButtonsTabState();
}

class _ButtonsTabState extends State<ButtonsTab> {
  @override
  Widget build(BuildContext context) {
    return Container(
        width: widget.width ?? widthInPercent(100, context),
        height: widget.height ?? 50,
        //wrap with container to fix margin issue
        child: Container(
          margin: widget.isSelected! ? widget.marginSelected : EdgeInsets.zero,
          decoration: widget.isSelected!
              ? bdHeader.copyWith(
                  borderRadius: BorderRadius.circular(widget.radius!),
                  gradient: LinearGradient(
                    // Where the linear gradient begins and ends
                    begin: widget.begin ?? Alignment.topCenter,
                    end: widget.end ?? Alignment.bottomCenter,
                    colors: widget.selectedColors ??
                        [Theme.of(context).primaryColor],
                  ))
              : null,
          child: TextButton(
              onPressed: widget.onPressed as void Function()?,
              style: ButtonStyle(
                  shape: MaterialStateProperty.all(new RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(widget.radius!))),
                  padding: MaterialStateProperty.all(EdgeInsets.zero)),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  widget.icons != null
                      ? Icon(
                          widget.icons,
                          size: widget.iconSize,
                          color: widget.isSelected!
                              ? widget.selectedTextStyle!.color
                              : widget.unSelectedTextStyle!.color,
                        )
                      : Container(),
                  Visibility(
                    visible: widget.icons != null &&
                        widget.title.toString().isNotEmpty,
                    child: SizedBox(width: 4),
                  ),
                  Text(
                    widget.title!,
                    style: widget.isSelected!
                        ? widget.selectedTextStyle
                        : widget.unSelectedTextStyle,
                    textAlign: TextAlign.center,
                  )
                ],
              )),
        ));
  }
}
