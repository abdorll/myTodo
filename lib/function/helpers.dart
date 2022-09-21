import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:my_todo/utils/color.dart';

class Alerts {
  static success(String message) {
    return BotToast.showSimpleNotification(
        title: 'Request successful',
        titleStyle: GoogleFonts.combo(
            color: white, fontSize: 14, fontWeight: FontWeight.w800),
        subTitle: message,
        subTitleStyle: GoogleFonts.combo(
            color: white, fontSize: 15, fontWeight: FontWeight.w500),
        duration: const Duration(seconds: 1),
        backgroundColor: Colors.green);
  }

  static failed(String message) {
    return BotToast.showSimpleNotification(
        title: 'Request failed!',
        titleStyle: GoogleFonts.combo(
            color: black, fontSize: 14, fontWeight: FontWeight.w800),
        subTitle: message,
        subTitleStyle: GoogleFonts.combo(
            color: black, fontSize: 15, fontWeight: FontWeight.w500),
        duration: const Duration(seconds: 2),
        backgroundColor: Colors.red);
  }

  static close() {
    return BotToast.closeAllLoading();
  }
}
