import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../models/task_model.dart';
import '../providers/tasks_provider.dart';

class AddTaskWidget {
  bottomSheet({
    required BuildContext context,
    int? savedDate,
    int? index,
    bool? completed,
    required String title,
  }) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      builder: (context) {
        String newTitle = title;

        return SingleChildScrollView(
          child: Padding(
            padding: MediaQuery.of(context).viewInsets,
            child: Padding(
              padding: const EdgeInsets.only(
                left: 20,
                right: 20,
                top: 20,
                bottom: 10,
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      savedDate == null ? 'ADD TASK' : 'EDIT TASK',
                      style: const TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  TextFormField(
                    initialValue: title,
                    autofocus: true,
                    maxLines: 3,
                    onChanged: (value) {
                      newTitle = value;
                    },
                    decoration: const InputDecoration(
                      labelText: 'Task name',
                      border: OutlineInputBorder(
                        borderSide: BorderSide(),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Expanded(
                        child: ElevatedButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          child: const Text(
                            'Cancel',
                          ),
                        ),
                      ),
                      const SizedBox(
                        width: 20,
                      ),
                      Expanded(
                        child: ElevatedButton(
                          onPressed: () {
                            if (title != newTitle) {
                              var task = TaskModel(
                                title: newTitle,
                                savedDate: savedDate ??
                                    DateTime.now().millisecondsSinceEpoch,
                                completed: completed ?? false,
                              );
                              (savedDate == null
                                      ? Provider.of<TasksProvider>(context,
                                              listen: false)
                                          .addTask(task)
                                      : Provider.of<TasksProvider>(context,
                                              listen: false)
                                          .updateTask(index!, task))
                                  .whenComplete(() => Navigator.pop(context));
                            } else {
                              Navigator.pop(context);
                            }
                          },
                          child: const Text(
                            'Save',
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
