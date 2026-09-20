# Project Guidance

## Scope

This repository publishes the `flutter_toggle_tab` Flutter package and contains
a runnable application under `example/`. Keep library changes backwards
compatible unless the package version, changelog, and migration documentation
explicitly describe a breaking release.

## Toolchain

- Use Flutter 3.47.x or newer within the 3.47-compatible package constraints.
- Use Dart 3.13 or newer.
- Import Material APIs from `package:material_ui/material_ui.dart`; do not
  reintroduce the legacy Flutter Material import.
- Run commands from the repository root unless a command explicitly targets
  the `example/` application.

## Architecture

- `lib/flutter_toggle_tab.dart` owns the public `FlutterToggleTab` API and
  selects the appropriate internal layout.
- `lib/adaptive_tab_layout.dart` owns content-sized tabs, measured geometry,
  adaptive background width, and adaptive indicator positioning.
- `lib/non_adaptive_tab_layout.dart` owns equal-width tabs and normalized
  `Alignment` positioning.
- `lib/selected_tab_indicator.dart` owns the animated selected background.
- `lib/button_tab.dart` owns the interactive content of one tab.
- Keep at most one class that extends `StatelessWidget` or `StatefulWidget` in
  each Dart file. Plain state and geometry classes may remain beside the widget
  they exclusively support.
- Keep adaptive and non-adaptive behavior in their respective layout
  components instead of adding width-mode branches inside child widgets.

## State and rebuilds

- Keep `FlutterToggleTab` controlled through `selectedIndex` and
  `selectedLabelIndex`.
- Use `ValueNotifier` and `ValueListenableBuilder` for selection and internal
  measured geometry so updates rebuild only the dependent subtree.
- Dispose every notifier owned by a `State` object.
- Never mutate caller-owned `DataTab` instances to represent selection.

## Layout behavior

- Equal-width mode divides the available control width by the number of tabs.
- Adaptive mode measures actual tab geometry. Its background width must equal
  the combined tab width, and the indicator must animate both `left` and
  `width` values.
- Keep the tab row, adaptive background, and adaptive indicator in the same
  horizontal scroll surface.
- Preserve support for text, icons, counter widgets, margins, gradients,
  shadows, text scaling, and right-to-left padding resolution.
- Preserve the default equal-width behavior when `isAdaptiveWidth` is false.

## Documentation

- Add dartdoc comments for every public library, class, constructor, field,
  method, and enum.
- Update `README.md` examples and the API table whenever public behavior or
  parameters change.
- Keep README examples aligned with `example/lib/main.dart` and cover every
  runnable usage sample in `example/test/widget_test.dart`.
- Update `CHANGELOG.md` for user-visible behavior.
- Validate docs with:

  ```sh
  FLUTTER_ROOT=/Users/lzyct/Library/flutter \
    /Users/lzyct/Library/flutter/bin/cache/dart-sdk/bin/dart doc --validate-links
  ```

## Verification

Before completing a change, run:

```sh
/Users/lzyct/Library/flutter/bin/flutter analyze
/Users/lzyct/Library/flutter/bin/flutter test
(cd example && /Users/lzyct/Library/flutter/bin/flutter test)
/Users/lzyct/Library/flutter/bin/flutter pub publish --dry-run
```

For layout or platform-facing changes, also build the example for Android and
the iOS Simulator. Confirm `git diff --check` and inspect the final diff.

## Git hygiene

- Preserve unrelated local modifications and never stage them accidentally.
- Keep platform, library behavior, tests, documentation, and project-guidance
  changes in focused commits when they represent separate concerns.
- Do not commit generated `build/`, `.dart_tool/`, or `doc/api/` output.
