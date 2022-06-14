import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:tata_class_edge_assignment/getx/data_base/subject_dao.dart';
import 'package:tata_class_edge_assignment/getx/data_base/topic_dao.dart';

abstract class DatabaseHelper {
  final int dbVersion = 1;
  final String dbName = "getx.db";
  late String path;

  Future<Database> getDatabase() async {
    var databasesPath = await getDatabasesPath();
    path = join(databasesPath, dbName);
    Database database = await openDatabase(
      path,
      version: 1,
      onCreate: (Database db, int version) async {
        print('inside the ');
        db.execute(TopicDAO.getCreateMovieTableQuery());
        db.execute(SubjectDAO.getCreateSubjectTableQuery());
      },
    );

    return database;
  }
}
