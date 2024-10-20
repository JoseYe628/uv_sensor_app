
import 'package:bloc/bloc.dart';
import 'package:uv_sensor_app/features/iuv/domain/use_cases/remote_iuv_usecases.dart';
import 'package:uv_sensor_app/features/iuv/presentation/bloc/iuv_firebase_state.dart';

class IUVFirebaseCubit extends Cubit<IUVFirebaseState>{

  final RemoteIUVUsecase _remoteIUVUsecase;

  IUVFirebaseCubit(this._remoteIUVUsecase): super(IUVFirebaseInitialState()); 

  void initListen() async {
    var streamData = await _remoteIUVUsecase.listenData();
    streamData.fold(
      (fail){
        emit(IUVFirebaseErrorState(failure: fail));
      },
      (stream){
        stream.listen((records){
          emit(IUVFirebaseReadDataState(records: records));
        });
      }
    );
  }

}
