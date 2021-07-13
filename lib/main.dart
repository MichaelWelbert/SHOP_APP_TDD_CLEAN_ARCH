import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:shop_app/data/data_source/fire_base_data_source.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  FireBaseProductDataSource fireBaseProduct = FireBaseProductDataSource();

  // runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: StreamBuilder(
        stream: FirebaseFirestore.instance.collection('testing').snapshots(),
        builder: (
          BuildContext context,
          AsyncSnapshot<QuerySnapshot> snapshot,
        ) {
          if (!snapshot.hasData) return const SizedBox.shrink();
          final data = snapshot.requireData;
          return ListView.builder(
            itemCount: data.size,
            itemBuilder: (BuildContext context, int index) {
              Map<String, dynamic> docData = data.docs[index].data() as Map<String, dynamic>;
              var dateTime = (docData['timestamp'] as Timestamp).toDate();

              return ListTile(title: Text(dateTime.toString()));
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => FirebaseFirestore.instance.collection('testing').add({
          'timestamp': Timestamp.fromDate(
            DateTime.now(),
          )
        }),
        tooltip: 'Increment',
        child: Icon(Icons.add),
      ),
    );
  }
}
