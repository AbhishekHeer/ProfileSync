import 'package:get/get.dart';
import 'package:top_ai_assignment/screens/add_notes.dart';
import 'package:top_ai_assignment/screens/delete_screen.dart';
import 'package:top_ai_assignment/screens/home_screen.dart';
import 'package:top_ai_assignment/screens/login_screen.dart';
import 'package:top_ai_assignment/screens/logout_screen.dart';
import 'package:top_ai_assignment/screens/splash_screen.dart';

abstract class AppPages {
  static final pages = [
    GetPage(name: LoginScreen.routeName, page: () => LoginScreen()),
    GetPage(name: SplashScreen.routeName, page: () => SplashScreen()),
    GetPage(name: HomeScreen.routeName, page: () => HomeScreen()),
    GetPage(name: AddNotes.routeName, page: () => AddNotes()),
    GetPage(name: DeleteScreen.routeName, page: () => DeleteScreen()),
    GetPage(name: LogoutScreen.routeName, page: () => LogoutScreen()),
  ];
}
