import 'package:flutter/material.dart';
import 'package:space_app/utils/constants/colors.dart';
import 'trophycase.dart';

final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

class ToDoList extends StatelessWidget {
  const ToDoList({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      navigatorKey: navigatorKey,
        title: 'test',
        home: Scaffold(
          backgroundColor: black,
          drawer: const NavigationDrawer(),
          body: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              children: <Widget>[
                CurDateTime(),
                const Expanded(child: ToDoWidget())
              ],
            ),
          ),
        ));
  }
}


class ToDoWidget extends StatefulWidget {
  const ToDoWidget({super.key});

  @override
  State<ToDoWidget> createState() => _MyWidgetState();
}

final List<int> _list = List.generate(15, (i) => i);
final List<bool> _selected = List.generate(15, (i) => false);
final List<String> _taskList = [
  "Take a 20-minute walk in nature to get some fresh air and sunshine. No phones allowed!",
  "Practice deep breathing exercises for 5 minutes to reduce stress and promote relaxation",
  "Try a new healthy recipe for dinner tonight, packed with nutritious ingredients",
  "Set aside 15 minutes for a mindfulness meditation session to clear your mind",
  "Drink a glass of water as soon as you wake up to stay hydrated throughout the day",
  "Write down three things you're grateful for to foster a positive mindset",
  "Get a good night's sleep by going to bed 30 minutes earlier than usual",
  "Do 10 minutes of stretching exercises to improve flexibility and reduce muscle tension",
  "Plan a social activity or call a friend to strengthen your social connections",
  "Unplug from screens for an hour before bedtime to improve sleep quality",
  "Start your day with a nutritious breakfast to fuel your body and mind",
  "Spend quality time with a loved one, either in person or through a video call",
  "Try a new form of physical activity, like dancing, yoga, or swimming",
  "Set a timer to remind yourself to stand up and stretch every hour if you have a sedentary job or lifestyle",
  "Practice a random act of kindness, such as helping a neighbour or complimenting a colleague"
];
final List<int> _numList = [3, 6, 7];
final List<int> _secondList = [0];

class _MyWidgetState extends State<ToDoWidget> {
  int _itemCount = 0;
  var myIcon = const Icon(Icons.health_and_safety);
  @override
  Widget build(BuildContext context) {
    return ListView.separated(
        separatorBuilder: (BuildContext context, int index) =>
            const Divider(height: 20),
        itemCount: _list.length,
        itemBuilder: (BuildContext context, int index) {
          return Card(
              elevation: 0,
              child: ListTile(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(30)),
                  subtitle: Text('${_taskList[index]}'),
                  leading: _numList.contains(index)
                      ? const Icon(Icons.heat_pump_sharp)
                      : _secondList.contains(index)
                          ? const Icon(Icons.bolt)
                          : myIcon,
                  textColor: const Color.fromARGB(255, 136, 127, 189),
                  tileColor:
                      _selected[index] ? Colors.green[900] : const Color.fromARGB(255, 38, 38, 110),
                  onTap: () {
                    setState(() => _selected[index] = !_selected[index]);
                    setState(() {
                      _itemCount += 1;
                    });
                    if (_itemCount == 5) {
                      _itemCount = 0;
                      showAlertDialog(context);
                    }
                  },
                  title: Text("Task ${index + 1}")));
        });
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
          Text(getCurrentDate(),
              style: const TextStyle(
                  fontSize: 18, color: Color.fromARGB(255, 0, 115, 130)))
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

    var formattedDate = "${dateParse.day}-${dateParse.month}-${dateParse.year}";
    return formattedDate.toString();
  }
}

showAlertDialog(BuildContext context) {
  // set up the button
  Widget okButton = TextButton(
    child: const Text("OK"),
    onPressed: () async {
      Navigator.pop(context);
      await Navigator.of(context).push(
          MaterialPageRoute(builder: (context) => const TrophyCase()));
    },

  );

  // set up the AlertDialog
  AlertDialog alert = AlertDialog(
    title: const Text("Congratulations!"),
    content: const Text("You have completed the minimum number of required tasks. Keep it up!"),
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
