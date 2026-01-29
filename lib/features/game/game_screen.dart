import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:tres_en_raya/data/dataClass.dart';

class GameScreen extends StatefulWidget {
  const GameScreen({super.key});

  @override
  State<GameScreen> createState() => _GameScreenState();
}

class _GameScreenState extends State<GameScreen> {
  var turno;
  var miturno = 0;

  @override
  Widget build(BuildContext context) {
    var gameSize = 3;
    var documentos = ModalRoute.of(context)!.settings.arguments as String;

    return Scaffold(
      appBar: AppBar(title: Text(documentos), centerTitle: true),
      body: StreamBuilder<DocumentSnapshot>(
        stream: FirebaseFirestore.instance
            .collection("partidas")
            .doc(documentos)
            .snapshots(),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return const Center(child: Text("Error al cargar datos"));
          }

          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          final doc = snapshot.data!;
          final dataMap = doc.data() as Map<String, dynamic>;

          List<dynamic> tablero = dataMap['tablero'];
          if (tablero.length != gameSize * gameSize) {
            tablero = [];
            for (int i = 0; i < gameSize * gameSize; i++) {
              tablero.add("0");
            }
            dataMap['tablero'] = tablero;
          }

          Map<String, dynamic> jugador1 = dataMap['jugador1'];
          Map<String, dynamic> jugador2 = dataMap['jugador2'];

          if (jugador1['nickname'] == "" ||
              jugador1['nickname'] == Dataclass.name) {
            jugador1['nickname'] = Dataclass.name;
            miturno = 1;
            print("Soy j1");
          } else if (jugador2['nickname'] == "" ||
              jugador2['nickname'] == Dataclass.name) {
            jugador2['nickname'] = Dataclass.name;
            miturno = 2;
            print("Soy j2");
          } else {
            print("No soy ninguno");
          }
          updatefirebase(documentos, dataMap);

          return Column(
            children: [
              Text("Turno jugador ${dataMap['turno']}"),
              Expanded(
                child: GridView.builder(
                  itemCount: gameSize * gameSize,
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: gameSize,
                  ),
                  itemBuilder: (context, index) => Padding(
                    padding: const EdgeInsets.all(3.0),
                    child: GestureDetector(
                      onTap: () {
                        print(miturno);
                        print(dataMap['turno']);
                        if (miturno.toString() == dataMap['turno']) {
                          play(documentos, dataMap, index);
                        } else {
                          print("No es tu turno");
                        }
                      },
                      child: Container(
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          border: Border.all(color: Colors.black),
                          color: miturno.toString() == dataMap['turno']
                              ? Colors.red
                              : Colors.red.shade200,
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Text(
                          tablero[index] == "1"
                              ? "X"
                              : tablero[index] == "2"
                              ? "O"
                              : "",
                          style: TextStyle(fontSize: 100),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }

  void updatefirebase(documentos, dataMap) {
    FirebaseFirestore.instance
        .collection("partidas")
        .doc(documentos)
        .set(dataMap);
  }

  void play(documentos, dataMap, index) {
    List<dynamic> tablero = dataMap['tablero'];

    if (tablero[index] != "0") {
      return;
    }

    turno = dataMap['turno'];
    tablero[index] = turno.toString();

    if (turno == "1") {
      dataMap['turno'] = "2";
    } else {
      dataMap['turno'] = "1";
    }

    updatefirebase(documentos, dataMap);
  }
}
