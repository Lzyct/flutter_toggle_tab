import 'package:flutter/material.dart';
import 'package:flutter_toggle_tab/helper.dart';

class ButtonsTab extends StatelessWidget {
  /// Define attribute Widget and State
  ///
  const ButtonsTab({
    super.key,
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
  });

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
  Widget build(BuildContext context) {
    return SizedBox(
      width: width ?? widthInPercent(100, context),
      height: height ?? 50,
      //wrap with container to fix margin issue
      child: Container(
        margin: isSelected! ? marginSelected : EdgeInsets.zero,
        decoration: isSelected!
            ? bdHeader.copyWith(
                borderRadius: BorderRadius.circular(radius!),
                gradient: LinearGradient(
                  // Where the linear gradient begins and ends
                  begin: begin ?? Alignment.topCenter,
                  end: end ?? Alignment.bottomCenter,
                  colors: selectedColors ?? [Theme.of(context).primaryColor],
                ),
              )
            : null,
        child: TextButton(
          onPressed: onPressed as void Function()?,
          style: ButtonStyle(
            shape: MaterialStateProperty.all(
              RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(radius!),
              ),
            ),
            padding: MaterialStateProperty.all(EdgeInsets.zero),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              if (icons != null)
                Icon(
                  icons,
                  size: iconSize,
                  color: isSelected!
                      ? selectedTextStyle!.color
                      : unSelectedTextStyle!.color,
                )
              else
                const SizedBox.shrink(),
              Visibility(
                visible: icons != null && title.toString().isNotEmpty,
                child: const SizedBox(width: 4),
              ),
              Text(
                title!,
                style: isSelected! ? selectedTextStyle : unSelectedTextStyle,
                textAlign: TextAlign.center,
              )
            ],
          ),
        ),
      ),
    );
  }
}
