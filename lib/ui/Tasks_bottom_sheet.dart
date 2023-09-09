import 'package:flutter/material.dart';
import 'package:to_do/Data_base/My_database.dart';
import 'package:to_do/Data_base/Tasks.dart';
import 'package:to_do/utils/date%20utils.dart';
import 'package:to_do/utils/dialog_utils.dart';

class TasksBottomSheet extends StatefulWidget {
  @override
  State<TasksBottomSheet> createState() => _TasksBottomSheetState();
}

class _TasksBottomSheetState extends State<TasksBottomSheet> {
  var formKey = GlobalKey<FormState>();
  var titleControler = TextEditingController();
  var descriptionControler = TextEditingController();
  @override
  Widget build(BuildContext context) {
    // TODO: implement build

    return Container(
      padding: EdgeInsets.all(10),
      child: Form(
        key: formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              'Add new Task',
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            TextFormField(
              controller: titleControler,
              validator: (input) {
                if (input == null || input.isEmpty) {
                  return "please enter a valid title";
                }
                return null;
              },
              decoration: InputDecoration(labelText: 'Title'),
            ),
            TextFormField(
              controller: descriptionControler,
              validator: (input) {
                if (input == null || input.isEmpty) {
                  return "please enter a valid description";
                }
                return null;
              },
              maxLines: 4,
              minLines: 4,
              decoration: InputDecoration(labelText: 'Describtion'),
            ),
            Text(
              'Select Time',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
            ),
            InkWell(
              onTap: () {
                ShowDatepark();
              },
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  MyDateUtils.FormateTaskDate(selectedDate),
                  style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 21,
                      color: Theme.of(context).primaryColor),
                ),
              ),
            ),
            ElevatedButton(
                onPressed: () {
                  insertTask();
                },
                child: Text('Submit'))
          ],
        ),
      ),
    );
  }

  void insertTask() async {
    if (formKey.currentState?.validate() == false) {
      return;
    } else {
      Task task = Task(
          title: titleControler.text,
          Description: descriptionControler.text,
          datetime: selectedDate);
      dialogUtils.ShowProgressDialog(context, 'Loading..');
      try {
        await MyDatabase.insertTask(task);
        dialogUtils.hideDialog(context);
        dialogUtils.showMessage(
          context,
          'Task Added Succesfully',
          posaction: 'Ok',
        );
      } catch (e) {
        dialogUtils.hideDialog(context);
        dialogUtils.showMessage(context, 'error inserting task',
            posaction: 'Try again',
            actionpos: () {
              insertTask();
            },
            negaction: 'Cancel',
            actionneg: () {
              Navigator.pop(context);
            });
      }
    }
  }

  var selectedDate = DateTime.now();

  void ShowDatepark() async {
    var userSelectedDate = await showDatePicker(
        context: context,
        initialDate: selectedDate,
        firstDate: DateTime.now(),
        lastDate: DateTime.now().add(Duration(days: 365)));
    if (userSelectedDate == null) {
      return;
    } else {
      selectedDate = userSelectedDate;
      setState(() {});
    }
  }
}
