//This file contains our model class that contains all the methods, properties and constructors of our Todo object so we don't need to import anything


class Todo{
  //create properties that match the tod* table in the database. each representing each field
  //we make them inaccessible to other classes by starting with underscore to make them private

  int? _id;
  String? _title;
  String? _description;
  String? _date;
  int? _priority;


Todo.empty();
  Todo(this._title, this._date, this._priority, [this._description]);//the optional parameter is enclosed in a square bracket
//It is optional because it's a new description and the database has not assigned an id to it yet

Todo.withId(this._id, this._title, this._date, this._priority, [this._description]); //You can only have one unnamed constructor in a class hence the .withId (named constructor)
//therefore whenever we need to set a tod* with an id, we call the named constructor

  //getters and setters are not really needed in this app but its good to include them for understanding
int? get id => _id; //the fat arrow operator is used when you don't need to manipulate the value before returning it else the curly braces
String? get title => _title;
String? get description => _description;
String? get date => _date;
int get priority => _priority!;

//there will be no need to create setters for the id
  //errors can be thrown as well in the setter method
set title(String? newTitle){
  if(newTitle!.length <= 255){
    _title = newTitle;
  }
}

  set description(String? newDescription){
    if(newDescription!.length <= 255){
      _title = newDescription;
    }
  }

  set priority(int? newPriority){
    if(newPriority! >= 0  && newPriority <= 3){
      _priority = newPriority;
    }
  }

  set date(String? newDate){
  _date = newDate;
  }

  //Two important methods for this class
//Maps are collections of key-value pairs
  //here, we transform our Tod* into a map with String keys and dynamic values
  //this will come handy when we use some helper methods for SQLite
Map<String, dynamic> toMap(){
  var map = Map<String, dynamic>();
   map["title"] = _title;
  map["description"] = _title;
  map["priority"] = _priority;
  map["date"] = _date;
  if(_id != null){
    map["id"] = _id;
  }
   return map;

}

//The other important or last method is the named constructor which does exactly opposite of the toMap method
//we take in an object and transform it to our tod* object here, it's object dynamic o.
Todo.fromObject(dynamic o){
  //with or without the "this" keyword as per "this._id"
   _id = o["id"];
   _title = o["title"];
   _priority = o["priority"];
   _description = o["description"];
   _date = o["date"];
}

//Now we have completed our Model class; next is the helper class that interacts with the database in this case SQlite.


}