
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';

class UvTraker extends StatefulWidget {
  const UvTraker({super.key});

  @override
  State<UvTraker> createState() => _UvTrakerState();
}

class _UvTrakerState extends State<UvTraker> {

  //DatabaseReference recordsDatabase = FirebaseDatabase.instance.ref('records');

  @override
  void initState() {
    super.initState();
    /*recordsDatabase.limitToLast(10).onValue.listen((DatabaseEvent event) {
      final data = event.snapshot.value;
      print(data);
    });*/
  }

  @override
  Widget build(BuildContext context){
    return Container(
      padding: EdgeInsets.symmetric(vertical: 30, horizontal: 10),
      margin: EdgeInsets.symmetric(vertical: 20, horizontal: 40),
      alignment: Alignment.center,
      /*decoration: BoxDecoration(
        color: Colors.green.withAlpha(50),
        border: Border.all(color: Colors.green, width: 2),
        borderRadius: BorderRadius.all(Radius.circular(12)),
      ),*/
      child: Column(
        children: [
          UVIndex(),
          Text("Índice IUV", style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),),
        ],
      )
    );
  }
}

class UVIndex extends StatelessWidget {
  const UVIndex({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      "7",
      style: TextStyle(
        height: 1,
        //backgroundColor: Colors.red,
        color: Colors.green,
        fontSize: 120,
        fontWeight: FontWeight.bold,
      ),
    );
  }
}
