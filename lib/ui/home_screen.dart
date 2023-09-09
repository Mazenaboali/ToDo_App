import 'package:flutter/material.dart';
import 'package:to_do/ui/settings_tab.dart';
import 'Tasks_bottom_sheet.dart';
import 'Tasks_tab.dart';

class HomeScreen extends StatefulWidget {
  static const String routeName = 'home';

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

int selectedindextab = 0;

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    // TODO: implement build

    return Scaffold(
        appBar: AppBar(title: Text('ToDo App')),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        floatingActionButton: FloatingActionButton(
          shape: StadiumBorder(side: BorderSide(color: Colors.white, width: 4)),
          onPressed: () {
            showaddbottomsheet();
          },
          child: Icon(Icons.add),
        ),
        bottomNavigationBar: BottomAppBar(
          shape: CircularNotchedRectangle(),
          notchMargin: 8,
          child: BottomNavigationBar(
            currentIndex: selectedindextab,
            onTap: (index) {
              selectedindextab = index;
              setState(() {});
            },
            items: [
              BottomNavigationBarItem(icon: Icon(Icons.list), label: ''),
              BottomNavigationBarItem(icon: Icon(Icons.settings), label: ''),
            ],
          ),
        ),
        body: tab[selectedindextab]);
  }

  var tab = [TasksTabs(), SettingsTab()];
  void showaddbottomsheet() {
    showModalBottomSheet(
        context: context,
        builder: (buildContext) {
          return TasksBottomSheet();
        });
  }
}
