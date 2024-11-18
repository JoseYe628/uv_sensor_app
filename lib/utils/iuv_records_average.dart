
import 'package:uv_sensor_app/features/iuv/domain/entities/iuv.dart';

class IUVRecordsAverage {
  List<IUV> records;

  IUVRecordsAverage(this.records);
  IUVRecordsAverage.initialized()
    : records = [];

  void push(IUV iuv){
    if(records.isNotEmpty){
      records.removeAt(0);
    }
    records.add(iuv);
  }

  bool isNotificationRequired(int threshold){
    int count = 0;
    records.forEach((iuv) {
      if(iuv.value > threshold){
        count++;
      }
    });
    return count > 5;
  }

  void printRecords(){
    String text = "[";
    records.forEach((iuv){
      text += "${iuv.value}, ";
    });
    text += "]";
    print(text);
  }

}
