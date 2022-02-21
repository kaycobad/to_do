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
    return Container();
  }
}
