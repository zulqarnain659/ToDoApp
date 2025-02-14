import 'package:flutter/material.dart';

class ToDo{
  String? id;
  String? toDoText;
  bool isDone;

  ToDo({
    required this.id,
    required this.toDoText,
    this.isDone= false,
});
static List<ToDo> toDoList(){
  return[
    // ToDo(id: "01", toDoText: "toDoText", isDone: true),

  ];

}

}