import 'package:calendar_timeline/calendar_timeline.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:to_do/Data_base/My_database.dart';
import 'package:to_do/Data_base/Tasks.dart';
import 'Task item.dart';
class TasksTabs extends StatefulWidget {
  @override
  State<TasksTabs> createState() => _TasksTabsState();
}

class _TasksTabsState extends State<TasksTabs> {
  var selectedDate=DateTime.now();

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Column(
      children: [
        CalendarTimeline(
          shrink: true,
          initialDate: selectedDate,
          firstDate: DateTime.now().subtract(Duration(days: 365)),
          lastDate: DateTime.now().add(Duration(days: 365)),
          onDateSelected: (date) {
            setState(() {
              selectedDate=date;
            });
          },
          leftMargin: 20,
          monthColor: Colors.black,
          dayColor: Colors.black,
          activeDayColor: Theme.of(context).primaryColor,
          activeBackgroundDayColor: Colors.white,
          dotsColor: Theme.of(context).primaryColor,
          selectableDayPredicate: (date) => true,
          locale: 'en_ISO',
        ),
        Expanded(
            child: StreamBuilder<QuerySnapshot<Task>>(
                stream: MyDatabase.getTasksRealTimeUpdates(selectedDate),
                builder: ((buildcontext, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                  if (snapshot.hasError) {
                    return Center(child: Text('Error loading Tasks'));
                  }
                  var tasks = snapshot.data?.docs.map((doc) => doc.data()).toList();
                  return ListView.builder(
                    itemBuilder: (_, index) {
                      return TaskItem(tasks![index]);
                    },
                    itemCount: tasks?.length ?? 0,
                  );
                })))
      ],
    );
  }
}
