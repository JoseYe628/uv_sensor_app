import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:uv_sensor_app/core/routes/app_routes.dart';
import 'package:uv_sensor_app/di.dart';
import 'package:uv_sensor_app/features/iuv/presentation/bloc/iuv_bluetooth_cubit.dart';
import 'package:uv_sensor_app/features/iuv/presentation/bloc/iuv_firebase_cubit.dart';
import 'firebase_options.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  await FirebaseMessaging.instance.subscribeToTopic("uv");
  //await FirebaseApi().initNotifications();
  await FirebaseAuth.instance.signInWithEmailAndPassword(
    email: "joseyanez2298@gmail.com",
    password: "1962pk19*/",
  );
  await dependenceInjection();
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context){
    return MultiBlocProvider(
      providers: [
        BlocProvider<IUVBluetoothCubit>(create: (BuildContext context) => GetIt.instance.get<IUVBluetoothCubit>()),
        BlocProvider<IUVFirebaseCubit>(create: (BuildContext context) => GetIt.instance.get<IUVFirebaseCubit>()..initCubit())
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
