# 2.0.0

* Require Flutter 3.47.x and Dart 3.13.
* Migrate Material widgets to the standalone `material_ui` package.
* Update the example Android and iOS projects to Flutter 3.47 platform baselines.
* Make tab selection controlled without mutating caller-owned `DataTab` values.
* Handle constrained layouts, long labels, and empty gradient color lists.
* Add widget tests for every example usage.
* Complete dartdoc coverage and remove unintended internal widgets and styles
  from the public API.
* Rewrite the README for the controlled 2.0 API and Flutter 3.47 requirements.
* Animate the selected-tab indicator and expose configurable duration and
  curve options.
* Add opt-in adaptive tab and background widths based on each tab's content.
* Separate adaptive and equal-width layout components for maintainability.
* Scope selection and adaptive-geometry updates with `ValueListenable` APIs.

# 0.0.1

* Initial Release

# 0.0.1+2

* Update a missed in readme

# 0.0.2

* Support Gradient for Selected and Unselected Background Color

# 0.0.2+1

* Fix build issue

# 0.0.3

* Change initialLabelIndex to initialIndex
* Support change selected index programmatically

# 0.0.3+1

* Fix formatting issue

# 0.0.3+2

* Fix missing formatting code

# 0.0.4+3

* Add support disable Horizontal Scroll
* Update deprecated Widget

# 0.0.5+4

* Update Documentation

# 0.0.6+5

* Remove log on builder

# 1.0.0

* Migrate to Null Safety

# 1.1.0

* Support margin for selected tab

# 1.1.1

* Remove print statement

# 1.1.2

* Fix issue null safety when icons is null

# 1.1.3

* Fix margin issue on last item

# 1.1.4

* Fix duplicate button

# 1.1.5

* Disable shadow support

# 1.1.6

* Update selected if selectedIndex changed

# 1.1.7

* Remove initialIndex replace with selectedIndex
* Set selectedIndex required
* Fix issue double when tap button
* Fix issue update selectedIndex value, selected button not updated

# 1.2.0

* Update kotlin version on Example
* Reformat library
* Update README file

# 1.3.0

* Expose iconSize
* Fix: Invisible a right margin in the button tab if only the icon is set. thanks to @kaedeee

# 1.4.0

* Add support dart 3
* Set text style is not required, use TextTheme.of(context).bodyMedium as default style
* Improve performance, use valueNotifier to update selected index instead of setState

# 1.4.1

* Update docs

# 1.5.0

* Breaking change: remove labels and icons replaced with dataTabs
* support custom counter-widget to fix #16
* update example project to support AGP >= 8
* improve widget usage and fix warning from linter

# 1.5.1

* Add new parameters `isInnerShadowEnable` and `isShadowEnable` to enable or turn off the shadow (#18) Thanks to @ysak-y
