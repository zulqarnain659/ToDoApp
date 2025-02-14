import 'package:flutter/material.dart';
import '../widgets/to_do_list_items.dart';
import '../model/ToDo.dart';

void main() {
  runApp(MyHomePage(title: "TODO App"));
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => ToDoHomePage();
}

class ToDoHomePage extends State<MyHomePage> {
  final toDoList = ToDo.toDoList();
  final toDoController = TextEditingController();
  List<ToDo> searchedToDoList = [];

  @override
  void initState() {
    searchedToDoList = toDoList;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(primarySwatch: Colors.green),
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        backgroundColor: Colors.grey[350],
        appBar: AppBar(
          // title: Text("ToDo App",style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
          backgroundColor: Colors.green[900],
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                  child: ClipRRect(
                child: Text(
                  "ToDo App",
                  style: TextStyle(
                      fontWeight: FontWeight.bold, color: Colors.white),
                ),
              )),
              Container(
                  height: 40,
                  width: 40,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(50),
                    child: Image.asset("assets/images/user.png"),
                  ))
            ],
          ),
          iconTheme: IconThemeData(
            color: Colors.white,
          ),
        ),
        body: Stack(
          children: [
            Container(
              child: Column(
                children: [
                  todoSearchBar(),
                  Expanded(
                      child: ListView(
                    padding: EdgeInsets.all(15.0),
                    children: [
                      Container(
                        child: Text(
                          "All TODO's",
                          style: TextStyle(
                              fontWeight: FontWeight.bold, fontSize: 28),
                        ),
                      ),
                      for (ToDo todo in searchedToDoList)
                        ToDoItems(
                          todo: todo,
                          onToDoChanged: HandleToDoChange,
                          onDeleteItem: HandleToDelete,
                        ),
                    ],
                  ))
                ],
              ),
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: Row(
                children: [
                  Expanded(
                      child: Container(
                    height: 50,
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(10),
                    ),
                    margin: EdgeInsets.only(bottom: 20, left: 10, right: 10),
                    child: TextField(
                      controller: toDoController,
                      decoration: InputDecoration(
                        contentPadding: EdgeInsets.all(8),
                        prefixIconConstraints:
                            BoxConstraints(maxHeight: 20, maxWidth: 25),
                        hintStyle: TextStyle(),
                        border: InputBorder.none,
                        hintText: "Please enter your task",
                      ),
                    ),
                  )),
                  Container(
                      child: Container(
                    width: 50,
                    decoration: BoxDecoration(
                        color: Colors.green[900],
                        borderRadius: BorderRadius.circular(7),
                        boxShadow: const [
                          BoxShadow(
                            color: Colors.grey,
                            blurRadius: 10.0,
                          )
                        ]),
                    margin: EdgeInsets.only(bottom: 20, right: 10),
                    height: 50,
                    child: IconButton(
                      iconSize: 18,
                      onPressed: () {
                        addToDoItem(toDoController.text);
                      },
                      icon: Icon(Icons.add),
                      color: Colors.white,
                    ),
                  ))
                ],
              ),
            )
          ],
        ),
        drawer: buildDrawer(context),
      ),
    );
  }

  Widget buildDrawer(BuildContext context) {
    return Drawer(
      child: ListView(
        children: [
          DrawerHeader(
              decoration: BoxDecoration(
                color: Colors.green,
              ),
              child: UserAccountsDrawerHeader(
                decoration: BoxDecoration(backgroundBlendMode: null),
                accountName: Text("Muhammad Zulqarnain"),
                currentAccountPictureSize: Size(50, 50),
                currentAccountPicture: CircleAvatar(
                  backgroundColor: Colors.green[900],
                  child: Text(
                    "MZ",
                    style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 20),
                  ),
                ),
                accountEmail: null,
              )),
          ListTile(
            title: Text("Home"),
            leading: Icon(Icons.home),
            onTap: () {
              Navigator.pop(context);
            },
          )
        ],
      ),
    );
  }

  void runFilter(String keywords) {
    List<ToDo> results = [];
    if (keywords.isEmpty) {
      results = toDoList;
    } else {
      results = toDoList.where((item)=>item.toDoText!.toLowerCase().contains(keywords)).toList();
    }
    setState(() {
      searchedToDoList = results;
    });
  }

  void addToDoItem(String toDo) {
    setState(() {
      toDoList.add(ToDo(
          id: DateTime.now().microsecondsSinceEpoch.toString(),
          toDoText: toDo));
    });
    toDoController.clear();
  }

  void HandleToDoChange(ToDo todo) {
    setState(() {
      todo.isDone = !todo.isDone;
    });
  }

  void HandleToDelete(String id) {
    setState(() {
      toDoList.removeWhere((item) => item.id == id);
    });
  }

  Widget todoSearchBar() {
    return Container(
      margin: EdgeInsets.all(10),
      height: 50,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Padding(
        padding: const EdgeInsets.all(15.0),
        child: TextField(
          onChanged: (value)=> runFilter(value),
          decoration: InputDecoration(
            contentPadding: EdgeInsets.all(8),
            prefixIcon: Icon(
              Icons.search,
              color: Colors.green[900],
              size: 20,
            ),
            prefixIconConstraints: BoxConstraints(maxHeight: 20, maxWidth: 25),
            hintText: "Search",
            hintStyle: TextStyle(),
            border: InputBorder.none,
          ),
        ),
      ),
    );
  }
}
