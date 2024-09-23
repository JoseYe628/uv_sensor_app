
import 'package:firebase_database/firebase_database.dart';

class RealtimeDatabase {
  // Obtener la colección de los records
  static final DatabaseReference records = FirebaseDatabase.instance.ref('records');

}
