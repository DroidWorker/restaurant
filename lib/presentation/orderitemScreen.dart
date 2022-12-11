import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../data/repository.dart';
import '../domain/model/dish.dart';

class OrderItemScreenWidget extends StatefulWidget {
  int dishId = 0;

  OrderItemScreenWidget({required this.dishId, Key? key}) : super(key: key);

  @override
  _state createState() => _state();

  void getDishInfo(int id){
    Repository.getDishById(id);
  }
}
class _state extends State<OrderItemScreenWidget>{
  int dishId = 0;
  Dish dish = Dish(id: "0", type: "type", name: "name", compound: "compound", price: "price", weight: "weight", cookTime: "cookTime", category: "category", options: List.empty(), imgPath: "imgPath");
  int optValue1 = 0;
  int optValue2 = 0;
  int optValue3 = 0;
  int optValue4 = 0;
  int countOptions = 0;
  final TextEditingController _comment = TextEditingController();
  StreamSubscription? subscription;
  List<Row> children = [];

  @override void initState(){
    dishId = widget.dishId;
    widget.getDishInfo(dishId);
    subscription = Repository.dishItemController.stream.listen((item) =>
    {
      setState(() {
        dish = item;
        int index = 0;
        for(var item in dish.options) {
          switch(index){
            case 0:
              optValue1 = (((int.parse(item.endValue)-int.parse(item.startValue))/2)+int.parse(item.startValue)).toInt();
              countOptions++;
              break;
            case 1:
              optValue2 = (((int.parse(item.endValue)-int.parse(item.startValue))/2)+int.parse(item.startValue)).toInt();
              countOptions++;
              break;
            case 2:
              optValue3 = (((int.parse(item.endValue)-int.parse(item.startValue))/2)+int.parse(item.startValue)).toInt();
              countOptions++;
              break;
            case 3:
              optValue4 = (((int.parse(item.endValue)-int.parse(item.startValue))/2)+int.parse(item.startValue)).toInt();
              countOptions++;
              break;
          }
          index++;
        }
        subscription?.cancel();
      })
    }
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(5),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Expanded(child: Image.asset("assets/images/image.png", fit: BoxFit.fitHeight,)),
              Expanded(child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Text(dish.name, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18),),
                  const SizedBox(height: 10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text("Время\nготовки", style: TextStyle(fontSize: 16),),
                      Text(dish.cookTime, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),)
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text("Вес:", style: TextStyle(fontSize: 16)),
                      Text(dish.weight, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),)
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Text("Цена:", style: TextStyle(fontSize: 16)),
                      Text(dish.price, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),)
                    ],
                  )
                ],
              ))
            ],),
          const Text("Состав:", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),),
          Text(dish.compound, style: const TextStyle(fontSize: 16),),
          const SizedBox(height: 10),
          const Text("Опции:",  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
          Column(
            children: [
                        countOptions>0 ? Row(
                        children: [
                        SizedBox(
                          width: 100,
                          child: Text(dish.options[0].name, ),
                        ),
                        Text((int.parse(optValue1.toString()).toString()+" г.")),
                        Slider(value: optValue1.toDouble(), onChanged: (double value){
                          setState(() {
                            optValue1=value.toInt();
                          });
                        },divisions: int.parse(dish.options[0].endValue)-int.parse(dish.options[0].startValue),label: optValue1.toString(), min: int.parse(dish.options[0].startValue).toDouble(), max: int.parse(dish.options[0].endValue).toDouble(), thumbColor: Colors.black, inactiveColor: Colors.black, activeColor: Colors.black,)
                      ],
                    ) : const SizedBox(),
              countOptions>1 ? Row(
                children: [
                  SizedBox(
                    width: 100,
                    child: Text(dish.options[1].name, ),
                  ),
                  Text((int.parse(optValue2.toString()).toString()+" г.")),
                  Slider(value: optValue2.toDouble(), onChanged: (double value){
                    setState(() {
                      optValue2=value.toInt();
                    });
                  },divisions: int.parse(dish.options[1].endValue)-int.parse(dish.options[1].startValue),label: optValue2.toString(), min: int.parse(dish.options[1].startValue).toDouble(), max: int.parse(dish.options[1].endValue).toDouble(), thumbColor: Colors.black, inactiveColor: Colors.black, activeColor: Colors.black,)
                ],
              ) : const SizedBox(),
              countOptions>2 ? Row(
                children: [
                  SizedBox(
                    width: 100,
                    child: Text(dish.options[2].name, ),
                  ),
                  Text((int.parse(optValue3.toString()).toString()+" г.")),
                  Slider(value: optValue3.toDouble(), onChanged: (double value){
                    setState(() {
                      optValue3=value.toInt();
                    });
                  },divisions: int.parse(dish.options[2].endValue)-int.parse(dish.options[2].startValue),label: optValue3.toString(), min: int.parse(dish.options[2].startValue).toDouble(), max: int.parse(dish.options[2].endValue).toDouble(), thumbColor: Colors.black, inactiveColor: Colors.black, activeColor: Colors.black,)
                ],
              ) : const SizedBox(),
              countOptions>3 ? Row(
                children: [
                  SizedBox(
                    width: 100,
                    child: Text(dish.options[3].name, ),
                  ),
                  Text((int.parse(optValue4.toString()).toString()+" г.")),
                  Slider(value: optValue4.toDouble(), onChanged: (double value){
                    setState(() {
                      optValue4=value.toInt();
                    });
                  },divisions: int.parse(dish.options[3].endValue)-int.parse(dish.options[3].startValue),label: optValue4.toString(), min: int.parse(dish.options[3].startValue).toDouble(), max: int.parse(dish.options[3].endValue).toDouble(), thumbColor: Colors.black, inactiveColor: Colors.black, activeColor: Colors.black,)
                ],
              ) : const SizedBox(),
            ],
          ),
          const Text("Комментарий к заказу:", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
          const SizedBox(height: 5),
          TextField(
            controller: _comment,
            keyboardType: TextInputType.multiline,
            maxLines: null,
            decoration: const InputDecoration(
                enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Color.fromARGB(64, 0, 0, 0), width: 2)
                )
            ),
          ),
          ElevatedButton(onPressed: (){
            String options = "";
            for(var i=0; i<countOptions; i++){
              options+=dish.options[i].name+"-";
              switch(i){
                case 0:
                  options+=optValue1.toString()+"|";
                  break;
                case 1:
                  options+=optValue2.toString()+"|";
                  break;
                case 2:
                  options+=optValue3.toString()+"|";
                  break;
                case 3:
                  options+=optValue4.toString()+"|";
                  break;
              }
            }
            options = options.substring(0, options.length-1);
            Repository.addDishToOrderSP(dish.id, _comment.text=="" ? " " : _comment.text, options);
          }, child: const Text("ПОДТВЕРДИТЬ ВЫБОР", style: TextStyle(color: Colors.white)),style: ElevatedButton.styleFrom(primary: const Color.fromARGB(255, 72, 216, 22))),
        ],
      ),
    );
  }
  @override
  void dispose(){
    subscription?.cancel();
    super.dispose();
  }
}