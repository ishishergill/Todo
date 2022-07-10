import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:todo/model/subtask.dart';

class Todo {
  String title;
  String? description;
  DateTime? date;
  List<SubTask>? subTaskList;
  List<String>? attachments;
  Todo({
    required this.title,
    this.description,
    this.date,
    this.subTaskList,
    this.attachments,
  });

  Todo copyWith({
    String? title,
    String? description,
    DateTime? date,
    List<SubTask>? subTaskList,
    List<String>? attachments,
  }) {
    return Todo(
      title: title ?? this.title,
      description: description ?? this.description,
      date: date ?? this.date,
      subTaskList: subTaskList ?? this.subTaskList,
      attachments: attachments ?? this.attachments,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'title': title,
      'description': description,
      'date': date?.millisecondsSinceEpoch,
      'subTaskList': subTaskList?.map((x) => x.toMap()).toList(),
      'attachments': attachments,
    };
  }

  factory Todo.fromMap(var map) {
    return Todo(
      title: map['title'] ?? '',
      description: map['description'],
      date: map['date'] != null
          ? DateTime.fromMillisecondsSinceEpoch(map['date'])
          : null,
      subTaskList: map['subTaskList'] != null
          ? List<SubTask>.from(
              map['subTaskList']?.map((x) => SubTask.fromMap(x)))
          : null,
      attachments: map['attachments'] != null
          ? List<String>.from(map['attachments'])
          : null,
    );
  }

  String toJson() => json.encode(toMap());

  factory Todo.fromJson(String source) => Todo.fromMap(json.decode(source));

  @override
  String toString() {
    return 'Todo(title: $title, description: $description, date: $date, subTaskList: $subTaskList, attachments: $attachments)';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Todo &&
        other.title == title &&
        other.description == description &&
        other.date == date &&
        listEquals(other.subTaskList, subTaskList) &&
        listEquals(other.attachments, attachments);
  }

  @override
  int get hashCode {
    return title.hashCode ^
        description.hashCode ^
        date.hashCode ^
        subTaskList.hashCode ^
        attachments.hashCode;
  }
}
