import 'dart:convert';

class SubTask {
  String subTaskName;
  bool check;
  SubTask({
    required this.subTaskName,
    required this.check,
  });

  SubTask copyWith({
    String? subTaskName,
    bool? check,
  }) {
    return SubTask(
      subTaskName: subTaskName ?? this.subTaskName,
      check: check ?? this.check,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'subTaskName': subTaskName,
      'check': check,
    };
  }

  factory SubTask.fromMap(var map) {
    return SubTask(
      subTaskName: map['subTaskName'] ?? '',
      check: map['check'] ?? false,
    );
  }

  String toJson() => json.encode(toMap());

  factory SubTask.fromJson(String source) =>
      SubTask.fromMap(json.decode(source));

  @override
  String toString() => 'SubTask(subTaskName: $subTaskName, check: $check)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is SubTask &&
        other.subTaskName == subTaskName &&
        other.check == check;
  }

  @override
  int get hashCode => subTaskName.hashCode ^ check.hashCode;
}
