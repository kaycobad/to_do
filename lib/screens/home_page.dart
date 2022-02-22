import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:to_do/widgets/add_task_widget.dart';

import '../providers/tasks_provider.dart';
import '../widgets/task_item.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final _addTaskWidget = AddTaskWidget();
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    WidgetsBinding.instance!.addPostFrameCallback((timeStamp) {
      Provider.of<TasksProvider>(context, listen: false).getTasks();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            floating: true,
            pinned: true,
            snap: false,
            centerTitle: false,
            automaticallyImplyLeading: false,
            title: const Text('ToDo'),
            bottom: AppBar(
              elevation: 0,
              toolbarHeight: 60,
              automaticallyImplyLeading: false,
              title: Consumer<TasksProvider>(
                builder: (BuildContext context, value, Widget? child) {
                  return Align(
                    alignment: Alignment.centerRight,
                    child: Text(
                      '${value.tasks.length} TASKS',
                      style: const TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.normal,
                      ),
                    ),
                  );
                },
              ),
            ),
          ),
          Consumer<TasksProvider>(
            builder: (BuildContext context, value, Widget? child) {
              if (value.tasks.isEmpty) {
                return const SliverToBoxAdapter(
                  child: SizedBox(),
                );
              } else {
                return SliverPadding(
                  padding: const EdgeInsets.only(
                    top: 15,
                    bottom: 70,
                  ),
                  sliver: SliverList(
                    delegate: SliverChildBuilderDelegate(
                      (context, index) {
                        return Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: TaskItem(
                            data: value.tasks[index],
                            index: index,
                          ),
                        );
                      },
                      childCount: value.tasks.length,
                    ),
                  ),
                );
              }
            },
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () {
          _addTaskWidget.bottomSheet(
            context: context,
            title: '',
          );
        },
      ),
    );
  }
}
