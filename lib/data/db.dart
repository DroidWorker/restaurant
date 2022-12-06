import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:restaurant_v2/data/repository.dart';
import 'package:restaurant_v2/domain/model/dish.dart';
import 'package:restaurant_v2/domain/model/dishOption.dart';
import 'package:restaurant_v2/domain/model/feedback.dart';
import 'package:restaurant_v2/domain/model/myOrder.dart';
import 'package:restaurant_v2/domain/model/orderOption.dart';
import 'package:restaurant_v2/domain/model/table.dart';

import '../domain/model/orderItem.dart';

class DB{
  static void register(String surname, String name, String phone, String email, String password) async{
    DatabaseReference ref = FirebaseDatabase(databaseURL: "https://restaurant-2f63c-default-rtdb.europe-west1.firebasedatabase.app/").ref("accounts");
    final snapshot = await ref.get();
    if (snapshot.exists) {
      print(snapshot.value);
      int id = 1;
      for (var element in snapshot.children) {
        if(int.parse(element.key!)>id){
          id = int.parse(element.key!);
        }
      }
      id++;
      await ref.child(id.toString()).set({
          "surname":surname,
          "name": name,
          "phone": phone,
          "email": email,
          "password": password
      });
    } else {
      print('No data available.');
    }
  }

  static void getDishesByType(String type) async{
    DatabaseReference ref = FirebaseDatabase(databaseURL: "https://restaurant-2f63c-default-rtdb.europe-west1.firebasedatabase.app/").ref("dishes/"+type);
    final snapshot = await ref.get();
    var dishes = List<Dish>.empty(growable: true);
    if(snapshot.exists){
      for (var element in snapshot.children) {
        String name = "";
        String compound = "";
        String weight = "";
        String price = "";
        String cookTime = "";
        String options = "";

        element.children.forEach((element) {
          switch(element.key.toString()){
            case "name":
              name = element.value.toString();
              break;
            case "compound":
              compound = element.value.toString();
              break;
            case "weight":
              weight = element.value.toString();
              break;
            case "price":
              price = element.value.toString();
              break;
            case "cookTime":
              cookTime = element.value.toString();
              break;
            case "options":
              options = element.value.toString();
              break;
          }
        });
        var opt = options.split("|");
        List<DishOption> opts = List<DishOption>.empty(growable: true);
        opt.forEach((element) {
          String name = element.split("(")[0];
          String vals = element.split("(")[1];
          String startValue = vals.split("-")[0];
          String endValue = vals.split("-")[1];
          var o = DishOption(name: name, startValue: startValue, endValue: endValue);
          opts.add(o);
        });
        print(opts.toString());
        dishes.add(Dish(id: element.key.toString(), type: type, name: name, compound: compound, price: price, weight: weight, cookTime: cookTime, options: opts));
      }
      Repository.dishesController.add(dishes);
    } else{
      print('No data available.');
    }
  }

  static void getAllDishes() async{
    var dishes = List<Dish>.empty(growable: true);
    for(var type in {"eat","drink","other"}) {
      DatabaseReference ref = FirebaseDatabase(
          databaseURL: "https://restaurant-2f63c-default-rtdb.europe-west1.firebasedatabase.app/").ref("dishes/" + type);
      final snapshot = await ref.get();
      if (snapshot.exists) {
        for (var element in snapshot.children) {
          String name = "";
          String compound = "";
          String weight = "";
          String price = "";
          String cookTime = "";
          String options = "";

          element.children.forEach((element) {
            switch (element.key.toString()) {
              case "name":
                name = element.value.toString();
                break;
              case "compound":
                compound = element.value.toString();
                break;
              case "weight":
                weight = element.value.toString();
                break;
              case "price":
                price = element.value.toString();
                break;
              case "cookTime":
                cookTime = element.value.toString();
                break;
              case "options":
                options = element.value.toString();
                break;
            }
          });
          var opt = options.split("|");
          List<DishOption> opts = List<DishOption>.empty(growable: true);
          opt.forEach((element) {
            String name = element.split("(")[0];
            String vals = element.split("(")[1];
            String startValue = vals.split("-")[0];
            String endValue = vals.split("-")[1];
            var o = DishOption(
                name: name, startValue: startValue, endValue: endValue);
            opts.add(o);
          });
          print(opts.toString());
          dishes.add(Dish(id: element.key.toString(),
              type: type,
              name: name,
              compound: compound,
              price: price,
              weight: weight,
              cookTime: cookTime,
              options: opts));
        }
      } else {
        print('No data available.');
      }
    }
    Repository.dishesController.add(dishes);
  }

  static void getDishById(String Id) async{
    var dish;
    for(var type in {"eat","drink","other"}) {
      DatabaseReference ref = FirebaseDatabase(
          databaseURL: "https://restaurant-2f63c-default-rtdb.europe-west1.firebasedatabase.app/").ref("dishes/" + type);
      final snapshot = await ref.get();
      if (snapshot.exists) {
        for (var element in snapshot.children) {
          if (element.key.toString() == Id) {
            String name = "";
            String compound = "";
            String weight = "";
            String price = "";
            String cookTime = "";
            String options = "";

            element.children.forEach((element) {
              switch (element.key.toString()) {
                case "name":
                  name = element.value.toString();
                  break;
                case "compound":
                  compound = element.value.toString();
                  break;
                case "weight":
                  weight = element.value.toString();
                  break;
                case "price":
                  price = element.value.toString();
                  break;
                case "cookTime":
                  cookTime = element.value.toString();
                  break;
                case "options":
                  options = element.value.toString();
                  break;
              }
            });
            var opt = options.split("|");
            List<DishOption> opts = List<DishOption>.empty(growable: true);
            opt.forEach((element) {
              String name = element.split("(")[0];
              String vals = element.split("(")[1];
              String startValue = vals.split("-")[0];
              String endValue = vals.split("-")[1];
              var o = DishOption(
                  name: name, startValue: startValue, endValue: endValue);
              opts.add(o);
            });
            dish=Dish(id: element.key.toString(),
                type: type,
                name: name,
                compound: compound,
                price: price,
                weight: weight,
                cookTime: cookTime,
                options: opts);
            return;
          }
        }
      } else {
        print('No data available.');
      }
    }
    if(dish!=null) {
      Repository.dishItemController.add(dish);
    }
  }

  static void getFeedback() async{
    DatabaseReference ref = FirebaseDatabase(
        databaseURL: "https://restaurant-2f63c-default-rtdb.europe-west1.firebasedatabase.app/").ref("feedbacks/");
    final snapshot = await ref.get();
    var feedbacks = List<FeedbackItem>.empty(growable: true);
    if (snapshot.exists) {
      for (var element in snapshot.children) {
        String name ="";
        String text ="";
        for (var element in element.children) {
          if(element.key=="name"){
            name = element.value.toString();
          }
          else{
            text = element.value.toString();
          }
        }
        if(name.isNotEmpty&&text.isNotEmpty) {
          feedbacks.add(
              FeedbackItem(id: element.key.toString(), name: name, text: text));
        }
      }}else{
      print('No data available.');
    }
    Repository.feedbacksController.add(feedbacks);
  }

  static void addFeedback(String name, String text) async{
    DatabaseReference ref = FirebaseDatabase(
        databaseURL: "https://restaurant-2f63c-default-rtdb.europe-west1.firebasedatabase.app/").ref("feedbacks/");
    final snapshot = await ref.get();
    int id = 0;
    if (snapshot.exists) {
      for (var element in snapshot.children) {
        if(int.parse(element.key.toString())>id){
          id=int.parse(element.key.toString());
        }
      }
      id++;
      await ref.child(id.toString()).set({
        "name":name,
        "text": text
      });
    }else{
      print('No data available.');
    }
  }

  static void addOrder(String userId, String comment, String tableId, Map<String, DishOrderItem> dishes) async{
    DatabaseReference ref = FirebaseDatabase(
        databaseURL: "https://restaurant-2f63c-default-rtdb.europe-west1.firebasedatabase.app/").ref("orders/");
    final snapshot = await ref.get();
    if(snapshot.exists){
      await ref.child(userId).set({
        "comment":comment,
        "tableId": tableId,
        "dishes": dishes
      });
    }else{
      print('No data available.');
    }
  }

  static void getOrderByUserId(String userId) async{
    DatabaseReference ref = FirebaseDatabase(
        databaseURL: "https://restaurant-2f63c-default-rtdb.europe-west1.firebasedatabase.app/").ref("orders/"+userId);
    final snapshot = await ref.get();
    if(snapshot.exists){
      String comment = "";
      String tableId = "";
      Map<String, DishOrderItem> dishes = {};
      for (var element in snapshot.children) {
        switch(element.key){
          case "comment":
            comment = element.value.toString();
            break;
          case "tableId":
            tableId = element.value.toString();
            break;
          case "dishes":
            for (var element in element.children) {
              String dishType = "";
              List<OrderOption> opts = List<OrderOption>.empty(growable: true);
              for (var element in element.children) {
                switch(element.key){
                  case "dishType":
                    dishType = element.value.toString();
                    break;
                  case "options":
                    var optPair = element.value.toString().split("|");
                    for (var pair in optPair) {
                      opts.add(OrderOption(name: pair.split("-")[0], value: pair.split("-")[1]));
                    }
                    break;
                }
              }
              DishOrderItem doi = DishOrderItem(options: opts, dishType: dishType);
              dishes[element.value.toString()] = doi;
            }
            break;
        }
      }
      Repository.myOrderController.add(MyOrder(accountId: userId, comment: comment, tableId: tableId, dishes: dishes));
    }else{
      print('No data available.');
    }
  }

  static void getTop()async{
    DatabaseReference ref = FirebaseDatabase(
        databaseURL: "https://restaurant-2f63c-default-rtdb.europe-west1.firebasedatabase.app/").ref("top/");
    final snapshot = await ref.get();
    if(snapshot.exists){
      var dishList = List<Dish>.empty(growable: true);
      var topList = List<String>.empty(growable: true);
      for (var element in snapshot.children) {
        topList.add(element.value.toString());
      }
      for (var element in topList) {
        ref = FirebaseDatabase(
            databaseURL: "https://restaurant-2f63c-default-rtdb.europe-west1.firebasedatabase.app/").ref(element);
        final snapshot = await ref.get();
        if(snapshot.exists){
          String name = "";
          String compound = "";
          String weight = "";
          String price = "";
          String cookTime = "";
          String options = "";

          snapshot.children.forEach((element) {
            switch(element.key.toString()){
              case "name":
                name = element.value.toString();
                break;
              case "compound":
                compound = element.value.toString();
                break;
              case "weight":
                weight = element.value.toString();
                break;
              case "price":
                price = element.value.toString();
                break;
              case "cookTime":
                cookTime = element.value.toString();
                break;
              case "options":
                options = element.value.toString();
                break;
            }
          });
          dishList.add(Dish(id: snapshot.key.toString(), type: element.split("/")[0], name: name, compound: compound, price: price, weight: weight, cookTime: cookTime, options: List.empty()));
        }else{
          print('No data available.');
        }
      }
      Repository.topController.add(dishList);
    }else{
      print('No data available.');
    }
  }

  static void getFreeTable() async{
    DatabaseReference ref = FirebaseDatabase(
        databaseURL: "https://restaurant-2f63c-default-rtdb.europe-west1.firebasedatabase.app/").ref("tables/");
    final snapshot = await ref.get();
    var tableList = List<TableItem>.empty(growable: true);
    if(snapshot.exists){
      for (var element in snapshot.children) {
        String id = "";
        String placeCount = "";
        String Status = "";
        id = element.key.toString();
        element.children.forEach((element) {
          switch(element.key.toString()){
            case "placeCount":
              placeCount = element.value.toString();
              break;
            case "status":
              Status = element.value.toString();
          }
        });
        if(Status=="free"){
          tableList.add(TableItem(id: id, placeCount: placeCount));
        }
      }
      Repository.freeTablesController.add(tableList);
    }else{
      print('No data available.');
    }
  }
}