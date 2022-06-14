import 'package:shared_preferences/shared_preferences.dart';

class SharedPreferenceUtil {
  static const subject = "subject";
  static const englishAttemptedQuestion = "english_attemptedQuestion";
  static const englishRightAnswer = "english_right_answer";
  static const englishSpendTime = 'english_spend_time';
  static const mathsAttemptedQuestion = "maths_attemptedQuestion";
  static const mathsRightAnswer = "maths_right_answer";
  static const mathsSpendTime = 'maths_spend_time';
  static const historyAttemptedQuestion = "history_attemptedQuestion";
  static const historyRightAnswer = "history_right_answer";
  static const historySpendTime = 'history_spend_time';
  static const scienceAttemptedQuestion = "science_attemptedQuestion";
  static const scienceRightAnswer = "science_right_answer";
  static const scienceSpendTime = 'science_spend_time';
  static const isAnimation = 'is_animation';
  static const isEnable = 'is_enable';
  static const animationDuration = 'animation_duration';

  static final SharedPreferenceUtil _instance =
      SharedPreferenceUtil._internal();

  SharedPreferenceUtil._internal();

  static Future<SharedPreferences> _prefs = SharedPreferences.getInstance();

  //This is what's used to retrieve the instance through the app
  static SharedPreferenceUtil getInstance() {
    return _instance;
  }

  Future<bool> getBool(String key) async {
    final SharedPreferences preference = await _prefs;
    return preference.getBool(key) ?? false;
  }

  Future<void> setBool(String key, bool value) async {
    final SharedPreferences preference = await _prefs;
    await preference.setBool(key, value);
  }

  Future<String?> getString(String key) async {
    final SharedPreferences preference = await _prefs;
    return preference.getString(key);
  }

  Future<void> setString(String key, String? value) async {
    final SharedPreferences preference = await _prefs;
    if (value != null) {
      await preference.setString(key, value);
    }
  }

  Future<int?> getInt(String key) async {
    final SharedPreferences preference = await _prefs;
    return preference.getInt(key);
  }

  Future<void> setInt(String key, int? value) async {
    final SharedPreferences preference = await _prefs;
    await preference.setString(key, value.toString());
  }
}
