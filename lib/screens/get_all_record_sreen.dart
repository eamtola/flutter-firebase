import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class GetAllRecordSreen extends StatelessWidget {
  const GetAllRecordSreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('Read All Record'),
        ),
        body: FutureBuilder<QuerySnapshot>(
          future: FirebaseFirestore.instance.collection('users').get(),
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              final List<DocumentSnapshot> documents = snapshot.data!.docs;
              return ListView(
                children: documents
                    .map((doc) => Card(
                          child: ListTile(
                            title: Text(doc['email']),
                          ),
                        ))
                    .toList(),
              );
            } else if (snapshot.hasError) {
              return const Center(
                child: Text('errer'),
              );
            } else {
              return const Center(
                child: Text('loading'),
              );
            }
          },
        ));
  }
}
