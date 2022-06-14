import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tata_class_edge_assignment/constant/shared_prefence_util.dart';
import 'package:tata_class_edge_assignment/getx/data_base/subject_dao.dart';
import 'package:tata_class_edge_assignment/getx/data_base/topic_dao.dart';
import 'package:tata_class_edge_assignment/getx/model/getQuestion.dart';
import 'package:tata_class_edge_assignment/getx/model/movie.dart';
import 'package:tata_class_edge_assignment/getx/model/setting_model.dart';
import 'package:tata_class_edge_assignment/getx/model/subject_model.dart';

class SubjectController extends GetxController {
  TopicDAO topicDAO = TopicDAO();
  SubjectDAO subjectDAO = SubjectDAO();
  List<Topic> topicList = [];
  RxList<Topic> allTopicList = <Topic>[].obs;
  RxList<Subject> subjectQuestionList = <Subject>[].obs;
  RxList<Subject> allSubjectQuestionList = <Subject>[].obs;
  RxList<Subject> everySubjectQuestionList = <Subject>[].obs;
  RxString subjectValue = ''.obs;
  RxInt timer = 20.obs;
  RxDouble percent = 0.0.obs;
  RxString twoDigitMinutes = "0".obs;
  RxString twoDigitSeconds = "00".obs;
  RxInt attempQuestion = 0.obs;
  RxInt rightAnswers = 0.obs;
  RxList<GetQuestionDetails> firstQuestionList = <GetQuestionDetails>[].obs;
  RxList<GetQuestionDetails> secondQuestionList = <GetQuestionDetails>[].obs;
  RxList<GetQuestionDetails> allQuestionDetails = <GetQuestionDetails>[].obs;
  RxBool isReady = false.obs;
  RxBool isReadyAnimation = true.obs;
  Timer? timerOn;
  RxInt spendTime = 0.obs;
  RxInt timerAnimation = 3.obs;
  SharedPreferences? sharedPreferences;

  final sharedPreferenceUtil = SharedPreferenceUtil.getInstance();
  RxInt mathsSpendTime = 0.obs;
  RxInt mathsAttemptedAnswer = 0.obs;
  RxInt mathsRightAnswer = 0.obs;
  RxInt historySpendTime = 0.obs;
  RxInt historyAttemptedAnswer = 0.obs;
  RxInt historyRightAnswer = 0.obs;
  RxInt englishSpendTime = 0.obs;
  RxInt englishAttemptedAnswer = 0.obs;
  RxInt englishRightAnswer = 0.obs;
  RxInt scienceSpendTime = 0.obs;
  RxInt scienceAttemptedAnswer = 0.obs;
  RxInt scienceRightAnswer = 0.obs;
  RxString subject = ''.obs;
  RxBool isAnimation = true.obs;
  RxBool isEnable = true.obs;
  RxInt isAnimationDuration = 20.obs;

  PageController pageController =
      PageController(viewportFraction: 1, keepPage: true);
  RegExp exp = RegExp(r"<[^>]*>", multiLine: true, caseSensitive: true);

  @override
  void onInit() async {
    super.onInit();
    await loadJsonData();
    await loadJsonSecondData();
    await loadSettingData();
    await addQuestionListData();
    await addSubjectData();
    await fetchData();
    sharedPreferences = await SharedPreferences.getInstance();
  }

  timerStart({int? index}) {
    if (isEnable.value == true ) {
      timer.value = isAnimationDuration.value;
      timerOn = Timer.periodic(const Duration(seconds: 1), (Timer t) {
        spendTime.value = spendTime.value + 1;
        var duration = Duration(seconds: isAnimationDuration.value);
        String twoDigits(int n) => n.toString().padLeft(2, "0");
        twoDigitSeconds.value = twoDigits(duration.inSeconds.remainder(60));
        percent.value = 1 - (isAnimationDuration.value / timer.value);
        if (isAnimationDuration.value == 0) {
        } else {
          isAnimationDuration.value = isAnimationDuration.value - 1;
        }
      });
    }
  }

  timerAnimationStart() {
    timerOn = Timer.periodic(Duration(seconds: 1), (Timer t) {
      timerAnimation.value--;
      if (timerAnimation.value == 0) {
        t.cancel();
        isReadyAnimation.value = false;
      }
    });
  }

  addSubjectData() async {
    topicList = [
      Topic(
        id: 1,
        name: "Maths",
      ),
      Topic(
        id: 2,
        name: "Science",
      ),
      Topic(
        id: 3,
        name: "English",
      ),
      Topic(
        id: 4,
        name: "History",
      ),
    ];
    topicDAO.insertTopic(topicList);
    update();
  }

  fetchData() async {
    var list = await topicDAO.fetchTopic();
    allTopicList.addAll(list);
    update();
  }

  fetchResult() async {
    subject.value =
        (await sharedPreferenceUtil.getString(SharedPreferenceUtil.subject))!;
    mathsSpendTime.value =
        (sharedPreferences?.getInt(SharedPreferenceUtil.mathsSpendTime))!;
    mathsAttemptedAnswer.value = (sharedPreferences
        ?.getInt(SharedPreferenceUtil.mathsAttemptedQuestion))!;
    mathsRightAnswer.value =
        (sharedPreferences?.getInt(SharedPreferenceUtil.mathsRightAnswer))!;
    historySpendTime.value =
        (sharedPreferences?.getInt(SharedPreferenceUtil.historySpendTime))!;
    historyRightAnswer.value =
        (sharedPreferences?.getInt(SharedPreferenceUtil.historyRightAnswer))!;
    historyAttemptedAnswer.value = (sharedPreferences
        ?.getInt(SharedPreferenceUtil.historyAttemptedQuestion))!;
    englishSpendTime.value =
        (sharedPreferences?.getInt(SharedPreferenceUtil.englishSpendTime))!;
    englishRightAnswer.value =
        (sharedPreferences?.getInt(SharedPreferenceUtil.englishRightAnswer))!;
    englishAttemptedAnswer.value = (sharedPreferences
        ?.getInt(SharedPreferenceUtil.englishAttemptedQuestion))!;
    scienceSpendTime.value =
        (sharedPreferences?.getInt(SharedPreferenceUtil.scienceSpendTime))!;
    scienceRightAnswer.value =
        (sharedPreferences?.getInt(SharedPreferenceUtil.scienceRightAnswer))!;
    scienceAttemptedAnswer.value = (sharedPreferences
        ?.getInt(SharedPreferenceUtil.scienceAttemptedQuestion))!;
  }

  addSharedPrefenceData(String subject) async {
    if (subject == 'english') {
      sharedPreferences?.setInt(
          SharedPreferenceUtil.englishAttemptedQuestion, attempQuestion.value);
      sharedPreferences?.setInt(
          SharedPreferenceUtil.englishRightAnswer, rightAnswers.value);
      sharedPreferences?.setInt(
          SharedPreferenceUtil.englishSpendTime, spendTime.value);
    }
    if (subject == 'maths') {
      sharedPreferences?.setInt(
          SharedPreferenceUtil.mathsAttemptedQuestion, attempQuestion.value);
      sharedPreferences?.setInt(
          SharedPreferenceUtil.mathsRightAnswer, rightAnswers.value);
      sharedPreferences?.setInt(
          SharedPreferenceUtil.mathsSpendTime, spendTime.value);
    }
    if (subject == 'science') {
      sharedPreferences?.setInt(
          SharedPreferenceUtil.scienceAttemptedQuestion, attempQuestion.value);
      sharedPreferences?.setInt(
          SharedPreferenceUtil.scienceRightAnswer, rightAnswers.value);
      sharedPreferences?.setInt(
          SharedPreferenceUtil.scienceSpendTime, spendTime.value);
    }
    if (subject == 'history') {
      sharedPreferences?.setInt(
          SharedPreferenceUtil.historyAttemptedQuestion, attempQuestion.value);
      sharedPreferences?.setInt(
          SharedPreferenceUtil.historyRightAnswer, rightAnswers.value);
      sharedPreferences?.setInt(
          SharedPreferenceUtil.historySpendTime, spendTime.value);
    }
  }

  /* addQuestion() async {
    subjectQuestionList.value = [
      Subject(
        id: 1,
        subjectID: 1,
        question: 'How Many Ruppes do  Ten Thousand Paise Make?',
        optionA: '10',
        optionB: '100',
        optionC: '1000',
        optionD: '10000',
        correctOption: '100',
      ),
      Subject(
        id: 2,
        subjectID: 1,
        question: 'Which of These Fraction Has heighest MatheMatical Value?',
        optionA: '1/2',
        optionB: '2/3',
        optionC: '3/4',
        optionD: '4/5',
        correctOption: '4/5',
      ),
      Subject(
          id: 3,
          subjectID: 2,
          question:
              "A Four Chambered Heart is Found in Which  Of The Following?",
          optionA: 'Mammals only',
          optionB: 'Mammals & Fish ',
          optionC: 'Mammals & Birds',
          optionD: " Amphibians",
          correctOption: 'Mammals & Birds'),
      Subject(
          id: 4,
          subjectID: 2,
          question: 'What is Involved in The Relase Of Pollegen grains?',
          optionA: 'pectin & Cellulose',
          optionB: 'Lignoc Cellulose',
          optionC: 'PollenKit',
          optionD: 'Sporopollenin',
          correctOption: 'Sporopollenin'),
      Subject(
          id: 5,
          subjectID: 3,
          question: 'Find The Correct Spelt Word',
          optionA: 'Adverisity',
          optionB: 'Advercety',
          optionC: 'Adversity',
          optionD: 'Advercity',
          correctOption: 'Adversity'),
      Subject(
          id: 6,
          subjectID: 3,
          question: 'Person Who Does not Believe in The Existence of God',
          optionA: 'Theist',
          optionB: 'Heretic',
          optionC: 'Atheist',
          optionD: 'Fanatic',
          correctOption: 'Atheist'),
      Subject(
          id: 7,
          subjectID: 4,
          question: 'Who was the founder of Andhra Mahila Sabha?',
          optionA: 'Pandit Rambai',
          optionB: 'Durghabai ',
          optionC: 'Gayatri Devi',
          optionD: 'Sarojini Naidu',
          correctOption: 'Durghabai '),
      Subject(
          id: 8,
          subjectID: 4,
          question: 'Where did Mahahtma Gandhi Start The Salt Satyagraha?',
          optionA: 'Dandi',
          optionB: 'Sabarmati',
          optionC: 'Sevagram',
          optionD: 'Pawanar',
          correctOption: 'Sabarmati')
    ];
    subjectDAO.insertSubjectQuestion(subjectQuestionList);
    await fetchSubjectQuestion();
    update();
  }*/

  /* fetchSubjectQuestion() async {
    var list = await subjectDAO.fetchSubject();
    allSubjectQuestionList.addAll(list);
  }

  fetchSubjectWiseQuestion(int subjectId) async {
    everySubjectQuestionList.value =
        await subjectDAO.showEverySubjectData(subjectId);
  }

  attemptedQuizUpdate(Subject subject, String attemptedOption) async {
    Subject subject1 = Subject(
      id: subject.id,
      question: subject.question,
      optionA: subject.optionA,
      optionB: subject.optionB,
      optionC: subject.optionC,
      optionD: subject.optionD,
      correctOption: subject.correctOption,
      attemptedOption: attemptedOption,
    );
    await subjectDAO.updateSubjectQuestion(subject1);
  }
*/

  loadJsonData() async {
    var jsonText = await rootBundle.loadString('assets/json/question1.json');
    var data = json.decode(jsonText);
    firstQuestionList.value = GetQuestionDetails.fromJsonArray(data)!;
  }

  loadJsonSecondData() async {
    var jsonText = await rootBundle.loadString('assets/json/question2.json');
    var data = json.decode(jsonText);
    secondQuestionList.value = GetQuestionDetails.fromJsonArray(data)!;
  }

  loadSettingData() async {
    var jsonText = await rootBundle.loadString('assets/json/setting.json');
    var data = json.decode(jsonText);
    var model = SettingModel.fromJson(data);
    isAnimation.value = model.getReadyAnimation!;
    isEnable.value = model.timerAnimation!.enable!;
    isAnimationDuration.value = model.timerAnimation!.timer!;
  }

  addQuestionListData() {
    allQuestionDetails.value = [...firstQuestionList, ...secondQuestionList];
  }
}
