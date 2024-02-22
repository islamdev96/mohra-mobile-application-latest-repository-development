import 'package:starter_application/generated/l10n.dart';

class PriceUtils {
  PriceUtils._();
  static double getFormattedPrice(double price) {
    return price;
  }

 static double calculateDiscountedCost(double totalCost, int discount) =>
       totalCost * (discount / 100);
}
