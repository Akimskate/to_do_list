import 'package:flutter/material.dart';
import 'package:todo_list_app/ui/widgets/group_form/group_form_widget_model.dart';

class GroupFormWidget extends StatefulWidget {
  const GroupFormWidget({Key? key}) : super(key: key);

  @override
  State<GroupFormWidget> createState() => _GroupFormWidgetState();
}

class _GroupFormWidgetState extends State<GroupFormWidget> {
  final _model = GroupFormWidgetModel();

  @override
  Widget build(BuildContext context) {
    return GroupFormWidgetModelProvider(
        model: _model, child: const _GroupFormWidgetBody());
  }
}

class _GroupFormWidgetBody extends StatelessWidget {
  const _GroupFormWidgetBody({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('New Group'),
        ),
        body: const Center(
          child:  Padding(
            padding: EdgeInsets.symmetric(horizontal: 18.0),
            child: _GroupNameWidget(),
          ),
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () =>
              GroupFormWidgetModelProvider.read(context)?.model.saveGroup(context),
          child: const Icon(Icons.done),
        ));
  }
}

class _GroupNameWidget extends StatelessWidget {
  const _GroupNameWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final model = GroupFormWidgetModelProvider.watch(context)?.model;
    return TextField(
      decoration: InputDecoration(
        border: const OutlineInputBorder(),
        hintText: 'Group Name',
        errorText: model?.errorText,
      ),
      onChanged: (value) => model?.groupName = value,
      onEditingComplete: () =>
          model?.saveGroup(context),
    );
  }
}
