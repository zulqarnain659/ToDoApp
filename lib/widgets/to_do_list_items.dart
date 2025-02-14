// TODO Implement this library.

import 'package:flutter/material.dart';

import '../model/ToDo.dart';

class ToDoItems extends StatelessWidget {
  final ToDo todo;
  final onToDoChanged;
  final onDeleteItem;

  const ToDoItems(
      {super.key, required this.todo, this.onToDoChanged, this.onDeleteItem});

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Container(
        margin: EdgeInsets.only(top: 5, bottom: 5),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15.0),
          color: Colors.green,
        ),
        child: ListTile(
          onTap: () {
            onToDoChanged(todo);
          },
          title: Text(
            todo.toDoText!,
            style: TextStyle(
                fontSize: 20,
                color: Colors.white,
                decoration: todo.isDone ? TextDecoration.lineThrough : null,
                decorationThickness: 2.5,
                decorationColor: Colors.white),
          ),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(20),
          ),
          leading: Icon(
            todo.isDone ? Icons.check_box : Icons.check_box_outline_blank,
            color: Colors.white,
          ),
          trailing: Container(
            width: 35,
            decoration: BoxDecoration(
                color: Colors.green[900],
                borderRadius: BorderRadius.circular(7)),
            margin: EdgeInsets.symmetric(vertical: 12),
            height: 35,
            child: IconButton(
              iconSize: 18,
              onPressed: () {
                onDeleteItem(todo.id);
              },
              icon: Icon(Icons.delete),
              color: Colors.white,
            ),
          ),
        ));
  }
}
