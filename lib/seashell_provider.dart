import 'package:flutter/material.dart';

class SeashellProvider extends ChangeNotifier {
  int _seashellCount = 0;

  int get seashellCount => _seashellCount;

  // Method to add seashells
  void addSeashells(int amount) {
    _seashellCount += amount;
    notifyListeners();
  }

  // If you want to keep the updateSeashells method, you can do so
  // and make it do something different from addSeashells
  void updateSeashells(int amount) {
    // For example, you might want to update differently based on certain conditions
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
