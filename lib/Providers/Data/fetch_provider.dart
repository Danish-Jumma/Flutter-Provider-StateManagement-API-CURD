import 'package:flutter/material.dart';

class FetchProvider extends ChangeNotifier {
  int _count = 0;
  // event
  increamentCount() {
    _count++;
    notifyListeners();
  }

  int getCount() => _count;
}
