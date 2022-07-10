import 'package:file_picker/file_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:open_file/open_file.dart';
import 'package:todo/controller/reminder_controller.dart';
import 'package:todo/model/subtask.dart';
import 'package:todo/model/todo.dart';
import 'package:todo/utils/pallet.dart';
import 'package:todo/utils/widgets.dart/toast.dart';
import 'package:todo/view/reminder_page.dart';

class ViewEditTodo extends StatefulWidget {
  final Todo? todo;
  final Function update;
  final bool isUpdate;
  final Function? delete;
  const ViewEditTodo(
      {Key? key,
      required this.update,
      this.todo,
      required this.isUpdate,
      this.delete})
      : super(key: key);

  @override
  _ViewEditTodoState createState() => _ViewEditTodoState();
}

class _ViewEditTodoState extends State<ViewEditTodo> {
  late Todo todo;

  @override
  void initState() {
    todo = widget.todo ?? Todo(title: "");
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 0,
      child: Container(
        decoration: const BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(10.0),
                topRight: Radius.circular(10.0))),
        height: Get.height * 0.9,
        padding: const EdgeInsets.symmetric(horizontal: 10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(
              height: 25,
            ),
            PlatformTextFormField(
              hintText: "Title",
              initialValue: todo.title,
              onChanged: (value) {
                todo.title = value;
                widget.update(todo);
              },
              material: (_, __) => MaterialTextFormFieldData(
                decoration: InputDecoration(
                  filled: true,
                  fillColor: Pallet.secondary,
                  enabledBorder: InputBorder.none,
                  focusedBorder: InputBorder.none,
                ),
              ),
              cupertino: (_, __) => CupertinoTextFormFieldData(
                decoration: BoxDecoration(color: Pallet.secondary),
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Center(
              child: PlatformElevatedButton(
                child: Text(todo.date == null
                    ? "Select Date"
                    : DateFormat.yMMMMd('en_US').format(todo.date!)),
                onPressed: () async {
                  final date = await showPlatformDatePicker(
                      context: context,
                      initialDate: DateTime.now(),
                      firstDate: DateTime.utc(1990),
                      lastDate: DateTime.utc(2040));

                  if (date != null) {
                    setState(() {
                      todo.date = date;
                      widget.update(todo);
                    });
                  }
                },
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Expanded(
              child: SingleChildScrollView(
                child: Container(
                  color: Colors.white70,
                  width: Get.width,
                  // decoration:
                  //     BoxDecoration(border: Border.all(color: Colors.black)),
                  child: Column(
                    children: [
                      PlatformTextFormField(
                        textInputAction: TextInputAction.newline,
                        keyboardType: TextInputType.multiline,
                        initialValue: todo.description,
                        minLines: 5,
                        maxLines: null,
                        material: (_, __) => MaterialTextFormFieldData(
                          decoration: InputDecoration(
                            filled: true,
                            fillColor: Pallet.secondary,
                            enabledBorder: InputBorder.none,
                            focusedBorder: InputBorder.none,
                          ),
                        ),
                        cupertino: (_, __) => CupertinoTextFormFieldData(
                            decoration: BoxDecoration(color: Pallet.secondary)),
                        onChanged: (value) {
                          todo.description = value;
                          widget.update(todo);
                        },
                      ),
                      Column(
                        key: Key((todo.subTaskList?.length ?? 0).toString()),
                        children:
                            List.generate(todo.subTaskList?.length ?? 0, (i) {
                          return CheckboxListTile(
                              value: todo.subTaskList![i].check,
                              controlAffinity: ListTileControlAffinity.leading,
                              onChanged: (value) {
                                setState(() {
                                  todo.subTaskList![i].check =
                                      !todo.subTaskList![i].check;
                                });
                                widget.update(todo);
                              },
                              title: PlatformTextFormField(
                                textInputAction: TextInputAction.newline,
                                keyboardType: TextInputType.multiline,
                                minLines: 1,
                                initialValue: todo.subTaskList![i].subTaskName,
                                onChanged: (value) {
                                  todo.subTaskList![i].subTaskName = value;
                                  widget.update(todo);
                                },
                                maxLines: null,
                                material: (_, __) => MaterialTextFormFieldData(
                                  decoration: const InputDecoration(
                                    enabledBorder: InputBorder.none,
                                    // focusedBorder: InputBorder.none,
                                  ),
                                ),
                                cupertino: (_, __) =>
                                    CupertinoTextFormFieldData(
                                        //  decoration: const BoxDecoration(
                                        //   enabledBorder: InputBorder.none,
                                        // focusedBorder: InputBorder.none,
                                        ),
                              ),
                              secondary: PlatformIconButton(
                                cupertinoIcon: const Icon(CupertinoIcons.xmark),
                                materialIcon: const Icon(Icons.close),
                                onPressed: () {
                                  setState(() {
                                    todo.subTaskList!
                                        .remove(todo.subTaskList![i]);
                                  });
                                  widget.update(todo);
                                },
                              ));
                        }),
                      ),
                      Column(
                        children:
                            List.generate(todo.attachments?.length ?? 0, (i) {
                          return InkWell(
                            onTap: () {
                              OpenFile.open(todo.attachments![i]);
                            },
                            child: Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: ListTile(
                                title: Text(todo.attachments![i]),
                                trailing: PlatformIconButton(
                                  cupertinoIcon:
                                      const Icon(CupertinoIcons.xmark),
                                  materialIcon: const Icon(Icons.close),
                                  onPressed: () {
                                    setState(() {
                                      todo.attachments!
                                          .remove(todo.attachments![i]);
                                    });
                                    widget.update(todo);
                                  },
                                ),
                              ),
                            ),
                          );
                        }),
                      )
                    ],
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 50,
              child: Row(
                children: [
                  PlatformIconButton(
                    materialIcon: const Icon(Icons.check_box),
                    cupertinoIcon: const Icon(CupertinoIcons.check_mark),
                    onPressed: () {
                      setState(() {
                        todo.subTaskList ??= [];
                        todo.subTaskList!.add(SubTask(
                            subTaskName: "Enter subtask", check: false));
                      });
                      widget.update(todo);
                    },
                  ),
                  PlatformIconButton(
                    materialIcon: const Icon(Icons.attachment),
                    cupertinoIcon: const Icon(CupertinoIcons.link),
                    onPressed: () async {
                      try {
                        FilePickerResult? result = await FilePicker.platform
                            .pickFiles(allowMultiple: true);

                        if (result != null) {
                          List<String> path = [];
                          for (var e in result.paths) {
                            if (e != null) {
                              path.add(e);
                            }
                          }

                          setState(() {
                            todo.attachments = path;
                          });
                          widget.update(todo);
                        } else {
                          // User canceled the picker
                        }
                      } catch (e) {
                        print(e);
                      }
                    },
                  ),
                  PlatformIconButton(
                    materialIcon: const Icon(Icons.notification_add),
                    cupertinoIcon: const Icon(CupertinoIcons.bell),
                    onPressed: () {
                      if (todo.title.trim().isNotEmpty) {
                        Get.find<ReminderController>().selectedTodo = todo;
                        Get.to(() => ReminderPage());
                      } else {
                        toast("Enter some title");
                      }
                    },
                  ),
                  widget.isUpdate
                      ? PlatformIconButton(
                          materialIcon: const Icon(Icons.delete),
                          cupertinoIcon: const Icon(CupertinoIcons.delete),
                          onPressed: () {
                            if (widget.delete != null) {
                              todo = Todo(title: "");
                              widget.update(todo);
                              widget.delete!();
                            }
                            Navigator.pop(context);
                            //delete todo
                          },
                        )
                      : Container(),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
