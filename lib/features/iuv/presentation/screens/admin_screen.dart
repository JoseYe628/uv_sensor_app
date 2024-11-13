
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:uv_sensor_app/features/iuv/presentation/bloc/iuv_bluetooth_cubit.dart';
import 'package:uv_sensor_app/features/iuv/presentation/bloc/iuv_bluetooth_state.dart';
import 'package:uv_sensor_app/features/iuv/presentation/widgets/admin/admin_history.dart';
import 'package:uv_sensor_app/features/iuv/presentation/widgets/admin/admin_tracker.dart';

class AdminScreen extends StatelessWidget {
  const AdminScreen({super.key});

  @override
  Widget build(BuildContext context){

    var bluetoothCubit = context.read<IUVBluetoothCubit>();

    return BlocBuilder<IUVBluetoothCubit, IUVBluetoothState>(
      builder: (context, bluetoothState) => Scaffold(
        appBar: AppBar(
          title: Text("UV App", style: TextStyle(color: Colors.green, fontWeight: FontWeight.bold)),
          centerTitle: true,
          backgroundColor: Colors.white,
          scrolledUnderElevation: 0,
          actions: [
            Container(
              margin: EdgeInsets.symmetric(horizontal: 10),
              child: SizedBox(
                width: 45,
                height: 30,
                child: FittedBox(
                  fit: BoxFit.fill,
                  child: Switch(
                    activeColor: Colors.green,
                    value: bluetoothState.bluetoothIsOn,
                    onChanged: (val) async {
                      if(val){
                        await bluetoothCubit.bluetoothOn();
                      } else {
                        await bluetoothCubit.bluetoothOff();
                      }
                    },
                  ),
                ),
              ),
            ),
          ],
        ),
        body: Container(
          margin: EdgeInsets.symmetric(horizontal: 10),
          child: Column(
            children: [
              SizedBox(height: 5),
              Text("Vista principal"),
              TextAdvice(),
              AdminUVHistory(),
            ],
          ),
        )
      ),
    );
  }
}

class TextAdvice extends StatelessWidget {
  const TextAdvice({super.key});

  @override
  Widget build(BuildContext context){
    return BlocBuilder<IUVBluetoothCubit, IUVBluetoothState>(
      builder: (context, bstate) {
        switch(bstate){
          case IUVBluetoothLoadingState():
            return _AdviceBox(text: "Cargando...", color: Colors.purple,);
          case IUVBluetoothConnectionSuccessState():
            return _AdviceBox(text: "Conexión establecida", color: Colors.greenAccent,);
          case IUVBluetoothInternalErrorState():
            return _AdviceBox(text: "Hubo un error en el módulo de Bluetooth ${bstate.failure.toString()}", color: Colors.black,);
          case IUVBluetoothReadingState():
            return AdminTraker(iuv: bstate.iuv);
          case IUVBluetoothDisconnectedState():
            return _AdviceBox(text: "El dispositivo no está conectado", color: Colors.red);
          default:
            return Text("Hubo un error no conocido");
        }
      }
    );
  }
}

class _AdviceBox extends StatelessWidget {
  const _AdviceBox({super.key, required this.text, required this.color});

  final String text;
  final Color color;

  @override
  Widget build(BuildContext context){
    return Container(
      alignment: Alignment.center,
      padding: EdgeInsets.symmetric(vertical: 30),
      margin: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
      decoration: BoxDecoration(
        color: color.withAlpha(20),
        border: Border.all(color: color, width: 3),
        borderRadius: BorderRadius.all(Radius.circular(8))
      ),
      child: Text(text),
    );
  }
}
