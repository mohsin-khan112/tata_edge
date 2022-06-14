
import 'package:tata_class_edge_assignment/getx/data_base/topic_dao.dart';

class Topic {
  int? id;
  String? name;


  Topic({this.id,this.name, });

  Map<String, dynamic> toMap() {
    return {
      TopicDAO.ID: id,
      TopicDAO.NAME: name,

    };
  }

  Topic.fromMap(Map<String, dynamic> map)
      : id = map[TopicDAO.ID],
        name = map[TopicDAO.NAME];

  @override
  String toString() {
    return "MovieModel(id: $id, name: $name)";
  }
}
