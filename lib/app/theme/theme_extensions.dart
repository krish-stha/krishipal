import 'package:flutter/material.dart';
import 'app_colors.dart';

extension ThemeColors on BuildContext {
  bool get isDark => Theme.of(this).brightness == Brightness.dark;

  Color get textPrimary =>
      isDark ? AppColors.darkTextPrimary : AppColors.textPrimary;

  Color get textSecondary =>
      isDark ? AppColors.darkTextSecondary : AppColors.textSecondary;

  Color get textTertiary =>
      isDark ? AppColors.darkTextTertiary : AppColors.textTertiary;

  Color get background =>
      isDark ? AppColors.darkBackground : AppColors.background;

  Color get surface => isDark ? AppColors.darkSurface : AppColors.surface;

  Color get surfaceVariant =>
      isDark ? AppColors.darkSurfaceVariant : AppColors.surfaceVariant;

  Color get border => isDark ? AppColors.darkBorder : AppColors.border;

  Color get divider => isDark ? AppColors.darkDivider : AppColors.divider;

  Color get inputFill =>
      isDark ? AppColors.inputFillDark : AppColors.inputFillLight;
}
