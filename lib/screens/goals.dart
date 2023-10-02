import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:healthy_fish_app/utils/constants/colors.dart';
import '../utils/constants/colors.dart';
import 'trophycase.dart';
import 'dart:async';
import 'package:healthy_fish_app/models/daily_task.dart';

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

// State of the main screen
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

// Fetch Firestore document and handle response
class DailyTaskFetcher extends StatelessWidget {
  const DailyTaskFetcher({super.key});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<DailyTask>>(
      future: _fetchDailyTasks(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          // Display a loading indicator while fetching data
          return Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          // Handle any errors that occur during data fetching
          return Center(child: Text("Error: ${snapshot.error}"));
        } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
          // If there is no data or data is empty, display a message
          return Center(child: Text("No daily tasks available for today."));
        } else {
          // Display the list of daily tasks
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

// Widget that displays a list of daily tasks
class ToDoWidget extends StatefulWidget {
  final List<DailyTask> dailyTasks;

  const ToDoWidget({Key? key, required this.dailyTasks}) : super(key: key);

  @override
  _ToDoWidgetState createState() => _ToDoWidgetState();
}

// State of the ToDoWidget. Populate each list with task and set gesture detector
class _ToDoWidgetState extends State<ToDoWidget> {
  List<List<bool>> _selected = [];

  @override
  void initState() {
    super.initState();
    // Initialize _selected list for each daily task
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
                  // Handle the task tap event here
                  // Toggle the selection state
                  setState(() {
                    _selected[index][taskIndex] = !_selected[index][taskIndex];
                    _itemCount += 1;
                  });

                  if (_itemCount == 5) {
                    _itemCount = 0;
                    showAlertDialog(context);
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
  // Create a GlobalKey to uniquely identify the AlertDialog
  GlobalKey<State<StatefulWidget>> alertDialogKey = GlobalKey();

  // set up the button
  Widget okButton = TextButton(
    child: const Text("OK"),
    onPressed: () async {
      // Dismiss the dialog by popping it using the global key
      Navigator.of(alertDialogKey.currentContext!).pop();
    },
  );

  // set up the AlertDialog
  AlertDialog alert = AlertDialog(
    key: alertDialogKey, // Assign the GlobalKey to the AlertDialog
    title: const Text("Congratulations!"),
    content: const Text(
        "You have completed the minimum number of required tasks. Keep it up!"),
    actions: [
      okButton,
    ],
  );

  // show the dialog
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
