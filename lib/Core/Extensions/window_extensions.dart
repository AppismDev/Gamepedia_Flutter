import 'dart:ui';

import 'package:flutter/material.dart';

extension WindowExtensions on FlutterWindow {

  double get devicePixelRatio => this.devicePixelRatio;

  Size get physicalSize => this.physicalSize;

  double get physicalWidth => this.physicalWidth;

  double get physicalHeight => this.physicalHeight;

  Size get logicalScreenSize => this.physicalSize / this.devicePixelRatio;
  double get logicalWidth => logicalScreenSize.width;
  double get logicalHeight => logicalScreenSize.height;

  WindowPadding get padding => this.padding;

  double get paddingLeft => window.padding.left / window.devicePixelRatio;

  double get paddingRight => window.padding.right / window.devicePixelRatio;

  double get paddingTop => window.padding.top / window.devicePixelRatio;

  double get paddingBottom => window.padding.bottom / window.devicePixelRatio;

//Safe area in logical pixels
  double get safeWidth => logicalWidth - paddingLeft - paddingRight;
  double get safeHeight => logicalHeight - paddingTop - paddingBottom;


}