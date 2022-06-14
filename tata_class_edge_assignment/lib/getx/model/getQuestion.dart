

class GetQuestionDetails {
  GetQuestionDetails({
    this.questionId,
    this.data,
  });

  String? questionId;
  Data? data;

  static List<GetQuestionDetails>? fromJsonArray(List<dynamic>? dynamicJsonList) {
    List<GetQuestionDetails>? getQuestionDetails = dynamicJsonList?.map((e) => GetQuestionDetails.fromJson(e)).toList();
    return getQuestionDetails;
  }

  factory GetQuestionDetails.fromJson(Map<String, dynamic> json) =>
      GetQuestionDetails(
        questionId: json["questionID"],
        data: Data.fromJson(json["data"]),
      );

  Map<String, dynamic> toJson() => {
        "questionID": questionId,
        "data": data?.toJson(),
      };
}

class Data {
  Data({
    this.stimulus,
    this.options,
  });

  String? stimulus;
  List<Option>? options;

  factory Data.fromJson(Map<String, dynamic> json) => Data(
        stimulus: json["stimulus"],
        options:
            List<Option>.from(json["options"].map((x) => Option.fromJson(x))),
      );

  Map<String, dynamic> toJson() => {
        "stimulus": stimulus,
        "options": List<dynamic>.from(options!.map((x) => x.toJson())),
      };
}

class Option {
  Option({
    this.label,
    this.isCorrect,
  });

  String? label;
  int? isCorrect;

  factory Option.fromJson(Map<String, dynamic> json) => Option(
        label: json["label"],
        isCorrect: json["isCorrect"],
      );

  Map<String, dynamic> toJson() => {
        "label": label,
        "isCorrect": isCorrect,
      };
}
