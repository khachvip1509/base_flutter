import 'package:get/get.dart';
import 'package:untitled/app_routers/screens.dart';

import '../ui/home_screen/home_page/view/home_screen.dart';

class AppRoutes {
  static final routes = [GetPage(name: Home.home, page: () => HomeScreen())];
}
