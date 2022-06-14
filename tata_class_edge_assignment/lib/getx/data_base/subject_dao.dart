import 'package:sqflite/sqflite.dart';
import 'package:tata_class_edge_assignment/getx/model/subject_model.dart';

import 'data-base_helper.dart';

class SubjectDAO extends DatabaseHelper {
  static const TABLE_NAME = "subject";
  static const ID = "id";
  static const SUBJECT_ID = "subject_id";
  static const QUESTION = "question";
  static const OPTION_A = "option_a";
  static const OPTION_B = "option_b";
  static const OPTION_C = "option_c";
  static const OPTIONA_D = "option_d";
  static const CORRECT_OPTION = "correct_option";
  static const ATTEMPTED_OPTION = "attempted_option";


  static getCreateSubjectTableQuery() {
    return """
      CREATE TABLE $TABLE_NAME
      (
        $ID INTEGER PRIMARY KEY,
        $SUBJECT_ID INTEGER,
        $QUESTION TEXT,
         $OPTION_A TEXT, 
         $OPTION_B TEXT,
          $OPTION_C TEXT,
           $OPTIONA_D TEXT,
            $CORRECT_OPTION TEXT,
            $ATTEMPTED_OPTION TEXT
           
      )
    """;
  }

  insertSubjectQuestion(List<Subject> subject) async {
    Database? db = await getDatabase();
    subject.forEach((subject) async {
      await db.insert(TABLE_NAME, subject.toMap());
    });
  }

  Future<List<Subject>> fetchSubject() async {
    Database? db = await getDatabase();
    List<Map<String, dynamic>> subject = await db.query(TABLE_NAME);
    return subject.map((x) => Subject.fromMap(x)).toList();
  }

  Future<List<Subject>> showEverySubjectData(int subjectId) async {
    Database db = await getDatabase();
    List<Map<String, dynamic>> subject = await db
        .query(TABLE_NAME, where: ' ${SUBJECT_ID} = ?', whereArgs: [subjectId]);
    print(" ShowLoginData :${subject.length}");

    return subject.length == 0
        ? []
        : subject.map((x) => Subject.fromMap(x)).toList();
  }

  Future<int> updateSubjectQuestion(Subject subject) async {
    Database? db = await getDatabase();
    return await db.update(TABLE_NAME, subject.toMap(),
        where: ' $ID = ?', whereArgs: [subject.id]);
  }
}
