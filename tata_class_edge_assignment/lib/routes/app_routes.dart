import 'package:get/get_navigation/src/routes/get_route.dart';
import 'package:tata_class_edge_assignment/view/animation_screen.dart';
import 'package:tata_class_edge_assignment/view/quiz_screen/quiz_screen.dart';
import 'package:tata_class_edge_assignment/view/result_page/result_screen.dart';
import 'package:tata_class_edge_assignment/view/topic_screen/topic_screen.dart';

class Routes {
  static const firstScreen = '/firstScreen';
  static const quizScreen = '/quizScreen ';
  static const resultScreen = '/resultScreen ';
  static const animationScreen = '/animationScreen ';
}

class AppPages {
  static final pages = <GetPage>[
    GetPage(
      name: Routes.firstScreen,
      page: () => const TopicScreen(),
    ),
    GetPage(
      name: Routes.quizScreen,
      page: () => const QuizScreen(),
    ),
    GetPage(
      name: Routes.resultScreen,
      page: () => ResultScreen(),
    ),

  ];
}
