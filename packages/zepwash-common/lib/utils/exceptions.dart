class AppException implements Exception {
  final String message;
  final String? code;

  AppException(this.message, [this.code]);

  @override
  String toString() => message;
}

class AuthException extends AppException {
  AuthException(String message, [String? code]) : super(message, code);
}

class FirestoreException extends AppException {
  FirestoreException(String message, [String? code]) : super(message, code);
}

class StorageException extends AppException {
  StorageException(String message, [String? code]) : super(message, code);
}

class LocationException extends AppException {
  LocationException(String message, [String? code]) : super(message, code);
}

class PaymentException extends AppException {
  PaymentException(String message, [String? code]) : super(message, code);
}

class ValidationException extends AppException {
  ValidationException(String message, [String? code]) : super(message, code);
}
