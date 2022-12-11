import 'dart:async';

import 'package:restaurant_v2/data/db.dart';
import 'package:restaurant_v2/domain/model/feedback.dart';
import 'package:restaurant_v2/domain/model/myOrder.dart';
import 'package:restaurant_v2/domain/model/orderItem.dart';
import 'package:restaurant_v2/domain/model/table.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../domain/model/dish.dart';

class Repository{
  static StreamController dishesController = StreamController<List<Dish>>.broadcast();
  static StreamController dishItemController = StreamController<Dish>.broadcast();
  static StreamController feedbacksController = StreamController<List<FeedbackItem>>();
  static StreamController myOrderController = StreamController<MyOrder>();
  static StreamController topController = StreamController<List<Dish>>();
  static StreamController freeTablesController = StreamController<List<TableItem>>();

 static void register(String surname, String name, String phone, String email, String password){
   DB.register(surname, name, phone, email, password);
 }

 static void getTables(){
   DB.getFreeTable();
 }

 static void addOrder(String userId, String tableId, Map<String, DishOrderItem> dishes){
   DB.addOrder(userId, tableId, dishes);
 }

  static void addStringToSP(String spName, String value) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString(spName, value);
  }

  static void addDishToOrderSP(String dishId,  String comment, String options) async{
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String order = prefs.getString("order")?? "";
    order+=dishId+","+comment+"("+options+")}";
    prefs.setString("order", order);
    print("added to sp: "+order);
  }

  static void getOrdersFromSP() async{
   SharedPreferences prefs = await SharedPreferences.getInstance();
   String order = prefs.getString("order")?? "";
   var orderItems = order.split("}");
   var ids = List<String>.empty(growable: true);
   print(ids.length);
   for (var element in orderItems) {
     ids.add(element.split(",")[0]);
   }
   DB.getDishByIds(ids);
 }

  static void getDishById(int id){
   DB.getDishById(id.toString());
  }
}