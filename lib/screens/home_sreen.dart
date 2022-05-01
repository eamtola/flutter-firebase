import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class HomeSreen extends StatelessWidget {
  HomeSreen({Key? key}) : super(key: key);
  final CollectionReference users =
      FirebaseFirestore.instance.collection('users');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Flutter Firebase'),
      ),
      body: FutureBuilder<DocumentSnapshot>(
        future: users.doc('document').get(),
        builder:
            (BuildContext context, AsyncSnapshot<DocumentSnapshot> snapshot) {
          if (snapshot.hasError) {
            return const Text('Somthing want wrong');
          }
          if (snapshot.hasData && !snapshot.data!.exists) {
            return const Text('Document does not exits');
          }
          if (snapshot.connectionState == ConnectionState.done) {
            Map<String, dynamic> data =
                snapshot.data!.data() as Map<String, dynamic>;
            return Text(
                "${data['firstName']}${data['lastName']}${data['email']}${data['address']}");
          }
          return const Text('loading');
        },
      ),
    );
  }
}
