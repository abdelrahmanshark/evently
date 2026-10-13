import 'package:evently/utils/app_colors.dart';
import 'package:fluttertoast/fluttertoast.dart';

class AppToast {
  /// Shows a short centered toast with [text].
  static void show(String text) {
    Fluttertoast.showToast(
      msg: text,
      toastLength: Toast.LENGTH_SHORT,
      gravity: ToastGravity.CENTER,
      timeInSecForIosWeb: 1,
      backgroundColor: AppColors.primaryColor,
      textColor: AppColors.blackColor,
      fontSize: 16,
    );
  }
}
