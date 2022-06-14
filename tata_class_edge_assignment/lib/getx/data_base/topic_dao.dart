import 'package:sqflite/sqflite.dart';
import 'package:tata_class_edge_assignment/getx/model/movie.dart';

import 'data-base_helper.dart';

class TopicDAO extends DatabaseHelper {
  static const TABLE_NAME = "movie";
  static const ID = "id";
  static const NAME = "name";

  static getCreateMovieTableQuery() {
    return """
      CREATE TABLE $TABLE_NAME
      (
        $ID INTEGER PRIMARY KEY,
        $NAME TEXT
      
       
      )
    """;
  }

  insertTopic(List<Topic> movies) async {
    Database? db = await getDatabase();
    movies.forEach((topic) async {
      await db.insert(TABLE_NAME, topic.toMap());
    });
  }

  Future<List<Topic>> fetchTopic() async {
    Database? db = await getDatabase();
    List<Map<String, dynamic>> movie = await db.query(TABLE_NAME);
    return movie.map((x) => Topic.fromMap(x)).toList();
  }
}
