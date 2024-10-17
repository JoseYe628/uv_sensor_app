
abstract class Failure {}

class BluetoothFailure extends Failure {}
class FirebaseFailure extends Failure {}

class BluetoothDeviceDisconnectedFailure extends Failure {}
class BluetoothNotFoundDeviceFailure extends Failure {}
class BluetoothNotFoundDCharacteristicsFailure extends Failure {}
class BluetoothScanDevicesFailure extends Failure {}
