
import 'package:flutter/material.dart';

class SkinPhototypeScreen extends StatelessWidget {
  const SkinPhototypeScreen({super.key});

  @override
  Widget build(BuildContext context){
    return Scaffold(
      appBar: AppBar(
        title: Text("Fototipo de piel", style: TextStyle(color: Colors.green, fontWeight: FontWeight.bold),),
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
                "El fototipo de piel clasifica cómo reacciona tu piel al sol, según su color y capacidad para broncearse o quemarse",
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.green, fontSize: 17, fontStyle: FontStyle.italic),
              ),
              _SkinGrid(),
            ],
          ),
        ),
      )
    );
  }
}

class _SkinGrid extends StatelessWidget {
  const _SkinGrid({super.key});

  @override
  Widget build(BuildContext context){
    return Container(
      margin: EdgeInsets.symmetric(vertical: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text("Conoce tu fototipo de piel", style: TextStyle(fontWeight: FontWeight.bold, color: Colors.green),),
          Divider(color: Colors.green, height: 8, thickness: 2,),
          _Grid(),
        ],
      ),
    );
  }
}


class _Grid extends StatelessWidget {
  const _Grid({super.key});

  @override
  Widget build(BuildContext context){
    /*return GridView.count(
      crossAxisCount: 2,
      shrinkWrap: true,
      mainAxisSpacing: 10,
      crossAxisSpacing: 10,
      physics: NeverScrollableScrollPhysics(),
      padding: EdgeInsets.symmetric(vertical: 10),
      children: [
        _GridItem(color: Color(0xfffadcc4), type: "i",),
        _GridItem(color: Color(0xfff1c5a2), type: "ii",),
        _GridItem(color: Color(0xfffdb28b), type: "iii",),
        _GridItem(color: Color(0xffe08c72), type: "iv",),
        _GridItem(color: Color(0xff9b615d), type: "v",),
        _GridItem(color: Color(0xff64413d), type: "vi",)
      ],
    );*/
    return Center(
      child: Wrap(
        children: [
          _GridItem(color: Color(0xfffadcc4), type: "i",),
          _GridItem(color: Color(0xfff1c5a2), type: "ii",),
          _GridItem(color: Color(0xfffdb28b), type: "iii",),
          _GridItem(color: Color(0xffe08c72), type: "iv",),
          _GridItem(color: Color(0xff9b615d), type: "v",),
          _GridItem(color: Color(0xff64413d), type: "vi",)
        ],
      ),
    );
  }
}


class _GridItem extends StatelessWidget {
  const _GridItem({super.key, required this.color, required this.type});

  final Color color;
  final String type;

  @override
  Widget build(BuildContext context){
    return GestureDetector(
      onTap: (){
        print(type);
        Navigator.pushNamed(context, "pinfo", arguments: type);
      },
      child: Container(
        width: 120,
        height: 150,
        margin: EdgeInsets.all(5),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(12)),
          border: Border.all(color: Colors.green, width: 1),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Expanded(child: Hero(tag: type ,child: Container(margin: EdgeInsets.all(10), decoration: BoxDecoration(color: color, borderRadius: BorderRadius.all(Radius.circular(8)))))),
            Padding(
              padding: const EdgeInsets.only(bottom: 5),
              child: Text("Tipo ${type.toUpperCase()}", style: TextStyle(fontWeight: FontWeight.bold),),
            ),
          ],
        ),
      ),
    );
  }
}
