part of 'flutter_toggle_tab.dart';

class _ButtonsTab extends StatelessWidget {
  const _ButtonsTab({
    this.title,
    this.onPressed,
    this.counterWidget,
    required this.width,
    required this.height,
    required this.isSelected,
    required this.radius,
    required this.selectedTextStyle,
    required this.unSelectedTextStyle,
    this.icons,
    this.iconSize,
  });

  final Widget? counterWidget;
  final String? title;
  final VoidCallback? onPressed;
  final double width;
  final double height;
  final TextStyle selectedTextStyle;
  final TextStyle unSelectedTextStyle;
  final bool isSelected;
  final double radius;
  final IconData? icons;
  final double? iconSize;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: width,
      height: height,
      child: TextButton(
        onPressed: onPressed,
        style: ButtonStyle(
          shape: WidgetStateProperty.all(
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(radius)),
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
                color: isSelected
                    ? selectedTextStyle.color
                    : unSelectedTextStyle.color,
              ),
            Visibility(
              visible: icons != null && title.toString().isNotEmpty,
              child: const SizedBox(width: 4),
            ),
            if (title != null)
              Flexible(
                child: Text(
                  title!,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: isSelected ? selectedTextStyle : unSelectedTextStyle,
                  textAlign: TextAlign.center,
                ),
              ),
            Visibility(
              visible:
                  icons != null &&
                  title.toString().isNotEmpty &&
                  counterWidget != null,
              child: const SizedBox(width: 4),
            ),
            ?counterWidget,
          ],
        ),
      ),
    );
  }
}
