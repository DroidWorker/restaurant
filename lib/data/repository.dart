import 'dart:async';

import 'package:restaurant_v2/data/db.dart';
import 'package:restaurant_v2/domain/model/feedback.dart';
import 'package:restaurant_v2/domain/model/myOrder.dart';
import 'package:restaurant_v2/domain/model/table.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../domain/model/dish.dart';

class Repository{
  static StreamController dishesController = StreamController<List<Dish>>.broadcast();
  static StreamController dishItemController = StreamController<Dish>.broadcast();
  static StreamController feedbacksController = StreamController<List<FeedbackItem>>.broadcast();
  static StreamController myOrderController = StreamController<MyOrder>.broadcast();
  static StreamController topController = StreamController<List<Dish>>.broadcast();
  static StreamController freeTablesController = StreamController<List<TableItem>>.broadcast();

 static void register(String surname, String name, String phone, String email, String password){
   DB.register(surname, name, phone, email, password);
 }

 static void getTables(){
   DB.getFreeTable();
 }

 static void getTop(){
   DB.getTop();
 }

 static void getFeedback(){
   DB.getFeedback();
 }

 static void addFeedback(String text) async {
   SharedPreferences prefs = await SharedPreferences.getInstance();
   String name = prefs.getString("myName")?? "no_name";
   DB.addFeedback(name, text);
 }

 static void addOrder(String tableId,String time) async{
   SharedPreferences prefs = await SharedPreferences.getInstance();
   String id = prefs.getString("myId")?? "-1";
   String order = prefs.getString("order")?? "";
   var itemList = order.split("}");
   Map<String, Map<String, String>> dishes = {};
   for (var element in itemList) {
     if(element.length>1){
        String dishId = "";
        String comment = "";
        String optionString = "";
        dishId = element.split(",")[0];
        comment = (element.split(",")[1]).split("(")[0];
        optionString = (element.split("(")[1]).replaceAll(")", "");
        if(optionString.isNotEmpty&&comment.isNotEmpty) {

          dishes[dishId] = {
            "options": optionString,
            "comment": comment
          };
        }else{print("WriteDishOrderItemError");}
     }
   }
   if(dishes.isNotEmpty&&id.isNotEmpty&&tableId.isNotEmpty&&time.isNotEmpty) {
     DB.addOrder(id, tableId, time, dishes);
   }else{print("write error");}
 }

  static void addStringToSP(String spName, String value) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setString(spName, value);
  }

  static void addDishToOrderSP(String dishId,  String comment, String options) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String order = prefs.getString("order")?? "";
    String count = (order.split("}").length-2).toString();
    order+=dishId+"-"+count+","+comment+"("+options+")}";
    prefs.setString("order", order);
    print("added to sp: "+order);
  }

  static void removeDishFromOrderSP(String dishId) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String order = prefs.getString("order")?? "";
    var items = order.split("}");
    String resstr = "";
    for (var element in items) {
      if(element.split(",")[0]!=dishId&&element.isNotEmpty){
        resstr+=element+"}";
        break;
      }
    }
    prefs.setString("order",resstr);
    getOrdersFromSP();
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