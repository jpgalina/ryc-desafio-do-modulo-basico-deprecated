import 'package:challenge/models/resource_list.dart';
import 'package:challenge/models/resources.dart';
import 'package:challenge/models/task_list.dart';
import 'package:challenge/pages/tabs_page.dart';
import 'package:challenge/pages/task_form.dart';
import 'package:challenge/routes/app_routes.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => TaskList()),
        ChangeNotifierProvider(create: (_) => ResourceList())
      ],
      child: MaterialApp(
        title: 'Challenge!',
        theme: ThemeData().copyWith(
          colorScheme: ThemeData().colorScheme.copyWith(
                primary: Color.fromARGB(255, 0, 48, 73),
                secondary: Color.fromARGB(255, 252, 191, 73),
              ),
          canvasColor: Color.fromRGBO(255, 254, 229, 1),
        ),
        routes: {
          AppRoutes.home: (context) => TabsPage(),
          AppRoutes.form:(context) => TaskForm()
        },
      ),
    );
  }
}
