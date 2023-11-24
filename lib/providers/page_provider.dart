import 'package:flutter/material.dart';

class PageProvider extends ChangeNotifier {
  int currentPageIndex;

  PageProvider({this.currentPageIndex = 0});

  void chnageCurrentPageIndex(int _currentPageIndex) {
    currentPageIndex = _currentPageIndex;
    super.notifyListeners();
  }
}
