import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:uv_sensor_app/di.dart';
import 'package:uv_sensor_app/features/iuv/presentation/bloc/iuv_bluetooth_cubit.dart';
import 'package:uv_sensor_app/routes/app_routes.dart';
import 'package:uv_sensor_app/utils/firebase_api.dart';
import 'firebase_options.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  await FirebaseApi().initNotifications();
  await dependenceInjection();
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context){
    return MultiBlocProvider(
      providers: [
        BlocProvider<IUVBluetoothCubit>(create: (BuildContext context) => GetIt.instance.get<IUVBluetoothCubit>())
      ],
      child: const MyApp(),
    );
  }
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "hello",
      routes: AppRoutes.generateRoutes(),
      initialRoute: AppRoutes.initialRoute,
    );
  }
}
