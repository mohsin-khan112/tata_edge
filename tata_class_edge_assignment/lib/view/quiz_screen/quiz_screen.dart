import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tata_class_edge_assignment/getx/controller/subject_controller.dart';
import 'package:tata_class_edge_assignment/view/quiz_screen/widget/page_view_widget.dart';
import 'package:tata_class_edge_assignment/view/quiz_screen/widget/timer_animation.dart';
import 'package:tata_class_edge_assignment/view/quiz_screen/widget/timer_animation_second_screen.dart';

class QuizScreen extends StatefulWidget {
  const QuizScreen({Key? key}) : super(key: key);

  @override
  _QuizScreenState createState() => _QuizScreenState();
}

class _QuizScreenState extends State<QuizScreen> {
  SubjectController controller = Get.put(SubjectController());
  int timeSecond = 0;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    Timer.periodic(Duration(seconds: 1), (Timer t) {
      timeSecond++;
      if (timeSecond == 3) {
        t.cancel();
        controller.timerStart();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<SubjectController>(
        init: SubjectController(),
        builder: (controller) {
          return Scaffold(
            backgroundColor: Colors.blue.withAlpha(80),
            body: Obx(() => controller.isAnimation.value == true
                ? controller.isReadyAnimation.value == true
                    ? const TimerAnimationScreen()
                    : SingleChildScrollView(
                        child: Container(
                          height: MediaQuery.of(context).size.height,
                          width: MediaQuery.of(context).size.width,
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
                          padding: const EdgeInsets.only(
                              left: 24, right: 24, bottom: 16),
                          child: Column(
                            children: [
                              Expanded(
                                child: Obx(
                                  () => PageView.builder(
                                      controller: controller.pageController,
                                      itemCount:
                                          controller.allQuestionDetails.length,
                                      physics:
                                          const NeverScrollableScrollPhysics(),
                                      pageSnapping: false,
                                      itemBuilder: (context, index) {
                                        return controller.isReady.value == true
                                            ? TimerAnimation()
                                            : pageViewData(
                                                index: index, context: context);
                                      }),
                                ),
                              ),
                            ],
                          ),
                        ),
                      )
                : SingleChildScrollView(
                    child: Container(
                      height: MediaQuery.of(context).size.height,
                      width: MediaQuery.of(context).size.width,
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
                      padding: const EdgeInsets.only(
                          left: 24, right: 24, bottom: 16),
                      child: Column(
                        children: [
                          Expanded(
                            child: Obx(
                              () => PageView.builder(
                                  controller: controller.pageController,
                                  itemCount:
                                      controller.allQuestionDetails.length,
                                  physics: const NeverScrollableScrollPhysics(),
                                  pageSnapping: false,
                                  itemBuilder: (context, index) {
                                    return controller.isReady.value == true
                                        ? TimerAnimation()
                                        : pageViewData(
                                            index: index, context: context);
                                  }),
                            ),
                          ),
                        ],
                      ),
                    ),
                  )),
          );
        });
  }

  Widget card({text, optionValue, color}) {
    return Card(
      color: Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(15.0),
      ),
      child: Padding(
        padding: const EdgeInsets.only(right: 20, left: 20, top: 20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Container(
                height: 35,
                width: 35,
                decoration: BoxDecoration(
                    color: color,
                    shape: BoxShape.circle,
                    border: Border.all(width: 1, color: color)),
                child: Center(
                  child: Text(
                    text,
                    style: const TextStyle(
                        fontWeight: FontWeight.w500,
                        fontSize: 16,
                        color: Colors.white),
                  ),
                ),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Text(
              optionValue,
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 14,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Row innerProgressUI(SubjectController controller) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Obx(
          () => Text(
            controller.twoDigitMinutes.value +
                ":" +
                controller.twoDigitSeconds.value,
            style: const TextStyle(
              fontWeight: FontWeight.w800,
              fontSize: 36,
              color: Colors.white,
            ),
          ),
        )
      ],
    );
  }
}
