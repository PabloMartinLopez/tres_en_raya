import 'package:flutter/material.dart';

class ListScreen extends StatefulWidget {
  const ListScreen({super.key});

  @override
  State<ListScreen> createState() => _ListScreenState();
}

class _ListScreenState extends State<ListScreen> {
  Set<Map<String, Object>> data = {
    {'id': 1, 'name': 'game1', 'status': 'Por empezar'},
    {'id': 2, 'name': 'game2', 'status': 'tu turno'},
    {'id': 3, 'name': 'game3', 'status': 'turno del rival'},
    {'id': 4, 'name': 'game4', 'status': 'ganado'},
    {'id': 5, 'name': 'game5', 'status': 'perdido'},
  };

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Nombre del jugador"), centerTitle: true),
      body: ListView.separated(
        itemBuilder: (context, index) => GestureDetector(
          onTap: () => Navigator.pushNamed(context, '/game'),
          child: ListTile(
            title: Text(data.elementAt(index)['name'].toString()),
            subtitle: Text(data.elementAt(index)['status'].toString()),
          ),
        ),
        separatorBuilder: (context, index) => Divider(color: Colors.black),
        itemCount: data.length,
      ),
    );
  }
}
