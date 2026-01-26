import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class ListScreen extends StatefulWidget {
  const ListScreen({super.key});

  @override
  State<ListScreen> createState() => _ListScreenState();
}

class _ListScreenState extends State<ListScreen> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Nombre del jugador"), centerTitle: true),
      body: StreamBuilder(
        stream: FirebaseFirestore.instance.collection('partidas').snapshots(),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return const Center(child: Text("Error"));
          }

          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          final docs = snapshot.data!.docs;

          return ListView.separated(
            itemBuilder: (context, index) {
              return ListTile(
                title: Text(docs[index].id),
                onTap: () => Navigator.pushNamed(
                  context,
                  '/game',
                  arguments: docs[index].id,
                ),
              );
            },
            separatorBuilder: (context, index) {
              return Divider();
            },
            itemCount: docs.length,
          );
        },
      ),
    );
  }
}
