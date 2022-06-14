import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tata_class_edge_assignment/constant/shared_prefence_util.dart';
import 'package:tata_class_edge_assignment/getx/controller/subject_controller.dart';
import 'package:tata_class_edge_assignment/routes/app_routes.dart';
import 'package:tata_class_edge_assignment/view/topic_screen/topic_screen.dart';

class ResultScreen extends StatefulWidget {
  int? attempted;

  int? rightAnswer;
  int? second;

  ResultScreen({Key? key, this.attempted, this.rightAnswer, this.second})
      : super(key: key);

  @override
  _ResultScreenState createState() => _ResultScreenState();
}

class _ResultScreenState extends State<ResultScreen> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<SubjectController>(
        init: SubjectController(),
        builder: (controller) {
          return WillPopScope(
            onWillPop: () async {
              controller.subjectValue.value = '';
              controller.rightAnswers.value = 0;
              controller.attempQuestion.value = 0;
              controller.spendTime.value = 0;
              Get.offAll(const TopicScreen());
              return false;
            },
            child: Scaffold(
              backgroundColor: Colors.blue.withAlpha(80),
              appBar: AppBar(
                backgroundColor: Colors.transparent,
                centerTitle: true,
                automaticallyImplyLeading: true,
                elevation: 0,
                title: Obx(
                  () => Text(
                    controller.subject.value.toUpperCase(),
                    style: const TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 16),
                  ),
                ),
                leading: Padding(
                  padding: const EdgeInsets.only(left: 20),
                  child: InkWell(
                    onTap: () {
                      controller.subjectValue.value = '';
                      controller.rightAnswers.value = 0;
                      controller.attempQuestion.value = 0;
                      controller.spendTime.value = 0;
                      Get.offAll(const TopicScreen());
                    },
                    child: Container(
                      height: 15,
                      width: 15,
                      decoration: const BoxDecoration(
                          color: Color(0xffF1F0EF), shape: BoxShape.circle),
                      child: const Center(
                        child: Icon(
                          Icons.arrow_back_ios,
                          color: Colors.black,
                          size: 14,
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              body: Padding(
                padding: const EdgeInsets.only(left: 32, right: 32, bottom: 16),
                child: Container(
                  child: Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        const Text(
                          'Total correct answers ${2}',
                          style: TextStyle(
                              color: Colors.white,
                              fontSize: 16,
                              fontWeight: FontWeight.w600),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        const Text('${2} Out of ${2} Questions',
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 16,
                                fontWeight: FontWeight.w600)),
                        const SizedBox(
                          height: 20,
                        ),
                        Text(
                            widget.second == null
                                ? ' Time spend ${controller.spendTime.value} Seconds '
                                : 'Time Spend ${widget.second} Seconds',
                            style: const TextStyle(
                                color: Colors.white,
                                fontSize: 16,
                                fontWeight: FontWeight.w600)),
                        const SizedBox(
                          height: 20,
                        ),
                        Card(
                          color: Colors.blue,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15.0),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.only(
                                top: 30, bottom: 10, right: 20, left: 20),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                const Text(
                                  'Your Final Score is',
                                  style: TextStyle(
                                      fontWeight: FontWeight.w500,
                                      fontSize: 16,
                                      color: Colors.white),
                                ),
                                const SizedBox(
                                  height: 30,
                                ),
                                Container(
                                  height: 100,
                                  width: 100,
                                  alignment: Alignment.center,
                                  decoration: BoxDecoration(
                                      color: Colors.white,
                                      shape: BoxShape.circle,
                                      border: Border.all(
                                          width: 1, color: Colors.white)),
                                  child: const Text(
                                    ' ${(2 * 50)}',
                                    style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 25,
                                        color: Colors.black54),
                                  ),
                                ),
                                const SizedBox(
                                  height: 30,
                                ),
                              ],
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ),
          );
        });
  }
}
