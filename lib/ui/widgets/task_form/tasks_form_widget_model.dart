// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:todo_list_app/domain/data_provider/box_manager.dart';
import 'package:todo_list_app/domain/entity/task.dart';

class TaskFormWidgetModel extends ChangeNotifier {
  int groupKey;
  var _taskText = '';

  bool get isValid => _taskText.trim().isNotEmpty;

  set taskText(String value){
    final isTaskTextEmpty = _taskText.trim().isEmpty;
    _taskText = value;
    if (value.trim().isEmpty != isTaskTextEmpty) {
      notifyListeners();
    }
  } 

  TaskFormWidgetModel({required this.groupKey});

  void saveTask(BuildContext context) async {
    final taskText = _taskText.trim();
    if (taskText.isEmpty) return;
    final task = Task(text: taskText, isDone: false);
    final box = await BoxManager.instance.openTaskBox(groupKey);
    await box.add(task);
    await BoxManager.instance.closeBox(box);
    Navigator.of(context).pop();
  }
}

class TaskFormWidgetMOdelProvider extends InheritedNotifier {
  final TaskFormWidgetModel model;
  const TaskFormWidgetMOdelProvider(
      {Key? key, required this.child, required this.model})
      : super(key: key, notifier: model, child: child);

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
