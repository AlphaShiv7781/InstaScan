// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
//
// class ShowModal {
//   static void showLoadingModal(BuildContext context) {
//     showCupertinoModalPopup(
//       context: context,
//       builder: (context) {
//         return Scaffold(
//           backgroundColor: Colors.transparent,
//           body: SafeArea(
//             child: Center(
//               child: CircularProgressIndicator(
//                 color: Colors.blue,
//               ),
//             ),
//           ),
//         );
//       },
//     );
//   }
//
//   static void dismissLoadingModal(BuildContext context) {
//     Navigator.of(context, rootNavigator: true).pop();
//   }
// }

import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:loading_indicator/loading_indicator.dart';

class ShowModal {

   ShowModal({required this.title});

   final String title;

   void showLoadingModal(BuildContext context) {
    showCupertinoModalPopup(
      context: context,
      builder: (context) {
        return Scaffold(
          backgroundColor: Colors.cyan.shade50,
          body: Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                // Custom Animated Loader
                SizedBox(
                  height: 80,
                  width: 80,
                  child: LoadingIndicator(
                      indicatorType: Indicator.ballClipRotate,
                      colors: const [Colors.cyan],
                      strokeWidth: 10,
                      backgroundColor: Colors.transparent,
                      pathBackgroundColor: Colors.transparent,
                  ),
                ),
                SizedBox(height: 10),
                Text(
                  title,
                  style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold,fontFamily: 'Aldrich'),
                ),
              ],
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

