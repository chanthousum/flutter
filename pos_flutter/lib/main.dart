import 'package:flutter/material.dart';

// void main()=>runApp(
//     new MaterialApp(
//       home:MyApp(),
//       debugShowCheckedModeBanner:false,
//     )
// );
void main() {
  return runApp(MaterialApp(
    home: MyApp(),
    debugShowCheckedModeBanner: false,
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("My App"),
        centerTitle: true,
        actions: [],
      ),
      body: Center(
        child: Text(
          "Home",
          style: TextStyle(color: Colors.red, fontSize: 12),
        ),
      ),
    );
  }
}
