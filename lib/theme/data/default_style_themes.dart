import 'package:clock_app/theme/types/style_theme.dart';

List<StyleTheme> defaultStyleThemes = [
  StyleTheme(
    name: 'Default',
    shadowElevation: 1,
    shadowOpacity: 0.2,
    shadowBlurRadius: 1,
    shadowSpreadRadius: 0,
    borderRadius: 16,
    borderWidth: 0,
    isDefault: true,
  ),
  StyleTheme(
    name: 'Industrial',
    shadowElevation: 1,
    shadowOpacity: 0.2,
    shadowBlurRadius: 1,
    shadowSpreadRadius: 0,
    borderRadius: 0,
    borderWidth: 0,
    isDefault: true,
  ),
  StyleTheme(
    name: 'Minimal',
    shadowElevation: 0,
    shadowOpacity: 0,
    shadowBlurRadius: 0,
    shadowSpreadRadius: 0,
    borderRadius: 16,
    borderWidth: 0,
    isDefault: true,
  ),
];
