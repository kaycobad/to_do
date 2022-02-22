import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

import '../models/task_model.dart';
import '../providers/tasks_provider.dart';
import '../utils/colors.dart';
import 'add_task_widget.dart';

class TaskItem extends StatelessWidget {
  TaskItem({
    Key? key,
    required this.data,
    required this.index,
  }) : super(key: key);

  final TaskModel data;
  final int index;

  final _addTaskWidget = AddTaskWidget();

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: InkWell(
            onTap: () {
              var task = TaskModel(
                title: data.title,
                savedDate: data.savedDate,
                completed: !data.completed,
              );
              Provider.of<TasksProvider>(context, listen: false)
                  .updateTask(index, task);
            },
            child: Row(
              children: [
                Container(
                  height: 28,
                  width: 28,
                  margin: const EdgeInsets.symmetric(
                    horizontal: 15,
                  ),
                  decoration: BoxDecoration(
                    color: data.completed == true
                        ? Theme.of(context).primaryColor
                        : Colors.transparent,
                    shape: BoxShape.circle,
                    border: Border.all(
                      color: data.completed == true
                          ? Theme.of(context).primaryColor
                          : Colors.black,
                    ),
                  ),
                  child: data.completed == true
                      ? const Icon(
                          Icons.check,
                          size: 20,
                          color: Colors.white,
                        )
                      : const SizedBox(),
                ),
                Expanded(
                  child: Align(
                    alignment: Alignment.centerLeft,
                    child: Container(
                      padding: const EdgeInsets.all(20),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(50),
                        color: data.completed == true
                            ? const Color(0xFFF2F2F2)
                            : colorsLab[index % 10],
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            data.title,
                            style: TextStyle(
                              fontSize: 15,
                              fontWeight: FontWeight.w500,
                              color: data.completed == true
                                  ? Colors.black54
                                  : Colors.black,
                              decoration: data.completed == true
                                  ? TextDecoration.lineThrough
                                  : TextDecoration.none,
                            ),
                          ),
                          const SizedBox(
                            height: 5,
                          ),
                          Text(
                            DateFormat("MMMM dd, yyyy     hh:mm a").format(
                                DateTime.fromMillisecondsSinceEpoch(
                                    data.savedDate)),
                            style: const TextStyle(
                              fontSize: 10,
                              color: Colors.black45,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        PopupMenuButton(
          icon: const Icon(Icons.keyboard_arrow_down_rounded),
          onSelected: (val) {
            if (val == '0') {
              _addTaskWidget.bottomSheet(
                context: context,
                title: data.title,
                savedDate: data.savedDate,
                index: index,
                completed: data.completed,
              );
            } else {
              Provider.of<TasksProvider>(context, listen: false)
                  .removeTask(data.savedDate.toString());
            }
          },
          itemBuilder: (BuildContext context) => <PopupMenuEntry>[
            const PopupMenuItem(
              value: '0',
              child: Text('Edit'),
            ),
            const PopupMenuItem(
              value: '1',
              child: Text('Delete'),
            ),
          ],
        )
      ],
    );
  }
}
