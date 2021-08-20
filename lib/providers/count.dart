import 'package:flutter/material.dart';

class Count with ChangeNotifier {
  int numOfItems = 1;

  void add() {
    numOfItems++;
    notifyListeners();
    print(numOfItems);
  }

  void sub() {
    if (numOfItems > 1) {
      numOfItems--;
      notifyListeners();
      print(numOfItems);
    }
  }

  void reset() {
    numOfItems = 1;
    notifyListeners();
    print(numOfItems);
  }
}
