//------------------------ App Global Vars -----------------
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

bool isAppDark = false;
bool isAppArabic = false;

//----------------------------------------------------------
void addToast({required String msg, required ToastType type}) {
  Fluttertoast.showToast(
    msg: msg,
    fontSize: 16,
    toastLength: Toast.LENGTH_LONG,
    gravity: ToastGravity.BOTTOM,
    timeInSecForIosWeb: 5,
    backgroundColor: returnColor(type: type),
    textColor: Colors.white,
  );
}

enum ToastType { error, warning, success }

Color returnColor({required ToastType type}) {
  Color color;
  switch (type) {
    case ToastType.error:
      color = Colors.red;
      break;
    case ToastType.warning:
      color = Colors.yellowAccent;
      break;
    case ToastType.success:
      color = Colors.green;
      break;
  }
  return color;
}
