
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:flutter/material.dart';
import 'package:firebase_database/firebase_database.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({super.key});

  final databaseReference = FirebaseDatabase.instance.ref('records');

  @override
  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(
        title: Text("Índice de radiación UV", style: TextStyle(color: Colors.white),),
        centerTitle: true,
        backgroundColor: Colors.purple,
      ),
      body: Column(
        children: [
          ElevatedButton(
            onPressed: () async {
              await databaseReference.remove();
            },
            child: Text("Eliminar todo"),
          ),
          Container(
            height: 300,
            child: GestureDetector(
              child: FirebaseAnimatedList(
                query: databaseReference,
                itemBuilder: (context, snapshot, animation, index){
                  return Card(
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                    margin: EdgeInsets.all(10),
                    child: ListTile(
                      contentPadding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                      leading: Text("${snapshot.key}"),
                      title: Text("${snapshot.value}"),
                    ),
                  );
                }
              ),
            ),
          ),
        ],
      ),
    );
  }
}
