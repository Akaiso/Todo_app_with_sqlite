

class Task{
  int? id;
  String title;
  String description;
  int? priority;

  Task({this.id, required this.title, required this.description,  this.priority});

  Map<String , dynamic> toMap(){
    return {
      'id': id,
      'title': title,
      'description': description,
      'priority': priority
    };
  }

  factory Task.fromObject(Map<String , dynamic > json){
    return Task(
      id: json['id'],
      title: json['title'],
      description: json['description'],
      priority: json['priority']
    );
  }
}