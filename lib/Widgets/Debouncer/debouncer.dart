import 'package:async/async.dart';
import 'package:flutter/foundation.dart';
import 'dart:async';

class Debouncer {
  final int milliseconds;
  VoidCallback? action;
  Timer? _timer;
  CancelableOperation? cancelableOperation;

  Debouncer({required this.milliseconds});
  run(action) {
    _timer?.cancel();
    print("Cancelled");
    _timer = Timer(Duration(milliseconds: milliseconds), action);
  }

  cancel(){
    _timer?.cancel();
  }


}
