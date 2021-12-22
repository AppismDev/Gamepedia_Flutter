import 'package:easy_localization/src/public_ext.dart';

extension StringLocalization on String {
  String get locale => this.tr();
}

extension StringExtensions on String {
  String get getLimitedText {
    if (this == null && this.length == 0) {
      return "";
    } else {
      return this.substring(0, (this.length / 3).toInt());
    }
  }
}
