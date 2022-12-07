import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:restaurant_v2/presentation/orderListItem.dart';

import '../domain/model/dish.dart';

class OrderListScreenWidget extends StatefulWidget{
  const OrderListScreenWidget({Key? key}) : super(key: key);

  @override
  _state createState() => _state();
}

class _state extends State<OrderListScreenWidget>{
  List dishes = [
    Dish(id: "", type: "", name: "Крем-суп из тыквы", compound: "Тыква,  репчатый лук,  чеснок,  сливочное масло,  сливки,  растительное масло,  бекон, соль . . .", price: "16 р", weight: "220 г", cookTime: "", category: "1", options: List.empty(), imgPath: "assets/images/image.png"),
    Dish(id: "", type: "", name: "Крем-суп из тыквы", compound: "Курица,  перловая крупа,  сухие грибы,  картофель, морковь, лук, масло растительное, соль", price: "10 р", weight: "320 г", cookTime: "", category: "1", options: List.empty(), imgPath: "assets/images/image.png")
  ];

  String getSumm(){
    int _summ = 0;
    for (var element in dishes) {_summ+=int.parse(element.price.replaceAll(RegExp(r'[^0-9]'),''));};
    return _summ.toString();
  }

  @override
  Widget build(BuildContext context) {
    String summ = getSumm();

    return Container(
      padding: const EdgeInsets.all(10),
      child: Column(
        children: [
          Image.asset("assets/images/orderImage.png"),
          Expanded(child: ListView.builder(
              itemCount: dishes.length,
              itemBuilder: (BuildContext context, int index) {
                return OrderListItemWidget(
                      topName: dishes[index].name,
                      compound: dishes[index].compound,
                      price: dishes[index].price,
                      weight: dishes[index].weight,
                      imgPath: dishes[index].imgPath);
              }
          ),),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(child: ElevatedButton(onPressed: (){}, child: const Text("ЗАКАЗАТЬ"), style: ElevatedButton.styleFrom(primary: const Color.fromARGB(255, 72, 216, 22)),)),
              const SizedBox(width: 50,),
              Text("ИТОГО: $summ р ", style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),),
            ],
          )
        ],
      ),
    );
  }

}