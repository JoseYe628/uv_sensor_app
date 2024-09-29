
import 'package:flutter/material.dart';

class UVHistory extends StatelessWidget {
  const UVHistory({super.key});

  @override
  Widget build(BuildContext context){
    return Container(
      alignment: Alignment.centerLeft,
      margin: const EdgeInsets.symmetric(horizontal: 40, vertical: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text("Historial de hoy", style: TextStyle(color: Colors.green, fontWeight: FontWeight.bold, fontSize: 18)),
          Divider(color: Colors.green, height: 2, thickness: 2,),
          _Records()
        ],
      ),
    );
  }
}

class _Records extends StatelessWidget {
  const _Records({super.key});

  @override
  Widget build(BuildContext context){
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: [
          _HistoryRecord(),
          _HistoryRecord(),
          _HistoryRecord(),
          _HistoryRecord(),
          _HistoryRecord(),
          _HistoryRecord(),
          _HistoryRecord(),
          _HistoryRecord(),
        ],
      ),
    );
  }
}

class _HistoryRecord extends StatelessWidget {
  const _HistoryRecord({super.key});

  @override
  Widget build(BuildContext context){
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 8, vertical: 10),
      margin: EdgeInsets.symmetric(horizontal: 4, vertical: 10),
      constraints: BoxConstraints(minWidth: 55),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.green),
        borderRadius: BorderRadius.all(Radius.circular(8)),
      ),
      child: Column(
        children: [
          Text("12", style: TextStyle(color: Colors.green, fontSize: 25, fontWeight: FontWeight.w500)),
          Text("12:00", style: TextStyle(color: Colors.green, fontSize: 13, fontWeight: FontWeight.w500)),
        ],
      ),
    );
  }
}
