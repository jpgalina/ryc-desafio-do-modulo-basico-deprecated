import 'package:challenge/models/resource_list.dart';
import 'package:challenge/models/task.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class TaskWidget extends StatefulWidget {
  final Task task;
  TaskWidget(this.task, {super.key});

  int get remainingDays {
    return task.dueDate.difference(DateTime.now()).inDays;
  }

  bool get isExpired {
    return remainingDays < 0 ? true : false;
  }
  @override
  State<TaskWidget> createState() => _TaskWidgetState();
}

class _TaskWidgetState extends State<TaskWidget> {
  @override
  Widget build(BuildContext context) {
    final resourceList = Provider.of<ResourceList>(context);

    Future renderLives() async {
      await Future.delayed(Duration.zero);
      resourceList.loseLife();
    }

    if (widget.isExpired && widget.task.renderedLife == false) {
      renderLives();
      widget.task.renderedLife = true;
    }
    return Card(
      shape: Border.all(
        width: 2,
        color: widget.isExpired
            ? Colors.red
            : widget.task.isCompleted
                ? Colors.green
                : Colors.black,
      ),
      child: ListTile(
        title: Text(widget.task.title),
        subtitle: Text('Remaining Days: ${widget.isExpired ? 0 : widget.remainingDays}'),
        trailing: IconButton(
          onPressed: () {
            if (!widget.isExpired && !widget.task.isCompleted) {
              setState(() {
                widget.task.isCompleted = true;
              });
              resourceList.addCoins();
            }
          },
          icon: Icon(
              widget.isExpired
                  ? Icons.cancel_outlined
                  : widget.task.isCompleted
                      ? Icons.task_alt
                      : Icons.circle_outlined,
              color: widget.isExpired
                  ? Colors.red
                  : widget.task.isCompleted
                      ? Colors.green
                      : Colors.black),
        ),
      ),
    );
  }
}
