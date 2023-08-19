import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

void navigatorAndFinish(context, widget) => Navigator.pushAndRemoveUntil(
      context,
      MaterialPageRoute(
        builder: (context) => widget,
      ),
      (route) => false,
    );

void navigatorTo(context, widget) => Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => widget,
      ),
    );

Widget defultTextButton({
  required Function() function,
  required String text,
}) {
  return TextButton(
    onPressed: function,
    child: Text(
      text.toUpperCase(),
    ),
  );
}

showTost({
  required String text,
}) {
  return Fluttertoast.showToast(
      msg: text,
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.CENTER,
      timeInSecForIosWeb: 1,
      backgroundColor: Colors.red,
      textColor: Colors.white,
      fontSize: 16.0);
}

// Widget defultAppBar({
//   required BuildContext context,
//   String? title,
//   List<PreferredSizeWidget>? actions,
// }) {
//   return AppBar(
//     title: Text(title!),
//     actions: actions,
//     leading: IconButton(
//       icon: const Icon(
//         Icons.arrow_back_ios_new,
//       ),
//       onPressed: () {
//         Navigator.pop(context);
//       },
//     ),
//   );
// }
