
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
      padding: EdgeInsets.symmetric(vertical: 25, horizontal: 10),
      margin: EdgeInsets.symmetric(vertical: 20, horizontal: 40),
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: Colors.white60,
        border: Border.all(color: Colors.red),
        borderRadius: BorderRadius.all(Radius.circular(10)),
      ),
      child: Column(
        children: [
          Text("Índice IUV actual", style: TextStyle(fontSize: 16),),
          SizedBox(height: 15),
          UVIndex(),
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
      "10",
      style: TextStyle(
        fontSize: 60
      ),
    );
  }
}
