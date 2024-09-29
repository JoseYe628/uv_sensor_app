
import 'package:flutter/material.dart';

class UVMessageBox extends StatelessWidget {
  const UVMessageBox({super.key});

  @override
  Widget build(BuildContext context){
    return Container(
      alignment: Alignment.centerLeft,
      margin: const EdgeInsets.symmetric(horizontal: 40),
      padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 20),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.green, width: 2),
        borderRadius: const BorderRadius.all(Radius.circular(10))
      ),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("Alto", style: TextStyle(color: Colors.green, fontWeight: FontWeight.bold, fontSize: 16),),
                Text("La radiación ultravioleta es muy alta en este momento, tome las precauciones necesarias"),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 1),
            child: Icon(Icons.warning, color: Colors.green, size: 30),
          ),
        ],
      ),
    );
  }
}
