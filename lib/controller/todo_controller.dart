import 'package:get/get.dart';
import 'package:hive/hive.dart';
import 'package:todo/model/todo.dart';

class TodoController extends GetxController {
  var todoList = [].obs;
  late final Box _box;

  @override
  void onInit() async {
    _box = await Hive.openBox("default");
    await getTodos();
    super.onInit();
  }

  /// loads the todo list from database to memory
  Future<void> getTodos() async {
    todoList.clear();
    var todoMapList = _box.get('todo', defaultValue: []);
    for (var e in todoMapList) {
      todoList.add(Todo.fromMap(e));
    }
    update();
  }

  ///write the memory todo list to database
  Future<void> writeTodos() async {
    var todoMapList = [];
    for (var e in todoList) {
      todoMapList.add(e.toMap());
    }
    _box.put('todo', todoMapList);
  }

  void addNewTodo(Todo todo) async {
    todoList.add(todo);
    // clearing todo values saved in memory while creating todo
    update();
    writeTodos();
  }

  void deleteTodo(int index) async {
    todoList.removeAt(index);
    writeTodos();
    update();
  }

  Future<void> updateTodo(int index, Todo todo) async {
    todoList[index] = todo;
    writeTodos();
    update();
  }

  @override
  void dispose() {
    Hive.close();
    super.dispose();
  }
}
