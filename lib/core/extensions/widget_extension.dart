import 'package:flutter/material.dart';

/// An extension used to enhance the [Widget] class.
/// Without having to repeat so much code.
/// To use the extenstion you need to import the file.
/// On any widget of your choice you can add this extension by,
/// converting SizedBox(child:child) to SizedBox(child:child).afmDefaultBorderRadius.
extension WidgetExtension on Widget {
  /// Adds a borderRadius to the widget used in the figma design.
  Widget get aftmDefaultBorderRadius => ClipRRect(
        borderRadius: BorderRadius.circular(4),
        child: this,
      );

  ///puts the widget in a center widget
  Widget get afmCenter => Center(
        child: this,
      );

  /// Allows to add custom borderRadius
  Widget afmBorderRadius(BorderRadius radius) => ClipRRect(
        borderRadius: radius,
        child: this,
      );

  Widget get afmNeverScroll => SingleChildScrollView(
        child: this,
      );

  /// Make the widget clickable.
  /// Provides a callback when the widget is clicked.
  Widget afmTouchable(
    VoidCallback onTap, {
    Color? splashColor,
    double? elevation,
  }) =>
      Material(
        color: Colors.transparent,
        elevation: elevation ?? 0,
        child: InkWell(
          splashColor: splashColor,
          onTap: onTap,
          child: this,
        ),
      );

  ///This extension adds padding to the given widget.
  ///It has a default padding for [24.w] horizontally and [16.h] vertically.
  Widget afmPadding([EdgeInsetsGeometry? padding]) {
    return Padding(
      padding: padding ??
          const EdgeInsets.symmetric(
            horizontal: 16,
            vertical: 16,
          ),
      child: this,
    );
  }
}
