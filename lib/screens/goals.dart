import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:healthy_fish_app/utils/constants/colors.dart';
import '../utils/constants/colors.dart';
import 'trophycase.dart';
import 'dart:async';
import 'package:healthy_fish_app/models/daily_task.dart';
import 'home_screen.dart'; // Import the HomeScreen

final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

final today = DateTime.now();
final formattedDate =
    "${today.day.toString().padLeft(2, '0')}-${today.month.toString().padLeft(2, '0')}-${today.year.toString()}";

// Widget, which is the main screen of the app
class ToDoList extends StatefulWidget {
  const ToDoList({Key? key}) : super(key: key);

  @override
  _ToDoListState createState() => _ToDoListState();
}

class _ToDoListState extends State<ToDoList> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      navigatorKey: navigatorKey,
      title: 'test',
      home: Scaffold(
        backgroundColor: Colors.black,
        drawer: const NavigationDrawer(),
        body: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            children: <Widget>[
              CurDateTime(),
              Expanded(child: DailyTaskFetcher())
            ],
          ),
        ),
      ),
    );
  }
}

class DailyTaskFetcher extends StatelessWidget {
  const DailyTaskFetcher({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<DailyTask>>(
      future: _fetchDailyTasks(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return Center(child: Text("Error: ${snapshot.error}"));
        } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
          return Center(child: Text("No daily tasks available for today."));
        } else {
          return ToDoWidget(dailyTasks: snapshot.data!);
        }
      },
    );
  }

  Future<List<DailyTask>> _fetchDailyTasks() async {
    final querySnapshot = await FirebaseFirestore.instance
        .collection('daily_task')
        .where('date', isEqualTo: formattedDate)
        .get();

    return querySnapshot.docs.map((doc) => DailyTask.fromSnapshot(doc)).toList();
  }
}

class ToDoWidget extends StatefulWidget {
  final List<DailyTask> dailyTasks;

  const ToDoWidget({Key? key, required this.dailyTasks}) : super(key: key);

  @override
  _ToDoWidgetState createState() => _ToDoWidgetState();
}

class _ToDoWidgetState extends State<ToDoWidget> {
  List<List<bool>> _selected = [];

  @override
  void initState() {
    super.initState();
    _selected = List.generate(widget.dailyTasks.length,
            (index) => List.generate(widget.dailyTasks[index].tasks.length, (i) => false));
  }

  int _itemCount = 0;

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: widget.dailyTasks.length,
      itemBuilder: (BuildContext context, int index) {
        final dailyTask = widget.dailyTasks[index];

        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Date: ${dailyTask.date}",
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
            ...dailyTask.tasks.asMap().entries.map((entry) {
              final int taskIndex = entry.key;
              final String task = entry.value;

              return GestureDetector(
                onTap: () {
                  setState(() {
                    _selected[index][taskIndex] = !_selected[index][taskIndex];
                    _itemCount += 1;
                  });

                  if (_itemCount == 5) {
                    _itemCount = 0;
                    showAlertDialog(context);
                    // Navigate to HomeScreen after completing 5 tasks
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(builder: (context) => HomeScreen()),
                    );
                  }
                },
                child: Card(
                  elevation: 0,
                  color: Colors.transparent,
                  child: ListTile(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30),
                    ),
                    subtitle: Text(task),
                    leading: const Icon(Icons.heat_pump_sharp),
                    textColor: const Color.fromARGB(255, 136, 127, 189),
                    tileColor: _selected[index][taskIndex]
                        ? darkBlue
                        : const Color.fromARGB(255, 38, 38, 110),
                    title: Text("Task ${taskIndex + 1}"),
                  ),
                ),
              );
            }).toList(),
          ],
        );
      },
    );
  }
}

class CurDateTime extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 30, bottom: 18),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            greetingMessage(),
            style: const TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
          ),
          Text(
            getCurrentDate(),
            style:
            const TextStyle(fontFamily: "Montserrat", fontSize: 24, color: Color.fromARGB(255, 0, 115, 130)),
          ),
        ],
      ),
    );
  }

  String greetingMessage() {
    var timeNow = DateTime.now().hour;
    if (timeNow <= 11.59) {
      return 'Good Morning';
    } else if (timeNow > 12 && timeNow <= 16) {
      return 'Good Afternoon';
    } else if (timeNow > 16 && timeNow < 20) {
      return 'Good Evening';
    } else {
      return 'Good Night';
    }
  }

  String getCurrentDate() {
    var date = DateTime.now().toString();
    var dateParse = DateTime.parse(date);
    var formattedDate =
        "${dateParse.day}-${dateParse.month}-${dateParse.year}";
    return formattedDate.toString();
  }
}

showAlertDialog(BuildContext context) async {
  GlobalKey<State<StatefulWidget>> alertDialogKey = GlobalKey();

  Widget okButton = TextButton(
    child: const Text("OK"),
    onPressed: () async {
      Navigator.of(alertDialogKey.currentContext!).pop();
    },
  );

  AlertDialog alert = AlertDialog(
    key: alertDialogKey,
    title: const Text("Congratulations!"),
    content: const Text(
        "You have completed the minimum number of required tasks. Keep it up!"),
    actions: [
      okButton,
    ],
  );

  showDialog(
    context: context,
    builder: (BuildContext context) {
      return alert;
    },
  );
}

Widget buildMenuItems(BuildContext context) => Container(
      padding: const EdgeInsets.all(24.0),
      child: Wrap(
        runSpacing: 16,
        children: [
          const ListTile(
            leading: Icon(Icons.sports_esports),
            title: Text("Game on!"),
            onTap: null,
          ),
          ListTile(
            leading: const Icon(Icons.checklist_rounded),
            title: const Text("Daily Tasks"),
            onTap: () {
              Navigator.of(context).push(
                  MaterialPageRoute(builder: (context) => const ToDoList()));
            },
          ),
          const Divider(
            color: Colors.black54,
          ),
          const ListTile(
            leading: Icon(Icons.military_tech_sharp),
            title: Text("Achievements"),
            onTap: null,
          ),
          const ListTile(
            leading: Icon(Icons.storefront_outlined),
            title: Text("Store"),
            onTap: null,
          ),
          const ListTile(
            leading: Icon(Icons.newspaper_outlined),
            title: Text("News"),
            onTap: null,
          ),
          const ListTile(
            leading: Icon(Icons.settings),
            title: Text("Settings"),
            onTap: null,
          )
        ],
      ),
    );

class NavigationDrawer extends StatelessWidget {
  const NavigationDrawer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: <Widget>[
          buildHeaders(context),
          buildMenuItems(context),
        ],
      ),
    );
  }
}
