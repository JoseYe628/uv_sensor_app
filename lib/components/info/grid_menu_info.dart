
import 'package:flutter/material.dart';

class GridMenuInfo extends StatelessWidget {
  const GridMenuInfo({super.key});

  @override
  Widget build(BuildContext context){
    return Container(
      margin: const EdgeInsets.only(top: 8, bottom: 25, left: 40, right: 40),
      child: GridView.count(
        shrinkWrap: true,
        crossAxisCount: 2,
        mainAxisSpacing: 10,
        crossAxisSpacing: 10,
        physics: NeverScrollableScrollPhysics(),
        children: [
          _ButtonItem(icon: Icons.pan_tool, description: "Conoce el tipo de tu piel"),
          _ButtonItem(icon: Icons.history, description: "Revisa el historial"),
          _ButtonItem(icon: Icons.security, description: "Aprende sobre cómo protegerte"),
        ],
      ),
    );
  }
}

class _ButtonItem extends StatelessWidget {
  const _ButtonItem({super.key, required this.description, required this.icon});

  final IconData icon;
  final String description;

  @override
  Widget build(BuildContext context){
    return Container(
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        //border: Border.all(color: Colors.green, width: 2),
        borderRadius: BorderRadius.all(Radius.circular(20)),
        color: Colors.green.withAlpha(30),
      ),
      child: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Icon(icon, color: Colors.green,),
            SizedBox(height: 10,),
            Text(description, style: TextStyle(fontSize: 12), textAlign: TextAlign.center)
          ],
        ),
      ),
    );
  }
}
