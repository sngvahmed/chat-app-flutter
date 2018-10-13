class Todo {
    int _id;
    int _priority;
    String _title;
    String _description;
    String _date;

    Todo (this._date, this._priority, this._title, [this._description]); 
    Todo.WithId(this._id, this._date, this._priority, this._title, [this._description]);

    int get id => _id;
    int get priority => _priority;
    String get title => _title;
    String get description => _description;
    String get date => _date;

    set title(String newTitle){
        this._title = newTitle;
    }

    set description(String newDescription){
        this._description = newDescription;
    }

    set date(String newDate) {
        this._date = newDate;
    }

    set priority(int newProiproty) {
        this._priority = newProiproty;
    }

    Map <String, dynamic> toMap() {
        var map = Map<String, dynamic>();
        map["title"] = this._title;
        map["priority"] = this._priority;
        map["description"] = this._description;
        map["date"] = this._date;
        if (this._id != null)
            map["id"] = this._id;

        return map;
    }

    Todo.fromObject(dynamic o) {
        this._date = o["date"];
        this._description = o["description"];
        this._id = o["id"];
        this._priority = o["priority"];
        this._title = o["title"];
    } 
}