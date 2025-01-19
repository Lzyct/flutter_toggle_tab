part of 'flutter_toggle_tab.dart';

class ButtonsTab extends StatelessWidget {
  /// Define attribute Widget and State
  /// [counterWidget] is a widget to show counter
  /// [title] is a title of the button
  /// [onPressed] is a function to handle button press
  /// [width] is a width of the button
  /// [height] is a height of the button
  /// [selectedColors] is a list of color when the button is selected
  /// [unSelectedColors] is a list of color when the button is unselected
  /// [selectedTextStyle] is a text style when the button is selected
  /// [unSelectedTextStyle] is a text style when the button is unselected
  /// [isSelected] is a boolean to check if the button is selected or not
  /// [radius] is a radius of the button
  /// [icons] is an icon of the button
  /// [iconSize] is a size of the icon
  /// [begin] is a begin alignment of the gradient
  /// [end] is an end alignment of the gradient
  /// [marginSelected] is a margin when the button is selected
  /// [isInnerShadowEnable] is optional to set the shadow of the selected tab.
  const ButtonsTab({
    super.key,
    this.title,
    this.onPressed,
    this.counterWidget,
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
    this.isInnerShadowEnable = true,
  });

  final Widget? counterWidget;

  final String? title;
  final VoidCallback? onPressed;
  final double? width;
  final double? height;
  final List<Color>? selectedColors;
  final List<Color>? unSelectedColors;
  final TextStyle? selectedTextStyle;
  final TextStyle? unSelectedTextStyle;

  final bool? isSelected;
  final double? radius;
  final IconData? icons;
  final double? iconSize;

  final Alignment? begin;
  final Alignment? end;

  final EdgeInsets? marginSelected;
  final bool isInnerShadowEnable;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width ?? _widthInPercent(100, context),
      height: height ?? 50,
      //wrap with container to fix margin issue
      child: Padding(
        padding:
            isSelected! ? (marginSelected ?? EdgeInsets.zero) : EdgeInsets.zero,
        child: DecoratedBox(
          decoration: isSelected!
              ? (isInnerShadowEnable ? bdHeader : const BoxDecoration())
                  .copyWith(
                  borderRadius: BorderRadius.circular(radius!),
                  gradient: LinearGradient(
                    // Where the linear gradient begins and ends
                    begin: begin ?? Alignment.topCenter,
                    end: end ?? Alignment.bottomCenter,
                    colors: selectedColors ?? [Theme.of(context).primaryColor],
                  ),
                )
              : const BoxDecoration(),
          child: TextButton(
            onPressed: onPressed,
            style: ButtonStyle(
              shape: WidgetStateProperty.all(
                RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(radius!),
                ),
              ),
              padding: WidgetStateProperty.all(EdgeInsets.zero),
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
                  ),
                Visibility(
                  visible: icons != null && title.toString().isNotEmpty,
                  child: const SizedBox(width: 4),
                ),
                if (title != null)
                  Text(
                    title!,
                    style:
                        isSelected! ? selectedTextStyle : unSelectedTextStyle,
                    textAlign: TextAlign.center,
                  ),
                Visibility(
                  visible: icons != null &&
                      title.toString().isNotEmpty &&
                      counterWidget != null,
                  child: const SizedBox(width: 4),
                ),
                if (counterWidget != null) counterWidget!,
              ],
            ),
          ),
        ),
      ),
    );
  }
}
