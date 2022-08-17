// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:todo_list_app/ui/widgets/groups/groups_widget_model.dart';
import 'package:todo_list_app/ui/widgets/theme/change_theme_button_widget.dart';

class GroupsWidget extends StatefulWidget {
  const GroupsWidget({Key? key}) : super(key: key);

  @override
  State<GroupsWidget> createState() => _GroupsWidgetState();
}

class _GroupsWidgetState extends State<GroupsWidget> {
  final _model = GroupsWidgetModel();

  @override
  Widget build(BuildContext context) {
    return GroupWidgetModelProvider(
      model: _model,
      child: _GroupWidgetBody(),
    );
  }

  @override
  void dispose() async {
    await _model.dispose();
    super.dispose();
  }
}

class _GroupWidgetBody extends StatelessWidget {
  const _GroupWidgetBody({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('Groups'),
        actions: const [
          ChangeThemeButtonWidget(),
        ],
      ),
      body: SafeArea(
        child: _GroupListWidget(),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () =>
            GroupWidgetModelProvider.read(context)?.model.showForm(context),
        child: Icon(Icons.add),
      ),
    );
  }
}

class _GroupListWidget extends StatelessWidget {
  const _GroupListWidget({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final groupsCount =
        GroupWidgetModelProvider.watch(context)?.model.groups.length ?? 0;
    return ListView.separated(
      itemCount: groupsCount,
      separatorBuilder: (BuildContext context, int index) {
        return const Divider(height: 3);
      },
      itemBuilder: (BuildContext context, int index) {
        return _GroupListRowWidget(indeInList: index);
      },
    );
  }
}

class _GroupListRowWidget extends StatelessWidget {
  final int indeInList;
  const _GroupListRowWidget({
    Key? key,
    required this.indeInList,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final model = GroupWidgetModelProvider.read(context)!.model;
    final group = model.groups[indeInList];
    return Slidable(
      key: const ValueKey(0),
      endActionPane: ActionPane(
        motion: const StretchMotion(),
        children: [
          SlidableAction(
            onPressed: ((context) => model.deleteGroup(indeInList)),
            backgroundColor: Color(0xFFFE4A49),
            foregroundColor: Colors.white,
            icon: Icons.delete,
            label: 'Delete',
          ),
        ],
      ),
      child: ListTile(
        title: Text(group.name),
        trailing: Icon(Icons.more_vert),
        onTap: () => model.showTasks(context, indeInList),
      ),
    );
  }
}
