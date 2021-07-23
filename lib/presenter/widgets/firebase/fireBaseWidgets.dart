import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

StreamBuilder<QuerySnapshot<Map<String, dynamic>>> buildStreamBuilderProductFireBase() {
  return StreamBuilder(
    stream: FirebaseFirestore.instance.collection('products').snapshots(),
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

          var dateTime = docData['name'];

          return ListTile(title: Text(dateTime.toString()));
        },
      );
    },
  );
}
