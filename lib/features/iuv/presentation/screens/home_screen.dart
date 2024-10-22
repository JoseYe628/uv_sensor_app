
import 'package:flutter/material.dart';
import 'package:uv_sensor_app/features/iuv/presentation/widgets/grid_menu_info.dart';
import 'package:uv_sensor_app/features/iuv/presentation/widgets/uv_history.dart';
import 'package:uv_sensor_app/features/iuv/presentation/widgets/uv_message_box.dart';
import 'package:uv_sensor_app/features/iuv/presentation/widgets/uv_tracker.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({super.key});

  @override
  Widget build(BuildContext context){
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text("UV App", style: TextStyle(color: Colors.green, fontWeight: FontWeight.bold)),
        centerTitle: true,
        backgroundColor: Colors.white,
        scrolledUnderElevation: 0,
        /*leading: IconButton(
          icon: Icon(Icons.menu, color: Colors.green,),
          onPressed: (){},
        )*/
      ),
      body: _UVElements(),
    );
  }
}


class _UVElements extends StatefulWidget {
  const _UVElements({super.key});

  @override
  State<_UVElements> createState() => _UVElementsState();
}

class _UVElementsState extends State<_UVElements> {

  //DatabaseReference recordsDatabase = FirebaseDatabase.instance.ref('records');

  @override
  Widget build(BuildContext context){
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            UvTraker(),
            UVMessageBox(),
            UVHistory(),
            GridMenuInfo(),
          ],
        ),
      );
  }
}
