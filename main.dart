import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'data/DatabaseHelper.dart';
import 'data/ProductsList.dart';
import 'screens/ProductCategoryList.dart';
import 'screens/Feedback.dart';

Future<void> main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  //DatabaseHelper.createNewDBWithUniqueIDs("Products", productsList);
  runApp(const MyApp());
}


class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(

        colorScheme: ColorScheme.fromSeed(seedColor: Colors.black),
        useMaterial3: true,
      ),
      home: const MyHomePage(title: ' INBAT '),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title  });

  final String title;


  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  int selectedIndex = 0;

  static List<Widget> widget_options = <Widget>[

    const ProductCategoryList(),
    const FeedbackPage(),

  ];


  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(

        backgroundColor: Colors.green,
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text(widget.title ),
      ),
      body: Center(

        child: widget_options.elementAt(selectedIndex),


      ),
      bottomNavigationBar: BottomNavigationBar(
        selectedItemColor: Colors.green,
        onTap: onTapPressed,
        currentIndex: selectedIndex,
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            label: "Home",
            icon: Icon(Icons.home),
          ),
          BottomNavigationBarItem(
            label: "Info",
            icon: Icon(Icons.info),
          ),

        ],
      ),
    );
  }

  void onTapPressed(int value) {
    setState(() {
      selectedIndex = value;
    });

  }


}
