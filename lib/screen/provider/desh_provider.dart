import 'package:flutter/material.dart';

class DashProvider with ChangeNotifier
{
  int pageIndex=0;
  void changePage({required int index})
  {
    pageIndex=index;
    notifyListeners();
  }
}
