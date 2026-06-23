abstract final class StoragePaths {
  static String carImage(String userId, String carId, String imageId) =>
      'users/$userId/cars/$carId/$imageId.jpg';

  static String tempImage(String userId, String fileName) =>
      'users/$userId/temp/$fileName';
}
