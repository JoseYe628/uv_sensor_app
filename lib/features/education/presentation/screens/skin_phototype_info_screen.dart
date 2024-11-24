
import 'package:flutter/material.dart';
import 'package:uv_sensor_app/features/education/data/models/phototypes.dart';

class SkinPhototypeInfoScreen extends StatelessWidget {
  const SkinPhototypeInfoScreen({super.key});

  @override
  Widget build(BuildContext context){
    final type = (ModalRoute.of(context)?.settings?.arguments ?? "i") as String;
    final data = skin_info[type]!;
    return Scaffold(
      appBar: AppBar(
        foregroundColor: Colors.green,
        scrolledUnderElevation: 0,
        title: Text("Tipo ${type.toUpperCase()}", style: TextStyle(fontWeight: FontWeight.bold),),
      ),
      body: Container(
        margin: EdgeInsets.symmetric(horizontal: 40),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Hero(
                tag: type,
                child: Align(
                  alignment: Alignment.center,
                  child: Container(
                    width: 150,
                    height: 150,
                    margin: EdgeInsets.symmetric(vertical: 12),
                    decoration: BoxDecoration(color: data.color, borderRadius: BorderRadius.all(Radius.circular(8)))
                  ),
                ),
              ),
              Align(alignment: Alignment.center, child: Text(data.name, style: TextStyle(color: Colors.green, fontWeight: FontWeight.bold, fontSize: 25),)),
              Divider(color: Colors.green, height: 8, thickness: 2,),
              SizedBox(height: 16,),
              Text("¿Cómo identificar este tipo de piel?", style: TextStyle(fontWeight: FontWeight.bold, color: Colors.green, fontSize: 20),),
              SizedBox(height: 5,),
              Text(data.description, style: TextStyle(color: Colors.green, fontSize: 16),),
              Divider(color: Colors.green, height: 60, thickness: 1,),
              Text("Quemadura y bronceado", style: TextStyle(fontWeight: FontWeight.bold, color: Colors.green, fontSize: 20),),
              SizedBox(height: 5,),
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text("Quemadura: ", style: TextStyle(color: Colors.green, fontSize: 18, fontWeight: FontWeight.bold),),
                  SizedBox(width: 5,),
                  Expanded(child: Text(data.sunburn, style: TextStyle(color: Colors.green, fontSize: 16),)),
                ],
              ),
              SizedBox(height: 10,),
              Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text("Bronceado: ", style: TextStyle(color: Colors.green, fontSize: 18, fontWeight: FontWeight.bold),),
                  SizedBox(width: 5,),
                  Expanded(child: Text(data.tan, style: TextStyle(color: Colors.green, fontSize: 16),)),
                ],
              ),
              Divider(color: Colors.green, height: 60, thickness: 1,),
              Text("Tiempo de exposición", style: TextStyle(fontWeight: FontWeight.bold, color: Colors.green, fontSize: 20),),
              SizedBox(height: 5,),
              ...data.meds.map(
                (key, val) => MapEntry(
                  key, 
                  Container(
                    margin: EdgeInsets.only(bottom: 8),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text("$key", style: TextStyle(color: Colors.green, fontSize: 17, fontWeight: FontWeight.bold),),
                        SizedBox(width: 5,),
                        Expanded(child: Text("$val", style: TextStyle(color: Colors.green, fontSize: 16),)),
                      ],
                    ),
                  ),
                )
              ).values.toList(),
              SizedBox(height: 30,)
            ],
          ),
        ),
      )
    );
  }
}
