import 'package:starter_application/generated/l10n.dart';

enum SortingType { Price, Rate, CreationTime, MostRequested, TopSelling }

String getTranslatedSortingType(context, SortingType type) {
  switch (type) {
    case SortingType.Price:
      return Translation.current.filter_product_price;

    case SortingType.Rate:
      return Translation.current.filter_product_rate;

    case SortingType.CreationTime:
      return Translation.current.filter_product_creationTime;

    case SortingType.MostRequested:
      return Translation.current.filter_product_most_requested;

    case SortingType.TopSelling:
      return Translation.current.filter_product_top_selling;
  }
}
