
import 'package:flutter/material.dart';

class SkinMeasuresSreen extends StatelessWidget {
  const SkinMeasuresSreen({super.key});

  @override
  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(
        title: Text("Cómo protegerte", style: TextStyle(color: Colors.green, fontWeight: FontWeight.bold),),
        backgroundColor: Colors.white,
        scrolledUnderElevation: 0,
        foregroundColor: Colors.green,
      ),
      body: Container(
        padding: EdgeInsets.only(left: 40, right: 40, top: 20),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Frente a la radiación ultravioleta, es recomendable tomar las siguientes medidas preventivas",
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.green, fontSize: 17, fontStyle: FontStyle.italic),
              ),
              Divider(color: Colors.green, height: 30, thickness: 2,),
              _PreventiveListe(),
            ],
          ),
        ),
      )
    );
  }
}


class _PreventiveListe extends StatelessWidget {
  const _PreventiveListe({super.key});

  @override
  Widget build(BuildContext context){
    return ListView(
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      children: [
        _PreventiveItem(
          title: "Cuidar la Piel Bajo la Sombra",
          description: "Permanecer en la sombra reduce significativamente la exposición a los rayos UV, ayudando a prevenir quemaduras solares, envejecimiento prematuro y daños acumulativos en la piel.",
          imageName: "chair.png",
        ),
        _PreventiveItem(
          title: "La Ropa no Protege Completamente de los rayos UV",
          description: "Aunque la ropa ofrece cierta barrera contra la radiación ultravioleta, no bloquea totalmente los rayos UV",
          imageName: "clothes.png",
        ),
        _PreventiveItem(
          title: "Uso de filtros solares",
          description: "El uso regular de un protector solar con FPS 30 o superior disminuye significativamente la exposición a los rayos UV",
          imageName: "crema-solar.png",
        ),
        _PreventiveItem(
          title: "Protección de los grupos vulnerables",
          description: "La piel de los bebés y niños es más delgada y sensible, lo que aumenta el riesgo de quemaduras solares y daño celular.",
          imageName: "children.png",
        ),
        _PreventiveItem(
          title: "Cuida la Capa de Ozono",
          imageName: "rayos-de-sol.png",
        ),
        SizedBox(height: 10,)
      ],
    );
  }
}

class _PreventiveItem extends StatelessWidget {
  const _PreventiveItem({super.key, required this.title, this.description, required this.imageName});

  final String title;
  final String? description;
  final String imageName;

  @override
  Widget build(BuildContext context){
    return Container(
      margin: EdgeInsets.symmetric(vertical: 5),
      decoration: BoxDecoration(
        border: Border.all(
          color: Colors.green
        ),
        borderRadius: BorderRadius.all(Radius.circular(10)),
        color: Colors.green.withAlpha(20),
      ),
      child: Row(
        children: [
          Expanded(
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Image.asset("assets/$imageName"),
            ),
          ),
          Expanded(
            flex: 3,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(title, style: TextStyle(color: Colors.green, fontSize: 17, fontWeight: FontWeight.bold, height: 1.2),),
                  description != null ? SizedBox(height: 5,) : Container(),
                  description != null ? Text(description!, style: TextStyle(fontSize: 12, fontWeight: FontWeight.w300)) : Container(),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}


