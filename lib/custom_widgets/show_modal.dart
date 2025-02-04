import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ShowModal {
  static void showLoadingModal(BuildContext context) {
    showCupertinoModalPopup(
      context: context,
      builder: (context) {
        return Scaffold(
          backgroundColor: Colors.transparent,
          body: SafeArea(
            child: Center(
              child: CircularProgressIndicator(
                color: Colors.blue,
              ),
            ),
          ),
        );
      },
    );
  }

  static void dismissLoadingModal(BuildContext context) {
    Navigator.of(context, rootNavigator: true).pop();
  }
}