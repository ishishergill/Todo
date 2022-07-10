import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';
import 'package:get/get.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:todo/controller/todo_controller.dart';
import 'package:todo/model/todo.dart';
import 'package:todo/utils/pallet.dart';
import 'package:todo/utils/style.dart';
import 'package:todo/view/view_edit_todo.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final todoController = Get.find<TodoController>();



  @override
  Widget build(BuildContext context) {
    return PlatformScaffold(
      backgroundColor: Pallet.background,
      appBar: PlatformAppBar(
        title: Text(
          "Todo",
          style: Style.appHeading,
        ),
        cupertino: (_, __) => CupertinoNavigationBarData(
          transitionBetweenRoutes: false,
        ),
        trailingActions: <Widget>[
          Padding(
            padding: const EdgeInsets.only(right: 20.0),
            child: PlatformIconButton(
              materialIcon: const Icon(Icons.add),
              cupertinoIcon: const Icon(
                CupertinoIcons.add,
                color: Pallet.black,
              ),
              onPressed: () async {
                Todo? todo;
                if (GetPlatform.isAndroid) {
                  await showMaterialModalBottomSheet(
                      backgroundColor: Pallet.background,
                      context: context,
                      builder: (context) {
                        return ViewEditTodo(
                            update: (t) {
                              todo = t;
                            },
                            isUpdate: false);
                      });
                } else {
                  await showCupertinoModalBottomSheet(
                      backgroundColor: Pallet.background,
                      context: context,
                      builder: (context) {
                        return ViewEditTodo(
                            update: (t) {
                              todo = t;
                            },
                            isUpdate: false);
                      });
                }
                if (todo != null) {
                  if (todo!.title != "") {
                    todoController.addNewTodo(todo!);
                  }
                }
              },
            ),
          ),
        ],
      ),
      material: (_, __) => MaterialScaffoldData(),
      body: Obx(() {
        return Scaffold(
          body: ListView.builder(
            itemCount: todoController.todoList.length,
            itemBuilder: (BuildContext context, int index) {
              return InkWell(
                onTap: () async {
                  Todo temp = todoController.todoList[index];
                  if (GetPlatform.isAndroid) {
                    await showMaterialModalBottomSheet(
                        backgroundColor: Pallet.background,
                        context: context,
                        builder: (context) {
                          return ViewEditTodo(
                            update: (t) {
                              temp = t;
                            },
                            todo: temp,
                            isUpdate: true,
                            delete: () => todoController.deleteTodo(index),
                          );
                        });
                  } else {
                    await showCupertinoModalBottomSheet(
                        backgroundColor: Pallet.background,
                        context: context,
                        builder: (context) {
                          return ViewEditTodo(
                            update: (t) {
                              temp = t;
                            },
                            todo: temp,
                            isUpdate: true,
                            delete: () => todoController.deleteTodo(index),
                          );
                        });
                  }
                  if (temp.title != "") {
                    todoController.updateTodo(index, temp);
                  }
                },
                child: Container(
                  color: Pallet.secondary,
                  margin: const EdgeInsets.all(16),
                  child: ListTile(
                    title: Text(
                      todoController.todoList[index].title,
                      softWrap: false,
                    ),
                    subtitle: Text(
                      todoController.todoList[index].description ?? "",
                      maxLines: 2,
                    ), //make it dotted
                  ),
                ),
              );
            },
          ),
        );
      }),
    );
  }

  
}
//TODO: on close , send data for saving
//TODO: delete item, add attachments


