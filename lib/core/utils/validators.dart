import '../constants/app_constants.dart';

abstract final class Validators {
  static String? carName(String? value) {
    if (value == null || value.trim().isEmpty) {
      return 'Name is required';
    }
    if (value.trim().length > 100) {
      return 'Name must be 100 characters or fewer';
    }
    return null;
  }

  static String? carYear(String? value) {
    if (value == null || value.trim().isEmpty) {
      return null; // Year is optional
    }
    final year = int.tryParse(value.trim());
    if (year == null) {
      return 'Enter a valid year';
    }
    if (year < AppConstants.minCarYear || year > AppConstants.maxCarYear) {
      return 'Year must be between ${AppConstants.minCarYear} and ${AppConstants.maxCarYear}';
    }
    return null;
  }

  static String? carSeries(String? value) {
    if (value != null && value.trim().length > 100) {
      return 'Series must be 100 characters or fewer';
    }
    return null;
  }
}
