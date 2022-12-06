import 'package:restaurant_v2/domain/model/orderItem.dart';

class MyOrder{
  final String accountId;
  final String comment;
  final String tableId;
  final Map<String, DishOrderItem> dishes;
  MyOrder({
    required this.accountId,
    required this.comment,
    required this.tableId,
    required this.dishes,
  });
}