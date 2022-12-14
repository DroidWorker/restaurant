import 'package:flutter/material.dart';

class topItemWidget extends StatelessWidget{
  final String id;
  final String topName;
  final String compound;
  final String price;
  final String weight;
  final String imgPath;
  Function callback;
  topItemWidget({Key? key, required this.callback, required this.id, required this.topName, required this.compound, required this.price, required this.weight, required this.imgPath}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(5),
      margin: const EdgeInsets.only(bottom: 5),
      decoration: BoxDecoration(
        border: Border.all(
          color: const Color.fromARGB(153, 170, 170, 170)
        )
      ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Image.asset((imgPath!="")? imgPath : "assets/images/spices.png", width: 100),
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
                  callback(int.parse(id));
                }, child: const Text("ЗАКАЗАТЬ"), style: ElevatedButton.styleFrom(primary: const Color.fromARGB(255, 72, 216, 22)),)
              ],
            )
            )
          ],
    ));
  }

}