import 'package:get/get.dart';
import 'package:untitled/app_routers/screens.dart';

import '../ui/home_screen/home_page/view/home_screen.dart';
import '../ui/quiz_screen/view/quiz_screen.dart';

class AppRoutes {
  static final routes = [
    GetPage(name: Home.home, page: () => HomeScreen()),
    GetPage(name: Quiz.quiz, page: () => const QuizScreen(level: 'n5')), // ✅ thêm dòng này
  ];


}
