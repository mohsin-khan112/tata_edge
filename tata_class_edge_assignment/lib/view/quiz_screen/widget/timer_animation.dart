import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tata_class_edge_assignment/getx/controller/animation_controller.dart';
import 'package:tata_class_edge_assignment/getx/controller/subject_controller.dart';
import 'package:tata_class_edge_assignment/view/quiz_screen/quiz_screen.dart';

class TimerAnimation extends StatefulWidget {
  bool?  isCheck ;
   TimerAnimation({Key? key,this.isCheck}) : super(key: key);



  @override
  _TimerAnimationState createState() => _TimerAnimationState();
}

class _TimerAnimationState extends State<TimerAnimation> {
  final animationController = Get.put(AnimationControllers());
  final SubjectController cont = Get.find();

  @override
  void initState() {
    super.initState();

      Timer.periodic(const Duration(seconds: 1), (Timer t) {
        animationController.timerAnimation.value--;
        if (animationController.timerAnimation.value == 0) {
            t.cancel();
            Get.back();
            Get.back();
          }

      });

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      body: Container(
        height: double.infinity,
        width: double.infinity,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topRight,
            end: Alignment.bottomLeft,
            colors: [
              Colors.blue,
              Colors.lightBlue,
              Colors.blueAccent,
              Colors.lightBlueAccent
            ],
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.only(top: 60),
          child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const Text(
                  'Get Reddy!',
                  style: TextStyle(
                      decoration: TextDecoration.none,
                      color: Colors.white,
                      fontSize: 40,
                      fontWeight: FontWeight.bold),
                ),
                const SizedBox(
                  height: 150,
                ),
                Obx(
                  () => Text('${animationController.timerAnimation.value}',
                      style: const TextStyle(
                          decoration: TextDecoration.none,
                          color: Colors.white,
                          fontSize: 120,
                          fontWeight: FontWeight.bold)),
                )
              ]),
        ),
      ),
    );
  }
}
