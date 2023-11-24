import 'package:flutter/material.dart';
import 'package:flutter_tutorials/providers/cart_provider.dart';
import 'package:flutter_tutorials/providers/counter_provider.dart';
import 'package:flutter_tutorials/providers/page_provider.dart';
import 'package:flutter_tutorials/providers/product_provider.dart';
import 'package:flutter_tutorials/providers/user_provider.dart';
import 'package:flutter_tutorials/services/product_service.dart';
import 'package:flutter_tutorials/skeleton.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => UserProvider()),
        ChangeNotifierProvider(create: (context) => CounterProvider()),
        ChangeNotifierProvider(create: (context) => PageProvider()),
        ChangeNotifierProvider(create: (context) => ProductProvider()),
        ChangeNotifierProvider(create: (context) => CartProvider()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Tutorials',
        theme: ThemeData(
          fontFamily: 'Rubik',
          // textTheme: GoogleFonts.rubikTextTheme(Theme.of(context).textTheme),
          // primaryColor: Colors.teal,
          // colorSchemeSeed: Colors.teal,
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.teal),
          useMaterial3: true,
          brightness: Brightness.light,
        ),
        home: const Skeleton(),
      ),
    );
  }
}
