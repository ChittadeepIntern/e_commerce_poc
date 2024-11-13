import 'package:e_commerce_poc/provider/categories_provider.dart';
import 'package:e_commerce_poc/provider/products_provider.dart';
import 'package:e_commerce_poc/screens/home_screen.dart';
import 'package:e_commerce_poc/screens/splash.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (_) => ProductsProvider()),
          ChangeNotifierProvider(create: (_) => CategoriesProvider())
        ],
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          initialRoute: '/',
          routes: {
            '/': (context) => SplashScreen(),
            '/home': (context) => HomeScreen(),
          },
        ));
  }
}
