import 'package:challenge/models/task.dart';
import 'package:challenge/models/task_list.dart';
import 'package:challenge/routes/app_routes.dart';
import 'package:challenge/widgets/cust_app_bar.dart';
import 'package:challenge/widgets/task_widget.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class DashboardPage extends StatelessWidget {
  const DashboardPage({super.key});

  @override
  Widget build(BuildContext context) {
    final tl = Provider.of<TaskList>(context);
    var title = TextEditingController();
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(kToolbarHeight * 2),
        child: Container(
          height: double.infinity,
          color: Theme.of(context).colorScheme.primary,
          child: Padding(
            padding: const EdgeInsets.only(top: 40, left: 40),
            child: CustAppBar(),
          ),
        ),
      ),
      body: Column(
        children: [
          Row(
            children: [
              Container(
                margin: EdgeInsets.all(25),
                width: 300,
                child: TextField(
                  controller: title,
                  decoration: InputDecoration(
                      border: OutlineInputBorder(),
                      focusColor: Theme.of(context).colorScheme.secondary,
                      hintText: 'Add a new task here'),
                ),
              ),
              CircleAvatar(
                backgroundColor: Theme.of(context).colorScheme.primary,
                child: IconButton(
                  onPressed: () {
                    Navigator.pushNamed(context, AppRoutes.form,
                        arguments: title.text);
                  },
                  icon: Icon(
                    Icons.add,
                    color: Theme.of(context).colorScheme.secondary,
                  ),
                ),
              )
            ],
          ),
          SizedBox(
            height: MediaQuery.of(context).size.height * 0.6,
            child: ListView.builder(
              itemCount: tl.tasks.length,
              itemBuilder: (context, index) {
                return TaskWidget(tl.tasks[index]);
              },
            ),
          ),
        ],
      ),
    );
  }
}
