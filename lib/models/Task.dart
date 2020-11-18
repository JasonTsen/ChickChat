import 'package:flutter/material.dart';

class Task {
  final String id, title, dueDate, docRequired, desc, status;
  final Color color;
  Task({
    this.id,
    this.title,
    this.dueDate,
    this.docRequired,
    this.desc,
    this.status,
    this.color,
  });
}

List<Task> tasks = [
  Task(
      id: 'T01',
      title: "Task 1",
      dueDate: "10-Dec-2020",
      docRequired: "IC Copy",
      desc: "Please finish before due date",
      status: "To Do",
      color: Color(0xffff80ac)),
  Task(
      id: 'T02',
      title: "Task 2",
      dueDate: "10-Dec-2020",
      docRequired: "IC Copy",
      desc: "Please finish before due date",
      status: "To Do",
      color: Color(0xffff80ac)),
  Task(
      id: 'T03',
      title: "Task 3",
      dueDate: "10-Dec-2020",
      docRequired: "IC Copy",
      desc: "Please finish before due date",
      status: "To Do",
      color: Color(0xffff80ac)),
  Task(
      id: 'T04',
      title: "Task 4",
      dueDate: "10-Dec-2020",
      docRequired: "IC Copy",
      desc: "Please finish before due date",
      status: "To Do",
      color: Color(0xffff80ac)),
  Task(
      id: 'T05',
      title: "Task 5",
      dueDate: "10-Dec-2020",
      docRequired: "IC Copy",
      desc: "Please finish before due date",
      status: "To Do",
      color: Color(0xffff80ac)),
  Task(
      id: 'T06',
      title: "Task 6",
      dueDate: "10-Dec-2020",
      docRequired: "IC Copy",
      desc: "Please finish before due date",
      status: "To Do",
      color: Color(0xff7ee1ff)),
  Task(
      id: 'T07',
      title: "Task 7",
      dueDate: "10-Dec-2020",
      docRequired: "IC Copy",
      desc: "Please finish before due date",
      status: "To Do",
      color: Color(0xff7ee1ff)),
  Task(
      id: 'T08',
      title: "Task 8",
      dueDate: "10-Dec-2020",
      docRequired: "IC Copy",
      desc: "Please finish before due date",
      status: "To Do",
      color: Color(0xff7ee1ff)),
  Task(
      id: 'T09',
      title: "Task 9",
      dueDate: "10-Dec-2020",
      docRequired: "IC Copy",
      desc: "Please finish before due date",
      status: "To Do",
      color: Color(0xffffd86f)),
  Task(
      id: 'T10',
      title: "Task 10",
      dueDate: "10-Dec-2020",
      docRequired: "IC Copy",
      desc: "Please finish before due date",
      status: "To Do",
      color: Color(0xff26cc2c)),
  Task(
      id: 'T11',
      title: "Task 11",
      dueDate: "10-Dec-2020",
      docRequired: "IC Copy",
      desc: "Please finish before due date",
      status: "To Do",
      color: Color(0xff26cc2c)),
  Task(
      id: 'T12',
      title: "Task 12",
      dueDate: "10-Dec-2020",
      docRequired: "IC Copy",
      desc: "Please finish before due date",
      status: "To Do",
      color: Color(0xff26cc2c)),
  Task(
      id: 'T13',
      title: "Task 13",
      dueDate: "10-Dec-2020",
      docRequired: "IC Copy",
      desc: "Please finish before due date",
      status: "To Do",
      color: Color(0xff26cc2c)),
  Task(
      id: 'T14',
      title: "Task 14",
      dueDate: "10-Dec-2020",
      docRequired: "IC Copy",
      desc: "Please finish before due date",
      status: "To Do",
      color: Color(0xff26cc2c)),
];

String dummyText =
    "Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since. When an unknown printer took a galley.";
