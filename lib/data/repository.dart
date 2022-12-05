import 'dart:async';

import 'package:restaurant_v2/domain/model/feedback.dart';

import '../domain/model/dish.dart';

class Repository{
  static StreamController dishesController = StreamController<List<Dish>>();
  static StreamController dishItemController = StreamController<Dish>();
  static StreamController feedbacksController = StreamController<List<Feedback>>();

}