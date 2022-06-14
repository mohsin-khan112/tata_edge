class SettingModel {
  SettingModel({
    this.getReadyAnimation,
    this.timerAnimation,
  });

  bool? getReadyAnimation;
  TimerAnimation? timerAnimation;

  factory SettingModel.fromJson(Map<String, dynamic> json) => SettingModel(
        getReadyAnimation: json["get_ready_animation"],
        timerAnimation: TimerAnimation.fromJson(json["timer_animation"]),
      );
}

class TimerAnimation {
  TimerAnimation({
    this.enable,
    this.timer,
  });

  bool? enable;
  int? timer;

  factory TimerAnimation.fromJson(Map<String, dynamic> json) => TimerAnimation(
        enable: json["enable"],
        timer: json["timer"],
      );
}
