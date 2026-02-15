abstract final class FirestorePaths {
  static const String users = 'users';

  static String user(String userId) => '$users/$userId';

  static String cars(String userId) => '${user(userId)}/cars';

  static String car(String userId, String carId) =>
      '${cars(userId)}/$carId';

  static String embeddings(String userId) =>
      '${user(userId)}/embeddings';

  static String embedding(String userId, String embeddingId) =>
      '${embeddings(userId)}/$embeddingId';
}
