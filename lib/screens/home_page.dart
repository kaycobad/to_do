import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/tasks_provider.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
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
              toolbarHeight: 70,
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
        ],
      ),
      // body: Consumer<TasksProvider>(builder: (BuildContext context, value, Widget? child) {
      //   if(value.tasks.isEmpty) {
      //     return const Center(
      //       child: Text('No Tasks'),
      //     );
      //   } else {
      //     return Text('');
      //   }
      // },),
    );
  }
}
