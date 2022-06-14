import 'dart:async';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:percent_indicator/circular_percent_indicator.dart';
import 'package:tata_class_edge_assignment/constant/shared_prefence_util.dart';
import 'package:tata_class_edge_assignment/getx/controller/subject_controller.dart';
import 'package:tata_class_edge_assignment/view/result_page/result_screen.dart';

import '../../animation_screen.dart';

Widget pageViewData({index, context}) {
  return GetBuilder<SubjectController>(
      init: SubjectController(),
      builder: (controller) {
        return Column(
          children: [
            SizedBox(
              height: MediaQuery.of(context).size.height / 8,
            ),
            const Text(
              'Oh My Quiz',
              style: TextStyle(color: Colors.white, fontSize: 20),
            ),
            const SizedBox(
              height: 20,
            ),
            SizedBox(
              height: 70,
              child: text(
                  text: controller.allQuestionDetails[index].data?.stimulus
                          ?.replaceAll('&nbsp;', '') ??
                      '',
                  controller: controller),
            ),
            const SizedBox(
              height: 25,
            ),
            Obx(
              () => Visibility(
                visible: controller.isEnable.value,
                child: CircularPercentIndicator(
                  radius: 140,
                  lineWidth: 5,
                  reverse: false,
                  percent: controller.percent.value,
                  center: innerProgressUI(controller),
                  backgroundColor: Colors.grey,
                  circularStrokeCap: CircularStrokeCap.butt,
                  progressColor: Colors.red,
                ),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Obx(
              () => GridView.builder(
                shrinkWrap: true,
                itemCount:
                    controller.allQuestionDetails[index].data?.options?.length,
                physics: const NeverScrollableScrollPhysics(),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2, childAspectRatio: 2 / 2),
                itemBuilder: (context, index2) {
                  return Hero(
                      tag: 'card',
                      child: InkWell(
                          onTap: () async {
                            if (controller.isAnimation.value == true) {
                              if (controller.allQuestionDetails[index].data
                                      ?.options![index2].isCorrect ==
                                  1) {
                                controller.attempQuestion.value =
                                    controller.attempQuestion.value + 1;
                                controller.rightAnswers.value =
                                    controller.rightAnswers.value + 1;
                                if (index == 0) {
                                  controller.timerOn!.cancel();
                                  Get.to(
                                    AnimationScreen(
                                      value: controller
                                          .allQuestionDetails[index]
                                          .data
                                          ?.options![index2]
                                          .label,
                                      option: index2 == 0
                                          ? "A"
                                          : index2 == 1
                                              ? "B"
                                              : index2 == 2
                                                  ? 'C'
                                                  : "D",
                                      isAnswer: true,
                                    ),
                                  );
                                  controller.isReady.value == true;
                                  int value =4;
                                  Timer.periodic(const Duration(seconds: 1),
                                      (Timer t) {
                                    value--;
                                    if (value == 0) {
                                      controller.isAnimationDuration.value =
                                          controller.timer.value;
                                      controller.percent.value = 0;
                                      controller.isReady.value == false;
                                      controller.timerStart(index: index2);
                                      t.cancel();
                                      controller.pageController.jumpToPage(1);
                                    }
                                  });
                                } else {
                                  controller.timerOn!.cancel();
                                  final sharedPreferenceUtil =
                                      SharedPreferenceUtil.getInstance();
                                  String? subject = await sharedPreferenceUtil
                                      .getString(SharedPreferenceUtil.subject);
                                  controller.addSharedPrefenceData(subject!);

                                  Get.to(
                                    AnimationScreen(
                                      value: controller
                                          .allQuestionDetails[index]
                                          .data
                                          ?.options![index2]
                                          .label,
                                      option: index2 == 0
                                          ? "A"
                                          : index2 == 1
                                              ? "B"
                                              : index2 == 2
                                                  ? 'C'
                                                  : "D",
                                      isAnswer: true,
                                      index: 1,
                                    ),
                                  );
                                }
                              } else {
                                if (index == 0) {
                                  controller.timerOn!.cancel();
                                  Get.to(
                                    AnimationScreen(
                                      value: controller
                                          .allQuestionDetails[index]
                                          .data
                                          ?.options![index2]
                                          .label,
                                      option: index2 == 0
                                          ? "A"
                                          : index2 == 1
                                              ? "B"
                                              : index2 == 2
                                                  ? 'C'
                                                  : "D",
                                      isAnswer: false,
                                    ),
                                  );
                                  int value = 2;
                                  Timer.periodic(const Duration(seconds: 1),
                                      (Timer t) {
                                    value--;
                                    if (value == 0) {
                                      controller.isAnimationDuration.value =
                                          controller.timer.value;
                                      controller.percent.value = 0;
                                      controller.isReady.value == false;
                                      controller.timerStart(index: index2);
                                      t.cancel();
                                      controller.pageController.jumpToPage(0);
                                    }
                                  });
                                } else {
                                  controller.timerOn!.cancel();
                                  Get.to(
                                    AnimationScreen(
                                      value: controller
                                          .allQuestionDetails[index]
                                          .data
                                          ?.options![index2]
                                          .label,
                                      option: index2 == 0
                                          ? "A"
                                          : index2 == 1
                                              ? "B"
                                              : index2 == 2
                                                  ? 'C'
                                                  : "D",
                                      isAnswer: false,
                                    ),
                                  );
                                  int value = 2;
                                  Timer.periodic(const Duration(seconds: 1),
                                      (Timer t) {
                                    value--;
                                    if (value == 0) {
                                      controller.isAnimationDuration.value =
                                          controller.timer.value;
                                      controller.percent.value = 0;
                                      controller.isReady.value == false;
                                      controller.timerStart(index: index2);
                                      t.cancel();
                                      controller.pageController.jumpToPage(1);
                                    }
                                  });
                                }
                              }
                            } else {}
                          },
                          child: card(
                              controller: controller,
                              color: index2 == 0
                                  ? Colors.yellow
                                  : index2 == 1
                                      ? Colors.blue
                                      : index2 == 2
                                          ? Colors.green
                                          : Colors.red,
                              text: index2 == 0
                                  ? "A"
                                  : index2 == 1
                                      ? "B"
                                      : index2 == 2
                                          ? 'C'
                                          : "D",
                              optionValue: controller.allQuestionDetails[index]
                                  .data?.options![index2].label!
                                  .replaceAll('&nbsp;', ''))));
                },
              ),
            )
          ],
        );
      });
}

Widget card({text, optionValue, color, SubjectController? controller}) {
  return Card(
    color: Colors.white,
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(15.0),
    ),
    child: Padding(
      padding: const EdgeInsets.only(right: 20, left: 20, top: 20),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
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
          Center(
            child: Text(
              optionValue.replaceAll(controller!.exp, ''),
              style: const TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 14,
              ),
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

Widget text({text, SubjectController? controller}) {
  return Text(
    text.replaceAll(controller!.exp, '') ?? '',
    style: const TextStyle(
        fontWeight: FontWeight.w600, fontSize: 18, color: Colors.white),
  );
}
