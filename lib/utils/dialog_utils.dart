import 'package:flutter/material.dart';

class dialogUtils {
  static void ShowProgressDialog(BuildContext context, String Message,
      {bool isDismisble = false}) {
    showDialog(
        context: context,
        builder: (builcontext) {
          return AlertDialog(
            content: Row(
              children: [
                CircularProgressIndicator(),
                SizedBox(
                  width: 10,
                ),
                Text(Message)
              ],
            ),
          );
        },
        barrierDismissible: isDismisble);
  }

  static void showMessage(
    BuildContext context,String title, {

    String? posaction,
    String? negaction,
    VoidCallback? actionpos,
    VoidCallback? actionneg,
    bool isDismisible = false,
  }) {
    List<Widget> actions = [];
    if (posaction != null) {
      actions.add(TextButton(
          onPressed: () {
            Navigator.pop(context);
            if(actionpos!=null)
              {
               actionpos();
              }
          },
          child: Text(posaction)));
    }
    if (negaction != null) {
      actions.add(TextButton(onPressed: () {
        Navigator.pop(context);
        if(actionneg!=null)
        {
          actionneg();
        }
      }, child: Text(negaction)));
    }
    showDialog(
        context: context,
        builder: (builcontext) {
          return AlertDialog(
            content: Text(title),
            actions: actions,
          );
        },
        barrierDismissible: isDismisible);
  }

  static void hideDialog(BuildContext context) {
    Navigator.pop(context);
  }
}
