import 'package:flutter/material.dart';

class Navigate {
  static forward(context, page) {
    Navigator.push(context, MaterialPageRoute(builder: ((context) {
      return page;
    })));
  }

  static forwardForever(context, page) {
    Navigator.pushAndRemoveUntil(context,
        MaterialPageRoute(builder: ((context) {
      return page;
    })), (route) => false);
  }

  static back(context) {
    Navigator.pop(context);
  }
}
