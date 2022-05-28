import 'package:flutter/material.dart';
import 'package:med/ui/medicine_screen.dart';
import 'package:provider/provider.dart';

import 'db/app_db.dart';
import 'notifier/med_change_notifier.dart';

void main() {runApp(
  MultiProvider(
      providers: [
      Provider.value(value: AppDb()),
  ChangeNotifierProxyProvider<AppDb,MedChangeNotifier>
  (create: (context)=>MedChangeNotifier(),
  update: (context,db,notifier)=>notifier!..iniitDb(db)..medicinelistfuture
  )
  ],
  child:const MyApp()
  )
);
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(

        primarySwatch: Colors.blue,
      ),
      home: const HomeScreen(),

    );
  }
}