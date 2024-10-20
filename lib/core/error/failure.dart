
abstract class Failure {}

// Failure Types
class BluetoothFailure extends Failure {}
class FirebaseFailure extends Failure {}

// Bluetooth Failure Types
class BluetoothNotFoundDeviceFailure extends Failure{}
class BluetoothInternalErrorFailure extends Failure{}

// Firebase Failure Types
class FirebaseSendFailure extends Failure{}
