import 'package:tata_class_edge_assignment/getx/data_base/subject_dao.dart';

class Subject {
  int? id;
  int? subjectID;
  String? question;
  String? optionA;
  String? optionB;
  String? optionC;
  String? optionD;
  String? correctOption;
  String? attemptedOption;

  Subject(

      { this.id,
        this.subjectID,
      this.question,
      this.optionA,
      this.optionB,
      this.optionC,
      this.optionD,
      this.correctOption,
      this.attemptedOption});

  Map<String, dynamic> toMap() {
    return {
      SubjectDAO.ID: id,
      SubjectDAO.SUBJECT_ID: subjectID,
      SubjectDAO.QUESTION: question,
      SubjectDAO.OPTION_A: optionA,
      SubjectDAO.OPTION_B: optionB,
      SubjectDAO.OPTION_C: optionC,
      SubjectDAO.OPTIONA_D: optionD,
      SubjectDAO.CORRECT_OPTION: correctOption,
      SubjectDAO.ATTEMPTED_OPTION: attemptedOption,
    };
  }

  Subject.fromMap(Map<String, dynamic> map)
      : id = map[SubjectDAO.ID],
        subjectID = map[SubjectDAO.SUBJECT_ID],
        question = map[SubjectDAO.QUESTION],
        optionA = map[SubjectDAO.OPTION_A],
        optionB = map[SubjectDAO.OPTION_B],
        optionC = map[SubjectDAO.OPTION_C],
        optionD = map[SubjectDAO.OPTIONA_D],
        correctOption = map[SubjectDAO.CORRECT_OPTION],
        attemptedOption = map[SubjectDAO.ATTEMPTED_OPTION];

  @override
  String toString() {
    return "Subject(id: $id,subjectID: $subjectID, question:$question,"
        " optionA:$optionA, optionB:$optionB,"
        "optionC:$optionC, optionD:$optionD, correctOption:$correctOption,attemptedOption:$attemptedOption)";
  }
}
