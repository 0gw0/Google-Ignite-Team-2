import 'package:flutter/material.dart';
import 'package:healthy_fish_app/data/fish_data.dart';
import 'package:healthy_fish_app/models/fish.dart';
import 'package:healthy_fish_app/screens/splash_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

List<FishsModel> listFish = [];

void main() async {

  // Initialize Flutter
  WidgetsFlutterBinding.ensureInitialized();

 for (var element in fishData["fish"]) {
    listFish.add(FishsModel.fromJson(element));
  }

  // Initialize Firebase
   await Firebase.initializeApp(
     options: DefaultFirebaseOptions.currentPlatform,
   );

  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
            debugShowCheckedModeBanner: false,
            title: 'test',
      home: SplashScreen(),
    );
  }
}



// Can delete
// class MyApp extends StatefulWidget {
//   const MyApp({super.key});

//   @override
//   State<StatefulWidget> createState() {
//     return HomePageState();
//   }
// }

// class HomePageState extends State<MyApp> {
//   @override
//   Widget build(BuildContext context) {
//     return const MaterialApp(
//         debugShowCheckedModeBanner: false,
//         home: SafeArea(
//           child: SplashScreen(),
//         ));
//   }
// }

