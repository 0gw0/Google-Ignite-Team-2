import 'package:flutter/material.dart';

class SeashellProvider extends ChangeNotifier {
  int _seashellCount = 0;

  int get seashellCount => _seashellCount;

  // Method to add seashells
  void addSeashells(int amount) {
    _seashellCount += amount;
    notifyListeners();
  }

  void updateSeashells(int amount) {
    if (amount > 0) {
      _seashellCount += amount;
      notifyListeners();
    }
  }

  // Method to deduct seashells 
  void deductSeashells(int amount) {
    if (_seashellCount >= amount) {
      _seashellCount -= amount;
      notifyListeners();
    }
  }
}
