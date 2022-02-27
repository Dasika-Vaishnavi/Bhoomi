import 'package:flutter/cupertino.dart';

class CalendarData extends ChangeNotifier {
  int selectedIndex = 0;

  setIndexMonth(int _selectedIndex) {
    selectedIndex = _selectedIndex;
    notifyListeners();
  }
}
