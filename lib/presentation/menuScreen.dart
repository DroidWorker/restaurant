import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:restaurant_v2/data/repository.dart';
import 'package:restaurant_v2/domain/model/dish.dart';
import 'package:restaurant_v2/domain/model/menuItem.dart';
import 'package:restaurant_v2/presentation/menuCategory.dart';
import 'package:restaurant_v2/presentation/topItem.dart';

class MenuScreenWidget extends StatefulWidget{
  int mode = 0;
  Function updateRoot;
  MenuScreenWidget({required Function this.updateRoot, required this.mode, Key? key}) : super(key: key);

  @override
  _state createState() => _state(updateRoot, mode);
}

class _state extends State<MenuScreenWidget>{
  Function update;
  _state(this.update, this.mode);
  int mode = 0;//0-full menu
              //1-eat
              //2-drink
              //3-other
  int type = 0;
  int categoryId = 0;

  StreamSubscription? subscription;

  List menuCategories = [ ];

  List<Dish> dishes = [
    Dish(id:"", type: "", name: "Крем-суп из тыквы", compound: "Тыква,  репчатый лук,  чеснок,  сливочное масло,  сливки,  растительное масло,  бекон, соль . . .", price: "16 р", weight: "220 г", cookTime: "", category: "1", options: List.empty(), imgPath: "assets/images/image.png"),
    Dish(id:"", type:"", name: "Крем-суп из тыквы", compound: "Курица,  перловая крупа,  сухие грибы,  картофель, морковь, лук, масло растительное, соль", price: "10 р", weight: "320 г", cookTime: "", category: "1", options: List.empty(), imgPath: "assets/images/image.png")
  ];
  List showDishes = [ ];

  @override void initState() {
      subscription = Repository.dishesController.stream.listen((item) =>
      {
        setState(() {
          dishes = item;
          subscription?.cancel();
        })
      }
      );

    setCategories(mode);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10),
      child: Column(
        children: [
          Image.asset("assets/images/menuImage.png"),
          type==0? Expanded(child: ListView.builder(
            itemCount: menuCategories.length,
            itemBuilder: (BuildContext context, int index) {
              return GestureDetector(
                  onTap: () {
                    setState(() {
                      type = 1;
                      categoryId = menuCategories[index].id;
                      showDishes.clear();
                      for (var element in dishes) {
                        if(element.category==categoryId.toString()){
                          showDishes.add(element);
                        }
                      }
                    });
                  },
                  child: Menucategory(
                    text: menuCategories[index].name,
                    imageAssetPath: menuCategories[index].imgPath,
                    iconDown: true,)
              );
            }
          )
          )
              : type == 1 ? Expanded(
              child: Column(
            children: [
                  GestureDetector(
                      onTap: (){
                        setState(() {
                          type = 0;
                          });
                        },
                      child: Menucategory(text: menuCategories.isNotEmpty ? menuCategories[getRealId(categoryId.toString())].name : "", imageAssetPath: "assets/images/hot.png", iconDown: false,)
                  ),
              Expanded(
                child: ListView.builder(
                  itemCount: showDishes.length,
                    itemBuilder: (BuildContext context, int index){
                    return GestureDetector(
                      onTap: (){update(5, int.parse(showDishes[index].id));},
                      child: topItemWidget(topName: showDishes[index].name, compound: showDishes[index].compound, price: showDishes[index].price, weight: showDishes[index].weight, imgPath: showDishes[index].imgPath),
                    );
                })
              )
            ],
              )
          ) : const SizedBox.shrink()
        ],
      ),
    );
  }

  @override
  void dispose(){
    subscription?.cancel;
    super.dispose();
  }

  void setCategories(int type){
    switch(type){
      case 0:
        menuCategories = [
          MenuItem(id: 0, name: "Горячее", imgPath: "assets/images/hot.png"),
          MenuItem(id: 1, name: "Супы", imgPath: "assets/images/hot.png"),
          MenuItem(id: 2, name: "Гарниры", imgPath: "assets/images/hot.png"),
          MenuItem(id: 3, name: "Десерты", imgPath: "assets/images/hot.png"),
          MenuItem(id: 4, name: "Кофе", imgPath: "assets/images/hot.png"),
          MenuItem(id: 5, name: "Коктейли", imgPath: "assets/images/hot.png"),
          MenuItem(id: 6, name: "Свежевыжатые соки", imgPath: "assets/images/hot.png"),
          MenuItem(id: 7, name: "Вода", imgPath: "assets/images/hot.png"),
          MenuItem(id: 8, name: "Соусы", imgPath: "assets/images/hot.png"),
          MenuItem(id: 9, name: "Специи", imgPath: "assets/images/hot.png")
        ];
        break;
      case 1:
        menuCategories = [
          MenuItem(id: 0, name: "Горячее", imgPath: "assets/images/hot.png"),
          MenuItem(id: 1, name: "Супы", imgPath: "assets/images/hot.png"),
          MenuItem(id: 2, name: "Гарниры", imgPath: "assets/images/hot.png"),
          MenuItem(id: 3, name: "Десерты", imgPath: "assets/images/hot.png")
        ];
        break;
      case 2:
        menuCategories = [
          MenuItem(id: 4, name: "Кофе", imgPath: "assets/images/hot.png"),
          MenuItem(id: 5, name: "Коктейли", imgPath: "assets/images/hot.png"),
          MenuItem(id: 6, name: "Свежевыжатые соки", imgPath: "assets/images/hot.png"),
          MenuItem(id: 7, name: "Вода", imgPath: "assets/images/hot.png")
        ];
        break;
      case 3:
        menuCategories = [
          MenuItem(id: 8, name: "Соусы", imgPath: "assets/images/hot.png"),
          MenuItem(id: 9, name: "Специи", imgPath: "assets/images/hot.png")
        ];
        break;
    }
  }

  int getRealId(String id){
    switch(mode){
      case 0:
        return int.parse(id);
      case 1:
        return int.parse(id);
      case 2:
        return (int.parse(id)-4);
      case 3:
        return (int.parse(id)-8);
    }
    return 0;
  }
}