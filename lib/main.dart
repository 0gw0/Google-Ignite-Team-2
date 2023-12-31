import 'package:flutter/material.dart';
import 'package:healthy_fish_app/data/fish_data.dart';
import 'package:healthy_fish_app/models/fish.dart';
import 'package:healthy_fish_app/screens/splash_screen.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
import 'package:provider/provider.dart';
import 'seashell_provider.dart'; 

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

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => SeashellProvider(),
        ),
      ],
      child: const MainApp(),
    ),
  );
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