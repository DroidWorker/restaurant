import 'package:flutter/material.dart';

class OrderItemScreenWidget extends StatefulWidget{
  const OrderItemScreenWidget({Key? key}) : super(key: key);

  @override
  _state createState() => _state();
}
class _state extends State<OrderItemScreenWidget>{
  double firstSliderValue = 5;
  double secondSliderValue = 25;
  double thirdSliderValue = 50;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(5),
      child: Column(
        children: [
          Expanded(child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Expanded(child: Image.asset("assets/images/image.png", fit: BoxFit.fitHeight,)),
              Expanded(child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  const Text("Крем-суп из тыквы", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),),
                  const SizedBox(height: 10),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: const [
                      Text("Время\nготовки", style: TextStyle(fontSize: 16),),
                      Text("10 мин", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),)
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: const [
                      Text("Вес:", style: TextStyle(fontSize: 16)),
                      Text("350 г", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),)
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: const [
                      Text("Цена:", style: TextStyle(fontSize: 16)),
                      Text("5 р", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),)
                    ],
                  )
                ],
              ))
            ],)),
          const Text("Состав:", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),),
          const Text("Тыква,  репчатый лук,  чеснок,  сливочное масло,  сливки,  растительное масло,  бекон, соль, баклажан, огурец, перец чили, томат", style: TextStyle(fontSize: 16),),
          const SizedBox(height: 10),
          const Text("Опции:",  style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
          Row(
            children: [
              const Text("Соль"),
              const Text("2 г"),
              Slider(value: firstSliderValue, onChanged: (double value){
                setState(() {
                  firstSliderValue = value;
                });
              }, min: 0, max: 10, thumbColor: Colors.black, inactiveColor: Colors.black, activeColor: Colors.black,)
            ],
          ),
          Row(
            children: [
              const Text("Соль"),
              const Text("2 г"),
              Slider(value: secondSliderValue, onChanged: (double value){
                setState(() {
                  secondSliderValue = value;
                });
              }, min: 0, max: 50, thumbColor: Colors.black, inactiveColor: Colors.black, activeColor: Colors.black),
            ],
          ),
          Row(
            children: [
              const Text("Соль"),
              const Text("2 г"),
              Slider(value: thirdSliderValue, onChanged: (double value){
                setState(() {
                  thirdSliderValue = value;
                });
              }, min: 0, max: 100, thumbColor: Colors.black, inactiveColor: Colors.black, activeColor: Colors.black)
            ],
          ),
          const Text("Комментарий к заказу:", style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
          const SizedBox(height: 5),
          TextField(
            keyboardType: TextInputType.multiline,
            maxLines: null,
            decoration: InputDecoration(
                enabledBorder: OutlineInputBorder(
                    borderSide: BorderSide(color: Color.fromARGB(64, 0, 0, 0), width: 2)
                )
            ),
          ),
          ElevatedButton(onPressed: (){}, child: const Text("ПОДТВЕРДИТЬ ВЫБОР", style: TextStyle(color: Colors.white)),style: ElevatedButton.styleFrom(primary: const Color.fromARGB(255, 72, 216, 22))),
        ],
      ),
    );
  }

}