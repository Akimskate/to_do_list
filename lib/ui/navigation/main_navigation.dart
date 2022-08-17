import 'package:flutter/material.dart';
import 'package:todo_list_app/ui/widgets/group_form/group_form_widget.dart';
import 'package:todo_list_app/ui/widgets/groups/groups_widget.dart';
import 'package:todo_list_app/ui/widgets/task/tasks_widget.dart';
import 'package:todo_list_app/ui/widgets/task_form/tasks_form_widget.dart';

abstract class MainNavigationRouteNames {
  static const groups = 'groups';
  static const groupsForm = 'groups/form';
  static const tasks = 'groups/tasks';
  static const tasksForm = 'groups/tasks/form';
}

class MainNAvigation {
  final initialRoute = MainNavigationRouteNames.groups;
  final routes = <String, Widget Function(BuildContext)> {
    MainNavigationRouteNames.groups: (context) => const GroupsWidget(),
    MainNavigationRouteNames.groupsForm: (context) => const GroupFormWidget(),
  };

  Route<Object> onGenerateRoute(RouteSettings settings) {
    switch (settings.name) {
      case MainNavigationRouteNames.tasks:
        final configuration = settings.arguments as TaskWidgetConfiguration;
        return MaterialPageRoute(
          builder: (context) {
            return TasksWidget(configuration: configuration);
          },
        );
      case MainNavigationRouteNames.tasksForm:
        final groupKey = settings.arguments as int;
        return MaterialPageRoute(
          builder: (context) {
            return TaskFormWidget(groupKey: groupKey);
          },
        );
      default:
        const widget = Text('Route EROOR ! ! ! ');
        return MaterialPageRoute(builder: (context) => widget);
    }
  }
}
