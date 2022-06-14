import 'dart:async';

import 'package:flip_card/flip_card.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tata_class_edge_assignment/view/quiz_screen/widget/timer_animation.dart';
import 'package:tata_class_edge_assignment/view/result_page/result_screen.dart';

class AnimationControllers extends GetxController {
  GlobalKey<FlipCardState> cardKey = GlobalKey<FlipCardState>();
  int time = 0;
  int a = 1;
  RxInt timerAnimation = 3.obs;
  RxBool isValid = true.obs;
  RxInt? index = 0.obs;

  @override
  void onInit() {
    super.onInit();
    Timer.periodic(const Duration(seconds: 1), (Timer t) {
      time++;
      if (time == 1) {
        cardKey.currentState!.toggleCard();
      }
      if (time == 2) {
        t.cancel();
        if (index?.value == 0) {
          if (isValid.isTrue) {
            Get.to(TimerAnimation(
              isCheck: true,
            ));
          } else {
            Get.back();
          }
        } else {
          Get.to( ResultScreen());
        }
      }
    });
  }
}
