import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../data/repository.dart';

class OrderListItemWidget extends StatelessWidget{
  final String id;
  final String topName;
  final String compound;
  final String price;
  final String weight;
  final String imgPath;
  const OrderListItemWidget({Key? key,required this.id, required this.topName, required this.compound, required this.price, required this.weight, required this.imgPath}) : super();

  @override
  Widget build(BuildContext context) {
    return Container(
        padding: const EdgeInsets.all(5),
        decoration: BoxDecoration(
            border: Border.all(
                color: const Color.fromARGB(153, 170, 170, 170)
            )
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Image.asset(imgPath, width: 100),
            Expanded(child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(topName, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                const SizedBox(height: 5),
                Text(compound),
                const SizedBox(height: 5),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(price, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16)),
                    Text(weight, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16))
                  ],
                ),
                const SizedBox(height: 5),
                ElevatedButton(onPressed: (){
                  Repository.removeDishFromOrderSP(id);
                }, child: const Text("ОТМЕНИТЬ"), style: ElevatedButton.styleFrom(primary: const Color.fromARGB(255, 72, 216, 22)),)
              ],
            )
            )
          ],
        ));
  }

}