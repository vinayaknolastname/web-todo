import 'package:flutter/material.dart';
import 'package:todo/models/taskModel.dart';
import 'package:todo/presentation/home/controller.dart';

class HomeMainView extends StatelessWidget {
  final TaskController taskController = TaskController();
  final TextEditingController _taskController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('To-Do List')),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: TextField(
              controller: _taskController,
              decoration: InputDecoration(
                labelText: 'New Task',
                suffixIcon: IconButton(
                  icon: Icon(Icons.add),
                  onPressed: () {
                    taskController.addTask(_taskController.text);
                    _taskController.clear();
                  },
                ),
              ),
            ),
          ),
          Expanded(
            child: ValueListenableBuilder<List<Task>>(
              valueListenable: taskController.tasks,
              builder: (context, tasks, _) {
                return ListView.builder(
                  itemCount: tasks.length,
                  itemBuilder: (context, index) {
                    final task = tasks[index];
                    return ListTile(
                      title: Text(task.title),
                      leading: Checkbox(
                        value: task.isCompleted,
                        onChanged: (_) {
                          taskController.toggleTaskCompletion(index);
                        },
                      ),
                      trailing: IconButton(
                        icon: Icon(Icons.delete),
                        onPressed: () {
                          taskController.deleteTask(index);
                        },
                      ),
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
