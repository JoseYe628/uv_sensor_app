
import 'package:uv_sensor_app/features/iuv/domain/entities/iuv.dart';

class IUVModel extends IUV {
  IUVModel({required super.value, required super.time});

  factory IUVModel.fromInt(int value){
    return IUVModel(value: value, time: DateTime.now());
  }

  factory IUVModel.fromFactory(IUV iuv){
    return IUVModel(value: iuv.value, time: iuv.time);
  }

}
