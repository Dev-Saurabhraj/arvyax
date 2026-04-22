import 'package:flutter/material.dart';
import 'app_colors.dart';

class AppDecorations {
  // Shadows
  static const BoxShadow shadowSmall = BoxShadow(
    color: Color(0x0A000000),
    blurRadius: 4,
    offset: Offset(0, 2),
  );

  static const BoxShadow shadowMedium = BoxShadow(
    color: Color(0x14000000),
    blurRadius: 8,
    offset: Offset(0, 4),
  );

  static const BoxShadow shadowLarge = BoxShadow(
    color: Color(0x1A000000),
    blurRadius: 16,
    offset: Offset(0, 8),
  );

  static const List<BoxShadow> boxShadowSmall = [shadowSmall];
  static const List<BoxShadow> boxShadowMedium = [shadowMedium];
  static const List<BoxShadow> boxShadowLarge = [shadowLarge];

  // Border Radius
  static const double radiusXS = 4.0;
  static const double radiusSM = 8.0;
  static const double radiusMD = 12.0;
  static const double radiusLG = 16.0;
  static const double radiusXL = 24.0;

  static const BorderRadius borderRadiusXS = BorderRadius.all(
    Radius.circular(radiusXS),
  );
  static const BorderRadius borderRadiusSM = BorderRadius.all(
    Radius.circular(radiusSM),
  );
  static const BorderRadius borderRadiusMD = BorderRadius.all(
    Radius.circular(radiusMD),
  );
  static const BorderRadius borderRadiusLG = BorderRadius.all(
    Radius.circular(radiusLG),
  );
  static const BorderRadius borderRadiusXL = BorderRadius.all(
    Radius.circular(radiusXL),
  );

  // Card Decoration
  static BoxDecoration cardDecoration({Color color = AppColors.surface}) =>
      BoxDecoration(
        color: color,
        borderRadius: borderRadiusMD,
        boxShadow: boxShadowSmall,
      );

  // Button Decoration
  static BoxDecoration buttonDecoration({
    Color color = AppColors.primary,
    BorderRadius? borderRadius,
  }) =>
      BoxDecoration(color: color, borderRadius: borderRadius ?? borderRadiusMD);

  // Input Decoration
  static InputDecoration inputDecoration({
    String? labelText,
    String? hintText,
    Widget? prefixIcon,
    Widget? suffixIcon,
    Color focusColor = AppColors.primary,
  }) => InputDecoration(
    labelText: labelText,
    hintText: hintText,
    prefixIcon: prefixIcon,
    suffixIcon: suffixIcon,
    filled: true,
    fillColor: AppColors.backgroundDark,
    border: OutlineInputBorder(
      borderRadius: borderRadiusMD,
      borderSide: const BorderSide(color: AppColors.grey200),
    ),
    enabledBorder: OutlineInputBorder(
      borderRadius: borderRadiusMD,
      borderSide: const BorderSide(color: AppColors.grey200),
    ),
    focusedBorder: OutlineInputBorder(
      borderRadius: borderRadiusMD,
      borderSide: BorderSide(color: focusColor, width: 2),
    ),
    contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
  );

  // Gradient Backgrounds
  static LinearGradient calmGradient = LinearGradient(
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
    colors: [
      AppColors.primary.withOpacity(0.1),
      AppColors.primaryLight.withOpacity(0.1),
    ],
  );

  static LinearGradient peacefulGradient = LinearGradient(
    begin: Alignment.topCenter,
    end: Alignment.bottomCenter,
    colors: [
      const Color(0xFFE9D5FF).withOpacity(0.5),
      const Color(0xFFC084FC).withOpacity(0.3),
    ],
  );
}
