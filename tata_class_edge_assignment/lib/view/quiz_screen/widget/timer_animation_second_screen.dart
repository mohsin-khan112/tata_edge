import 'package:flutter/material.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get/get_instance/src/extension_instance.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:tata_class_edge_assignment/getx/controller/subject_controller.dart';

class TimerAnimationScreen extends StatefulWidget {
  const TimerAnimationScreen({Key? key}) : super(key: key);

  @override
  _TimerAnimationScreenState createState() => _TimerAnimationScreenState();
}

class _TimerAnimationScreenState extends State<TimerAnimationScreen> {
  final controller = Get.put(SubjectController());
    @override
  void initState() {
    // TODO: implement initState
    super.initState();
    controller.timerAnimationStart();
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
                      () => Text('${controller.timerAnimation.value}',
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
