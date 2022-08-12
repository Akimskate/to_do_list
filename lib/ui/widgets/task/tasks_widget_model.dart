// ignore_for_file: public_member_api_docs, sort_constructors_first
// import 'package:flutter/foundation.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:todo_list_app/domain/data_provider/box_manager.dart';
import 'package:todo_list_app/domain/entity/task.dart';
import 'package:todo_list_app/ui/navigation/main_navigation.dart';
import 'package:todo_list_app/ui/widgets/task/tasks_widget.dart';

class TasksWidgetModel extends ChangeNotifier {
  TaskWidgetConfiguration configuration;
  late final Future<Box<Task>> _box;
  var _tasks = <Task>[];
  ValueListenable<Object>? _listenableBox;

  List<Task> get tasks => _tasks.toList();

  TasksWidgetModel({required this.configuration}) {
    _setup();
  }

  void showForm(BuildContext context) {
    Navigator.of(context).pushNamed(
      MainNavigationRouteNames.tasksForm,
      arguments: configuration.groupKey,
    );
  }

  Future<void> _readTaskssFromHive() async {
    _tasks = (await _box).values.toList();
    notifyListeners();
  }

  Future<void> deleteTask(int taskIndex) async {
    await (await _box).deleteAt(taskIndex);
  }

  Future<void> doneToggle(int taskIndex) async {
    final task = (await _box).getAt(taskIndex);
    task?.isDone = !task.isDone;
    await task?.save();
  }

  Future<void> _setup() async {
    _box = BoxManager.instance.openTaskBox(configuration.groupKey);
    await _readTaskssFromHive();
    _listenableBox = (await _box).listenable();
    _listenableBox?.addListener(_readTaskssFromHive);
  }

  @override
  void dispose() async {
    _listenableBox?.removeListener(_readTaskssFromHive);
    await BoxManager.instance.closeBox(await _box);
    super.dispose(); 
  }
}

class TasksWidgetModelProvider extends InheritedNotifier {
  final TasksWidgetModel model;
  const TasksWidgetModelProvider({
    Key? key,
    required Widget child,
    required this.model,
  }) : super(
          key: key,
          notifier: model,
          child: child,
        );

  static TasksWidgetModelProvider? watch(BuildContext context) {
    return context
        .dependOnInheritedWidgetOfExactType<TasksWidgetModelProvider>();
  }

  static TasksWidgetModelProvider? read(BuildContext context) {
    final widget = context
        .getElementForInheritedWidgetOfExactType<TasksWidgetModelProvider>()
        ?.widget;
    return widget is TasksWidgetModelProvider ? widget : null;
  }
}
