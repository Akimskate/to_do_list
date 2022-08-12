// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:todo_list_app/domain/data_provider/box_manager.dart';

import 'package:todo_list_app/domain/entity/group.dart';
import 'package:todo_list_app/domain/entity/task.dart';
// import 'package:todo_list_app/widgets/group_form/group_form_widget_model.dart';

class TaskFormWidgetModel {
  int groupKey;
  var taskText = '';
  TaskFormWidgetModel({
    required this.groupKey,
  });

  void saveTask(BuildContext context) async {
    if (taskText.isEmpty) return;
    final task = Task(text: taskText, isDone: false);
    final box = await BoxManager.instance.openTaskBox(groupKey);
    await box.add(task);
    // await BoxManager.instance.closeBox(box);
    Navigator.of(context).pop();

  }
}

class TaskFormWidgetMOdelProvider extends InheritedWidget {
  final TaskFormWidgetModel model;
  const TaskFormWidgetMOdelProvider(
      {Key? key, required this.child, required this.model})
      : super(key: key, child: child);

  final Widget child;

  static TaskFormWidgetMOdelProvider? watch(BuildContext context) {
    return context
        .dependOnInheritedWidgetOfExactType<TaskFormWidgetMOdelProvider>();
  }

  static TaskFormWidgetMOdelProvider? read(BuildContext context) {
    final widget = context
        .getElementForInheritedWidgetOfExactType<TaskFormWidgetMOdelProvider>()
        ?.widget;
    return widget is TaskFormWidgetMOdelProvider ? widget : null;
  }

  @override
  bool updateShouldNotify(TaskFormWidgetMOdelProvider oldWidget) {
    return false;
  }
}

