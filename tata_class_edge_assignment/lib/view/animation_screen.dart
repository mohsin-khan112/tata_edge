import 'package:flip_card/flip_card.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:tata_class_edge_assignment/getx/controller/animation_controller.dart';
import 'package:tata_class_edge_assignment/getx/controller/subject_controller.dart';

class AnimationScreen extends StatefulWidget {
  String? value;

  String? option;
  bool? isAnswer;
  int? index;

  AnimationScreen(
      {Key? key, this.value, this.option, this.isAnswer, this.index})
      : super(key: key);

  @override
  _AnimationScreenState createState() => _AnimationScreenState();
}

class _AnimationScreenState extends State<AnimationScreen> {
  RegExp exp = RegExp(r"<[^>]*>", multiLine: true, caseSensitive: true);
  AnimationControllers controller = Get.put(AnimationControllers());

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    controller.isValid.value = widget.isAnswer!;
    if (widget.index != null) {
      controller.index?.value = widget.index!;
    }
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<AnimationControllers>(
        init: AnimationControllers(),
        builder: (controller) {
          return Container(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topRight,
                end: Alignment.bottomLeft,
                colors: [
                  Colors.blue,
                  Colors.red,
                ],
              ),
            ),
            child: Padding(
              padding: const EdgeInsets.only(left: 32, right: 32),
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(
                      height: 220,
                      width: 220,
                      child: FlipCard(
                        key: controller.cardKey,
                        flipOnTouch: false,
                        front: Hero(
                          tag: 'card',
                          child: Card(
                            color: Colors.white,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(15.0),
                            ),
                            child: Padding(
                              padding:
                                  const EdgeInsets.only(right: 20, left: 20),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Center(
                                    child: Container(
                                      height: 35,
                                      width: 35,
                                      decoration: BoxDecoration(
                                          color: Colors.blue,
                                          shape: BoxShape.circle,
                                          border: Border.all(
                                              width: 1, color: Colors.blue)),
                                      child: Center(
                                        child: Text(
                                          widget.option!,
                                          style: const TextStyle(
                                              fontWeight: FontWeight.bold,
                                              fontSize: 16,
                                              color: Colors.white),
                                        ),
                                      ),
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  Center(
                                    child: text(
                                        text: widget.value
                                                ?.replaceAll('&nbsp;', '') ??
                                            ''),
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                        back: Card(
                          color: Colors.white,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(15.0),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.only(right: 20, left: 20),
                            child: Center(
                              child: Icon(
                                widget.isAnswer == true
                                    ? Icons.check
                                    : Icons.close,
                                size: 120,
                                color: widget.isAnswer == true
                                    ? Colors.green
                                    : Colors.red,
                              ),
                            ),
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ),
          );
        });
  }

  Widget text({
    text,
  }) {
    return Text(
      text.replaceAll(exp, '') ?? '',
      style: const TextStyle(
        fontWeight: FontWeight.w500,
        fontSize: 14,
      ),
    );
  }
}
