import 'dart:async';

import 'package:crash_detection_and_analysis/utils/dialogs/logout_dialog.dart';
import 'package:crash_detection_and_analysis/utils/dialogs/show_error_dialog.dart';
import 'package:flutter/material.dart';

typedef DialogOptionBuilder<T> = Map<String, T?> Function();

Future<bool?> warningDialog({
  required BuildContext context,
  required String title,
  required String content,
  required DialogOptionBuilder dialogOptionBuilder,
  int timeInSeconds = 10,
}) {
  print("showDialog");
  return showDialog(
    context: context,
    barrierDismissible:
        false, // Prevent users from dismissing the dialog by tapping outside
    builder: (context) {
      Timer timer = Timer(Duration(seconds: timeInSeconds), () {
        Navigator.of(context).pop(true);
      });

      print('inside here');
      final options = dialogOptionBuilder();
      print('return WillPopScope');
      return WillPopScope(
        onWillPop: () async => false,
        child: AlertDialog(
          title: Text(title),
          content: Text(content),
          actions: options.keys.map((optionTitle) {
            final bool value = options[optionTitle];
            print('inside here 2');
            return TextButton(
              onPressed: () {
                print('inside here 3');
                Navigator.of(context).pop(value);
                timer.cancel();
              },
              child: Text(optionTitle),
            );
          }).toList(),
        ),
      );
    },
  );
}

// showDialog(
//     context: context,
//     barrierDismissible: false,
//     builder: (context) {
//       print('inside here');
//       final options = dialogOptionBuilder();
//       print('return WillPopScope');
//       return WillPopScope(
//         onWillPop: () async => false,
//         child: AlertDialog(
//           title: Text(title),
//           content: Text(content),
//           actions: options.keys.map((optionTitle) {
//             final bool value = options[optionTitle]!;
//             print('inside here 2');
//             return TextButton(
//               onPressed: () {
//                 print('inside here 3');
//                 Navigator.of(context).pop(value);
//               },
//               child: Text(optionTitle),
//             );
//           }).toList(),
//         ),
//       );
//     },
//   ).then((value) {
//     print("Dialog dismissed with value: $value");
//   });
// }
