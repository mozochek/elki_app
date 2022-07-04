import 'package:elki_app/modules/core/presentation/theme/app_colors_scheme.dart';
import 'package:elki_app/modules/core/presentation/theme/app_text_theme.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';

@immutable
class AppThemeData with EquatableMixin {
  final AppColorsScheme colorsScheme;
  final AppTextTheme textTheme;
  final ThemeData flutterTheme;

  const AppThemeData({
    required this.colorsScheme,
    required this.textTheme,
    required this.flutterTheme,
  });

  factory AppThemeData.fallback() {
    final theme = ThemeData.fallback();
    final AppColorsScheme colorsScheme;
    final AppTextTheme textTheme;

    switch (theme.brightness) {
      case Brightness.dark:
      case Brightness.light:
        colorsScheme = const LightAppColorsScheme();
        textTheme = const DefaultAppTextTheme();
    }

    return AppThemeData(
      flutterTheme: theme,
      colorsScheme: colorsScheme,
      textTheme: textTheme,
    );
  }

  @override
  List<Object?> get props => [colorsScheme, textTheme, flutterTheme];
}

class AppTheme extends StatefulWidget {
  final Widget child;

  const AppTheme({
    required this.child,
    Key? key,
  }) : super(key: key);

  static AppThemeData of(BuildContext context) {
    final inheritedAppTheme = context.dependOnInheritedWidgetOfExactType<_InheritedAppTheme>();

    return inheritedAppTheme?.data ?? AppThemeData.fallback();
  }

  @override
  State<AppTheme> createState() => _AppThemeState();
}

class _AppThemeState extends State<AppTheme> {
  late AppThemeData _appThemeData;
  Brightness? _previousBrightness;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    final theme = Theme.of(context);

    if (_previousBrightness != theme.brightness) {
      final AppColorsScheme colorsScheme;
      final AppTextTheme textTheme;

      switch (theme.brightness) {
        case Brightness.dark:
        case Brightness.light:
          colorsScheme = const LightAppColorsScheme();
          textTheme = const DefaultAppTextTheme();
      }

      _appThemeData = AppThemeData(
        flutterTheme: theme,
        colorsScheme: colorsScheme,
        textTheme: textTheme,
      );

      _previousBrightness = theme.brightness;
    }
  }

  @override
  Widget build(BuildContext context) {
    return _InheritedAppTheme(data: _appThemeData, child: widget.child);
  }
}

class _InheritedAppTheme extends InheritedWidget {
  final AppThemeData data;

  const _InheritedAppTheme({
    required this.data,
    required super.child,
  });

  @override
  bool updateShouldNotify(_InheritedAppTheme old) => old.data != data;
}
