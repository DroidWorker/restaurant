import 'dart:async';

import 'package:restaurant_v2/domain/model/feedback.dart';
import 'package:restaurant_v2/domain/model/myOrder.dart';
import 'package:restaurant_v2/domain/model/table.dart';

import '../domain/model/dish.dart';

class Repository{
  static StreamController dishesController = StreamController<List<Dish>>();
  static StreamController dishItemController = StreamController<Dish>();
  static StreamController feedbacksController = StreamController<List<FeedbackItem>>();
  static StreamController myOrderController = StreamController<MyOrder>();
  static StreamController topController = StreamController<List<Dish>>();
  static StreamController freeTablesController = StreamController<List<Table>>();


}