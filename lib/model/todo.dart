// //This file contains our model class that contains all the methods, properties and constructors of our Todo object so we don't need to import anything
//
// class Todo {
//   //create properties that match the tod* table in the database. each representing each field
//   //we make them inaccessible to other classes by starting with underscore to make them private
//
//   int? id;
//   String title;
//   String description;
//   String date;
//   int priority;
//
//   Todo({this.id, required this.title, required this.date, required this.priority,
//       required this.description, }); //the optional parameter is enclosed in a square bracket
// //It is optional because it's a new description and the database has not assigned an id to it yet
//
//   // Todo.withId(this._id, this._title, this._date, this._priority,
//   //     this._description); //You can only have one unnamed constructor in a class hence the .withId (named constructor)
// //therefore whenever we need to set a tod* with an id, we call the named constructor
//
//   //getters and setters are not really needed in this app but its good to include them for understanding
//   int? get todoId =>
//       id; //the fat arrow operator is used when you don't need to manipulate the value before returning it else the curly braces
//   String get todoTitle => title;
//   String get todoDescription => description;
//   String get todoDate => date;
//   int get toolPriority => priority;
//
// //there will be no need to create setters for the id
//   //errors can be thrown as well in the setter method
//   set todoTitle(String newTitle) {
//     if (newTitle.length <= 255) {
//       title = newTitle;
//     }
//   }
//
//   set todoDescription(String newDescription) {
//     if (newDescription.length <= 255) {
//       title = newDescription;
//     }
//   }
//
//   set todoPriority(int newPriority) {
//     if (newPriority >= 0 && newPriority <= 3) {
//       priority = newPriority;
//     }
//   }
//
//   set todoDate(String newDate) {
//     date = newDate;
//   }
//
//   //Two important methods for this class
// //Maps are collections of key-value pairs
//   //here, we transform our Tod* into a map with String keys and dynamic values
//   //this will come handy when we use some helper methods for SQLite
//   Map<String, dynamic> toMap() {
//     //var map = <String, dynamic>{};
//     return {
//       'id' : id,
//       'title': title,
//       'description' : description,
//       'priority' : priority,
//       'date' : date,
//     };
//   }
//
// //The other important or last method is the named constructor which does exactly opposite of the toMap method
// //we take in an object and transform it to our tod* object here, it's object dynamic o.
//   factory Todo.fromObject(dynamic o) {
//     return Todo(
//        // o["id"], o["title"], o["date"], o["priority"], o["description"]
//     id: o["id"],
//     title : o["title"],
//      priority : o["priority"],
//      description : o["description"],
//      date : o["date"],
//     );
//   }
// //Now we have completed our Model class; next is the helper class that interacts with the database in this case SQlite.
// }


class Todo{
  int? id;
  String title;
  int priority;
  String description;

  Todo({this.id, required this.title, required this.priority, required this.description});

 Map<String , dynamic> toMap(){
   return {
     'id': id,
     'title': title,
     'priority': priority,
     'description': description
   };
 }

 factory Todo.fromJson(Map<String, dynamic> json){
   return Todo(
   id: json['id'],
  title: json['title'],
  priority: json['priority'],
  description: json['description']
   );
  }
}


