import 'package:flutter/material.dart';

Future<void> showDialogReusable(BuildContext context, Widget contentDialog) {
  return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return contentDialog;
      });
}
