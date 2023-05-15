import 'package:challenge/models/task.dart';
import 'package:challenge/models/task_list.dart';
import 'package:challenge/widgets/cust_app_bar.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:flutter/material.dart';

class TaskForm extends StatefulWidget {
  String? title;
  TaskForm({super.key});

  @override
  State<TaskForm> createState() => _TaskFormState();
}

class _TaskFormState extends State<TaskForm> {
  final descFocus = FocusNode();
  final dateFocus = FocusNode();

  DateTime? _selectedDate;

  final _formKey = GlobalKey<FormState>();
  final _formData = Map<String, Object>();

  void _submitForm() {
    final isValid = _formKey.currentState?.validate() ?? false;

    if (!isValid) {
      return;
    }

    _formData['dueDate'] = _selectedDate as DateTime;
    _formKey.currentState?.save();

    Provider.of<TaskList>(context, listen: false).saveTask(_formData);
    Navigator.of(context).pop();
  }

  _showDatePicker() {
    showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2023),
      lastDate: DateTime(2025, 12, 31),
    ).then((value) {
      if (value != null) {
        setState(() {
          _selectedDate = value;
        });
      } else {
        return;
      }
    });
  }

  @override
  void dispose() {
    super.dispose();
    descFocus.dispose();
    dateFocus.dispose();
  }

  @override
  Widget build(BuildContext context) {
    widget.title = ModalRoute.of(context)?.settings.arguments as String;
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
      body: Form(
        key: _formKey,
        child: ListView(
          children: [
            TextFormField(
              initialValue: widget.title,
              decoration: InputDecoration(
                labelText: 'Title',
                labelStyle: TextStyle(
                  color: Theme.of(context).colorScheme.primary,
                ),
              ),
              textInputAction: TextInputAction.next,
              onFieldSubmitted: (value) {
                FocusScope.of(context).requestFocus(descFocus);
              },
              onSaved: (value) {
                _formData['title'] = value ?? '';
              },
              validator: (value) {
                final title = value ?? '';

                return title.trim().isEmpty
                    ? 'title can\'t be empty'
                    : title.length < 3
                        ? 'title must have at least 3 characters'
                        : null;
              },
            ),
            TextFormField(
              decoration: InputDecoration(
                labelText: 'Description',
                labelStyle: TextStyle(
                  color: Theme.of(context).colorScheme.primary,
                ),
              ),
              textInputAction: TextInputAction.next,
              onFieldSubmitted: (value) {
                FocusScope.of(context).requestFocus(dateFocus);
              },
              onSaved: (value) {
                _formData['description'] = value ?? '';
              },
            ),
            Container(
              height: 70,
              child: Row(
                children: [
                  Expanded(
                    child: Text(
                      _selectedDate == null
                          ? 'Nenhuma data selecionada!'
                          : DateFormat('dd/MM/y').format(_selectedDate!),
                    ),
                  ),
                  TextButton(
                    onPressed: _showDatePicker,
                    child: Text('Select Date'),
                  )
                ],
              ),
            ),
            Container(
              padding: EdgeInsets.all(5),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  ElevatedButton(
                    onPressed: _submitForm,
                    child: Text('Submit'),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
