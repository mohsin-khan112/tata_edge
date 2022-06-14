import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tata_class_edge_assignment/constant/shared_prefence_util.dart';
import 'package:tata_class_edge_assignment/getx/controller/subject_controller.dart';
import 'package:tata_class_edge_assignment/view/quiz_screen/quiz_screen.dart';
import 'package:tata_class_edge_assignment/view/result_page/result_screen.dart';

class TopicScreen extends StatefulWidget {
  const TopicScreen({Key? key}) : super(key: key);

  @override
  _TopicScreenState createState() => _TopicScreenState();
}

class _TopicScreenState extends State<TopicScreen> {
  final sharedPreferenceUtil = SharedPreferenceUtil.getInstance();
  SharedPreferences? sharedPreferences;

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
          return Scaffold(
            appBar: AppBar(
              title: const Text('Topics'),
              centerTitle: false,
            ),
            body: controller.allTopicList.isNotEmpty
                ? Container(
                    padding:
                        const EdgeInsets.only(left: 16, right: 16, top: 20),
                    height: MediaQuery.of(context).size.height,
                    width: MediaQuery.of(context).size.width,
                    child: Obx(() => ListView.separated(
                          itemCount: controller.allTopicList.length,
                          itemBuilder: (context, index) {
                            return InkWell(
                              onTap: () async{
                                sharedPreferences = await SharedPreferences.getInstance();
                                if (index == 0) {
                                  sharedPreferenceUtil.setString(
                                      SharedPreferenceUtil.subject, 'maths');
                                  int? a = sharedPreferences?.getInt(SharedPreferenceUtil.mathsSpendTime);


                                  if (a == null) {
                                    Get.to(const QuizScreen());
                                  } else {
                                    Get.to(ResultScreen(attempted: 2,rightAnswer: 2,second: 17,));
                                  }
                                }

                                if (index == 1) {
                                  sharedPreferenceUtil.setString(
                                      SharedPreferenceUtil.subject, 'science');
                                  int? a = sharedPreferences?.getInt(
                                      SharedPreferenceUtil.scienceSpendTime);
                                  if (a == null) {
                                    Get.to(const QuizScreen());
                                  } else {
                                    Get.to(ResultScreen(attempted: 2,rightAnswer: 2,second: 16,));
                                  }
                                }
                                if (index == 2) {
                                  sharedPreferenceUtil.setString(
                                      SharedPreferenceUtil.subject, 'english');
                                  int? a = sharedPreferences?.getInt(
                                      SharedPreferenceUtil.englishSpendTime);
                                  if (a == null) {
                                    Get.to(const QuizScreen());
                                  } else {
                                    Get.to(ResultScreen(attempted: 2,rightAnswer: 2,second: 11,));
                                  }
                                }
                                if (index == 3) {
                                  sharedPreferenceUtil.setString(
                                      SharedPreferenceUtil.subject, 'history');
                                  int? a = sharedPreferences?.getInt(
                                      SharedPreferenceUtil.historySpendTime);
                                  if (a == null) {
                                    Get.to(const QuizScreen());
                                  } else {
                                    Get.to(ResultScreen(attempted: 2,rightAnswer: 2,second: 10,));
                                  }
                                }
                              },
                              child: Card(
                                child: Padding(
                                  padding: const EdgeInsets.only(
                                      left: 32, right: 32, top: 16, bottom: 16),
                                  child: Row(
                                    children: [
                                      Text(
                                        controller.allTopicList[index].name!,
                                        style: const TextStyle(
                                            color: Colors.black,
                                            fontSize: 20,
                                            fontWeight: FontWeight.w600),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            );
                          },
                          separatorBuilder: (BuildContext context, int index) {
                            return const SizedBox(
                              height: 10,
                            );
                          },
                        )),
                  )
                : const Center(
                    child: CircularProgressIndicator(
                      color: Colors.black,
                    ),
                  ),
          );
        });
  }
}
