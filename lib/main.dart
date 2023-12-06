import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:simple_news_app/firebase_options.dart';
import 'package:simple_news_app/screen/login_screen.dart';
import 'package:simple_news_app/screen/navigation.dart';
import 'package:simple_news_app/screen/detail_screen.dart';
import 'package:simple_news_app/screen/notification_screen.dart';
import 'package:simple_news_app/screen/register_screen.dart';
import 'package:simple_news_app/screen/spash_screen.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Simple News App',
      debugShowCheckedModeBanner: false,
      initialRoute: '/',
      routes: {
        '/': (context) => const SplashScreen(),
        '/login': (context) => const LoginScreen(),
        '/register': (context) => const RegisterScreen(),
        '/home': (context) => const Navigation(),
        '/notification': (context) => const NotificationScreen(),
        '/detail': (context) => const DetailScreen(),
      },
      // home: const Dashboard(),
    );
  }
}
