import 'package:flutter/material.dart';
import 'package:todolist/list.dart';

void main() => runApp(new TodoListApp());

class TodoListApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return new MaterialApp(
      home: ToDoListAppState(),
    );
  }
}

class ToDoListAppState extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    return new ToDoList();
  }
}

class ToDoList extends State<ToDoListAppState> {

  _addListView() {
    var _title;
    var _content;
    var _time;
    return showDialog<Null>(
        context: context,
        barrierDismissible: true,
        builder: (context) {
          return AlertDialog(
            title: new Text("Your Todo"),
            content: new SingleChildScrollView(
              child: new ListBody(
                children: <Widget>[
                  new TextField(
                      decoration:
                          new InputDecoration(labelText: "Add your title"),
                      onChanged: (String text) {
                        _title = text;
                      }),
                  new TextField(
                    decoration: new InputDecoration(labelText: "Add your content"),
                    onChanged: (String text) => _content = text
                  ),
                ],
              ),
            ),
            actions: <Widget>[
              new FlatButton(
                child: new Text("Cancel"),
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
              new FlatButton(
                child: new Text("Add"),
                onPressed: () {
                  if (_title != "" && _content != "") {
              ListToDo aList = new ListToDo(_title, _content, "10:am");
              setState(() {
                  todos.add(aList);
                      });
                  }
                  Navigator.pop(context);
                  
                },
              ),
            ],
          );
        });
  }

  List<ListToDo> todos = [
    new ListToDo("Do Cleaning", "Clean House Before ", "8am"),
    new ListToDo("Do Cleaning", "Clean House Before ", "8am"),
    new ListToDo("Do Cleaning", "Clean House Before ", "8am"),
    new ListToDo("Do Cleaning", "Clean House Before ", "8am"),
  ];

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return new Scaffold(
      appBar: new AppBar(
        title: new Text("ToDoList"),
      ),
      body: new ListView.builder(
          itemCount: todos != null ? todos.length : 0,
          itemBuilder: (context, index) =>
         new Dismissible(
  // Show a red background as the item is swiped away
  background: new Container(color: Colors.red),
  key: new Key(todos[index].title),
  onDismissed: (direction) {
    if (direction == DismissDirection.startToEnd) {
    todos.removeAt(index);
    Scaffold.of(context).showSnackBar(
         new SnackBar(content: new Text("dismissed")));
    }
  },
    child: new Card(
      child:   new Column(
                children: <Widget>[
                  new Divider(
                    height: 10.0,
                  ),
                  new ListTile(
                    leading: new Image.network("https://goo.gl/vFdXGc", width: 200.0,),
                    title: new Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        new Text(todos[index].title),
                        new Text(todos[index].time)
                      ],
                    ),
                    subtitle: new Text(todos[index].content,
                        style: TextStyle(fontSize: 16.0, color: Colors.red)),
                  )
                ],
              )),
  ),
    ),
      floatingActionButton: new FloatingActionButton(
        child: new Icon(Icons.add),
        onPressed: _addListView,
      ),
    );
  }
}
