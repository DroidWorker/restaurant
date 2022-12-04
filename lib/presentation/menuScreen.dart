import 'package:flutter/cupertino.dart';
import 'package:restaurant_v2/domain/data/dish.dart';
import 'package:restaurant_v2/domain/data/menuItem.dart';
import 'package:restaurant_v2/presentation/menuCategory.dart';
import 'package:restaurant_v2/presentation/topItem.dart';

class MenuScreenWidget extends StatefulWidget{
  const MenuScreenWidget({Key? key}) : super(key: key);

  @override
  _state createState() => _state();
}

class _state extends State<MenuScreenWidget>{
  int type = 0;
  int categoryId = 0;
  List dishes = [
    Dish(name: "Крем-суп из тыквы", compound: "Тыква,  репчатый лук,  чеснок,  сливочное масло,  сливки,  растительное масло,  бекон, соль . . .", price: "16 р", weight: "220 г", imgPath: "assets/images/image.png"),
    Dish(name: "Крем-суп из тыквы", compound: "Курица,  перловая крупа,  сухие грибы,  картофель, морковь, лук, масло растительное, соль", price: "10 р", weight: "320 г", imgPath: "assets/images/image.png")
  ];
  List menuCategories = [
    MenuItem(id: 0, name: "Горячее", imgPath: "assets/images/hot.png"),
    MenuItem(id: 1, name: "Супы", imgPath: "assets/images/hot.png"),
    MenuItem(id: 2, name: "Гарниры", imgPath: "assets/images/hot.png"),
    MenuItem(id: 3, name: "Десерты", imgPath: "assets/images/hot.png")
  ];

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
              const Menucategory(text: "Супы", imageAssetPath: "assets/images/hot.png", iconDown: false,),
              Expanded(
                child: ListView.builder(
                  itemCount: dishes.length,
                    itemBuilder: (BuildContext context, int index){
                    return topItemWidget(topName: dishes[index].name, compound: dishes[index].compound, price: dishes[index].price, weight: dishes[index].weight, imgPath: dishes[index].imgPath);
                })
              )
            ],
              )
          ) : const SizedBox.shrink()
        ],
      ),
    );
  }

}