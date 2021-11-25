import 'package:flutter/cupertino.dart';

class HomeController extends ChangeNotifier {
  int selectedBottomTab = 0;
  void changeBottomNavTab(int index) {
    selectedBottomTab = index;
    notifyListeners();
  }

  bool isRightDoorLock = true;
  bool isLeftDoorLock = true;
  bool isBonnetLock = true;
  bool isTrunkLock = true;
  // this function work like setsate...
  void updateRightDoorLook() {
    isRightDoorLock = !isRightDoorLock;
    notifyListeners();
  }

  void updateLeftDoorLock() {
    isLeftDoorLock = !isLeftDoorLock;
    notifyListeners();
  }

  void updateBonnetLock() {
    isBonnetLock = !isBonnetLock;
    notifyListeners();
  }

  void updateTrunkLock() {
    isTrunkLock = !isTrunkLock;
    notifyListeners();
  }

  bool isColorSelected = true;
  void updateColorSelected() {
    isColorSelected = !isColorSelected;
    notifyListeners();
  }

  bool isShowTyre = false;
  void updateShowTyre(int index) {
    if (selectedBottomTab != 3 && index == 3) {
      Future.delayed(const Duration(milliseconds: 400), () {
        isShowTyre = true;
        notifyListeners();
      });
    } else {
      isShowTyre = false;
      notifyListeners();
    }
  }

  bool isTyreStatus = false;
  void updateTyreStatus(int index) {
    if (selectedBottomTab != 3 && index == 3) {
      isTyreStatus = true;
      notifyListeners();
    } else {
      Future.delayed(const Duration(milliseconds: 400), () {
        isTyreStatus = false;
        notifyListeners();
      });
    }
  }
}
