sealed class AppException implements Exception {
  const AppException(this.message, [this.cause]);

  final String message;
  final Object? cause;

  @override
  String toString() => '$runtimeType: $message';
}

class AuthException extends AppException {
  const AuthException(super.message, [super.cause]);
}

class StorageException extends AppException {
  const StorageException(super.message, [super.cause]);
}

class FirestoreException extends AppException {
  const FirestoreException(super.message, [super.cause]);
}

class RecognitionException extends AppException {
  const RecognitionException(super.message, [super.cause]);
}

class ValidationException extends AppException {
  const ValidationException(super.message, [super.cause]);
}
