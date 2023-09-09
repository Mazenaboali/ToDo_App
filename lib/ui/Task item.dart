import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:to_do/Data_base/My_database.dart';
import 'package:to_do/Data_base/Tasks.dart';
import 'package:to_do/utils/dialog_utils.dart';

class TaskItem extends StatefulWidget {
  Task task;
  TaskItem(this.task);
  @override
  State<TaskItem> createState() => _TaskItemState();
}

class _TaskItemState extends State<TaskItem> {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Container(
      margin: EdgeInsets.all(8),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(18),
        color: Colors.red,
      ),
      child: Slidable(
        startActionPane: ActionPane(
          extentRatio: .2,
          motion: DrawerMotion(),
          children: [
            SlidableAction(
              onPressed: (buildcontext) {
                DeleteTask();
              },
              backgroundColor: Colors.red,
              label: 'delete',
              icon: Icons.delete,
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(18),
                bottomLeft: Radius.circular(18),
              ),
            ),
          ],
        ),
        child: Container(
          padding: EdgeInsets.all(10),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(18),
            color: Colors.white,
          ),
          child: Row(
            children: [
              Container(
                color: Theme.of(context).primaryColor,
                width: 4,
                height: 60,
              ),
              SizedBox(
                width: 10,
              ),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Text(
                      widget.task.title,
                      style: TextStyle(
                          color: Theme.of(context).primaryColor,
                          fontSize: 22,
                          fontWeight: FontWeight.bold),
                    ),
                    SizedBox(
                      height: 8,
                    ),
                    Text(
                      widget.task.Description,
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 18,
                          fontWeight: FontWeight.bold),
                    )
                  ],
                ),
              ),
              Container(
                padding: EdgeInsets.all(10),
                margin: EdgeInsets.all(10),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(18),
                  color: Theme.of(context).primaryColor,
                ),
                child: Icon(
                  Icons.check,
                  size: 36,
                  color: Colors.white,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  void DeleteTask() {
    dialogUtils.showMessage(context, 'Are you want to delete task',
        posaction: 'yes', actionpos: () async {
      dialogUtils.ShowProgressDialog(context, 'loading');
      await MyDatabase.delectTask(widget.task);
      dialogUtils.hideDialog(context);
      dialogUtils.showMessage(
        context,
        'Task deleted succesfully ',
        posaction: 'Ok',
        negaction: 'Undo',
      );
    }, negaction: 'Cancel');
  }
}
