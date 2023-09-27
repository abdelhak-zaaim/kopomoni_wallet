import 'package:six_cash/util/app_constants.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ThemeController extends GetxController {
  final SharedPreferences sharedPreferences;
  ThemeController({required this.sharedPreferences}) {
    _loadCurrentTheme();
  }

  bool _darkTheme = false;
  bool get darkTheme => _darkTheme;

   bool _text2speach = true;
  bool get text2speach => _text2speach;


  Future<void> toggletext2speach() async {
    _text2speach = !_text2speach;
    SharedPreferences prefs = await SharedPreferences.getInstance();

    await prefs.setBool(AppConstants.text2speach, _text2speach);

   // sharedPreferences.setBool(AppConstants.text2speach, _text2speach);
    update();
  }


  void toggleTheme() {
    _darkTheme = !_darkTheme;

    sharedPreferences.setBool(AppConstants.theme, _darkTheme);
    update();
  }

  void _loadCurrentTheme() async {
    _darkTheme = sharedPreferences.getBool(AppConstants.theme) ?? false;
    SharedPreferences prefs = await SharedPreferences.getInstance();
    _text2speach = prefs.getBool(AppConstants.text2speach) ?? true;
    update();
  }
}
