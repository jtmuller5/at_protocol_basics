import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:injectable/injectable.dart';

@injectable
class ToastService {
  void showSnackbar(BuildContext context, String message) {
    Scaffold.of(context).showSnackBar(SnackBar(
      content: Text(
        message,
        textAlign: TextAlign.center,
      ),
    ));
  }

  Future<void> showToast(String message, {Color color = Colors.blueAccent}) async {
    await Fluttertoast.showToast(
        msg: message,
        toastLength: Toast.LENGTH_SHORT,
        gravity: ToastGravity.CENTER,
        timeInSecForIosWeb: 1,
        backgroundColor: color,
        textColor: Colors.white,
        fontSize: 16.0);
  }

  /// Simple function to close the keyboard. Used before showing a snackbar
  void closeKeyboard(BuildContext context) {
    FocusScope.of(context).requestFocus(FocusNode()); // Unfocus text fields on page change
  }

  bool isKeyBoardOpen(BuildContext context) {
    return MediaQuery.of(context).viewInsets.bottom == 0;
  }

  void unfocusAll(BuildContext context){
    FocusScope.of(context).requestFocus(FocusNode());
  }
}