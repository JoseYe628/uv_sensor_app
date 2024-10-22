
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:uv_sensor_app/features/iuv/presentation/bloc/iuv_bluetooth_cubit.dart';
import 'package:uv_sensor_app/features/iuv/presentation/bloc/iuv_bluetooth_state.dart';

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
                        await bluetoothCubit.initListen();
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
          margin: EdgeInsets.symmetric(horizontal: 40),
          child: Column(
            children: [
              SizedBox(height: 15),
              TextAdvice(),
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
          case IUVBluetoothDisconnectedState():
            return Text("Bluetooth no está conectado al device");
          case IUVBluetoothLoadingState():
            return Text("Intentando conectar al device...");
          case IUVBluetoothReadingState():
            return Text("Conectado exitosamente!. Valor recibido: ${bstate.iuv.value}", style: TextStyle(fontSize: 30),);
          case IUVBluetoothConnectionErrorState():
            var text = (bstate as IUVBluetoothConnectionErrorState).failure.toString();
            return Text("Error al intentar conectar al device: ${text}");
          case IUVBluetoothDisconnectionErrorState():
            var text = (bstate as IUVBluetoothDisconnectionErrorState).failure.toString();
            return Text("Error al intentar desconectar el device: ${text}");
          default:
            return Text("Hubo un error no conocido");
        }
      }
    );
  }
}
