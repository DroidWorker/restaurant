import 'package:restaurant_v2/domain/model/orderOption.dart';

class DishOrderItem{
  final List<OrderOption> options;
  final String dishType;
  DishOrderItem({
    required this.options,
    required this.dishType
  });
}