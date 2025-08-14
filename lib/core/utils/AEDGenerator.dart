import 'package:intl/intl.dart';
class AEDGenerator {
  String generate(double amount) {
    double truncatedAmount = (amount * 100).truncateToDouble() / 100; // Truncate to one decimal place
    final NumberFormat formatter = NumberFormat("#,##0.00"); // Format with commas and 2 decimal places
    return "${formatter.format(truncatedAmount)} AED";
  }
}