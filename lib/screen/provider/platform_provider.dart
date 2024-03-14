import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../model/model.dart';
import '../../utils/routs/shared_helper.dart';

class PlatformProvider with ChangeNotifier
{
  String? path;
  DateTime d1=DateTime.now();
  TimeOfDay t1=TimeOfDay.now();
  List <DataModel> platformList=[];
  List <DataModel> settingList=[];
  int pageIndex=0;
  bool isAndroid=true;
  String? addImage;
  String? editimage="";
  bool theme =false;
  bool changeTheme = false;
  ThemeMode mode = ThemeMode.light;
  IconData themeMode = Icons.dark_mode;
  bool isLight=false;

  void setTheme() async {
    theme = !theme;
    saveTheme(changeTheme: theme);
    changeTheme = (await applyTheme())!;
    if (changeTheme == true) {
      mode = ThemeMode.dark;
      themeMode = Icons.light_mode;
    } else if (changeTheme == false) {
      mode = ThemeMode.light;
      themeMode = Icons.dark_mode;
    }
    notifyListeners();
  }
  void getTheme() async {
    if (await applyTheme() == null) {
      changeTheme = false;
    } else {
      changeTheme = (await applyTheme())!;
    }
    if (changeTheme == true) {
      mode = ThemeMode.dark;
      themeMode = Icons.light_mode;
    } else if (changeTheme == false) {
      mode = ThemeMode.light;
      themeMode = Icons.dark_mode;
    } else {
      mode = ThemeMode.light;
      themeMode = Icons.dark_mode;
    }
    notifyListeners();
  }
  void changeThemdata()
  {
    isLight=!isLight;
    notifyListeners();
}


  void addPath(String p1)
  {
    path=p1;
    notifyListeners();
  }
  void changdate(DateTime d2)
  {
    d1=d2;
    notifyListeners();
  }
  void changetime(TimeOfDay t2)
  {
    t1=t2;
    notifyListeners();
  }
  void adddata(DataModel d1)
  {
    platformList.add(d1);
    notifyListeners();
  }
  void changePage({required int index})
  {
    pageIndex=index;
    notifyListeners();
  }
  void updateContact({required int index,required DataModel c2})
  {
    platformList[index]=c2;
    notifyListeners();
  }
  void updateContact2({required int index,required DataModel c2})
  {
    settingList[index]=c2;
    notifyListeners();
  }
  void edit(String i)
  {
    editimage=i;
    notifyListeners();
  }
  void editI(String p1)
  {
    addImage=p1;
    notifyListeners();
  }
  void deleteContact(int r)
  {
    platformList.removeAt(r);
    notifyListeners();
  }
  void changeui()
  {
    isAndroid=!isAndroid;
    notifyListeners();
  }

}