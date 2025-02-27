
import 'package:bloc/bloc.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:uv_sensor_app/features/iuv/domain/entities/iuv.dart';
import 'package:uv_sensor_app/features/iuv/domain/use_cases/remote_iuv_usecases.dart';
import 'package:uv_sensor_app/features/iuv/presentation/bloc/iuv_firebase_state.dart';

class IUVFirebaseCubit extends Cubit<IUVFirebaseState>{

  final RemoteIUVUsecase _remoteIUVUsecase;

  IUVFirebaseCubit(this._remoteIUVUsecase): super(IUVFirebaseInitialState()); 


  void initCubit() async {
    User? currentUser = FirebaseAuth.instance.currentUser;
    if(currentUser == null){
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: "joseyanez2298@gmail.com",
        password: "1962pk19*/",
      );
    } else {
      print("El email del usuario es: ${currentUser.email}");
    }
    var result = await _remoteIUVUsecase.getStreamRemoteData();
    result.fold(
      (fail){
        emit(IUVFirebaseErrorState(failure: fail));
      },
      (stream){
        stream.listen((List<IUV> iuvs) => emit(IUVFirebaseReadDataState(records: iuvs)));
      }
    );
  }

}
