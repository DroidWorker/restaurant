import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class searchBoxWidget extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 90,
      padding: const EdgeInsets.all(10),
      decoration: const BoxDecoration(
          color: Color.fromARGB(105, 0, 0, 0),
          borderRadius: BorderRadius.all(Radius.circular(5))
      ),
      child: Column(
        children: [
          Container(
            height: 40,
            decoration: const BoxDecoration(
              color: Color.fromARGB(255, 241, 241, 241),
              borderRadius: BorderRadius.all(Radius.circular(5))
            ),
            child: Row(
              children: [
                const Expanded(child: TextField()),
                ElevatedButton(
                    onPressed: (){},
                    child: const Text("НАЙТИ"),
                  style: ElevatedButton.styleFrom(primary: const Color.fromARGB(255, 255, 173, 78)),
                )
              ],
            ),
          ),
          Expanded(child:
            Row(
              children: const[
                Text("Например: ", style: TextStyle(fontSize: 16)),
                Text("Пицца  Монсеньор", style: TextStyle(fontSize: 16, color: Color.fromARGB(255, 72, 216, 22),decoration: TextDecoration.underline),),
              ],
            ),
          )
        ],
      ),
    );
  }

}