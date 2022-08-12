import 'package:flutter/material.dart';
import 'package:todo_list_app/ui/widgets/task_form/tasks_form_widget_model.dart';

class TaskFormWidget extends StatefulWidget {
  final int groupKey;
  const TaskFormWidget({Key? key, required this.groupKey}) : super(key: key);

  @override
  State<TaskFormWidget> createState() => _TaskFormWidgetState();
}

class _TaskFormWidgetState extends State<TaskFormWidget> {
  late final TaskFormWidgetModel _model;

  @override
  void initState() {
    super.initState();
    _model = TaskFormWidgetModel(groupKey: widget.groupKey);
  }

  @override
  Widget build(BuildContext context) {
    return TaskFormWidgetMOdelProvider(
      model: _model,
      child: const _TextFormWidgetBody(),
    );
  }
}

class _TextFormWidgetBody extends StatelessWidget {
  const _TextFormWidgetBody({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('New task'),
        ),
        body: Center(
          child: Container(
            child: const Padding(
              padding: EdgeInsets.symmetric(horizontal: 18.0),
              child: _TaskTextWidget(),
            ),
          ),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () => TaskFormWidgetMOdelProvider.read(context)
              ?.model
              .saveTask(context),
          child: const Icon(Icons.done),
        ));
  }
}

class _TaskTextWidget extends StatelessWidget {
  const _TaskTextWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final model = TaskFormWidgetMOdelProvider.read(context)?.model;
    return TextField(
      autofocus: true,
      minLines: null,
      maxLines: null,
      expands: true,
      decoration: const InputDecoration(
        border: InputBorder.none,
        hintText: 'Task text',
      ),
      onChanged: (value) => model?.taskText = value,
      onEditingComplete: () => model?.saveTask(context),
    );
  }
}
