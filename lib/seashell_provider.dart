import 'package:flutter/material.dart';

class SeashellProvider extends ChangeNotifier {
  int _seashellCount = 0;

  int get seashellCount => _seashellCount;

  void incrementSeashell() {
    _seashellCount++;
    notifyListeners();
  }

  void decrementSeashell() {
    if (_seashellCount > 0) {
      _seashellCount--;
      notifyListeners();
    }
  }
}
