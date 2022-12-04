import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ReviewScreenWidget extends StatefulWidget{
  @override
  _state createState() => _state();
}

class _state extends State<ReviewScreenWidget>{
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.fromLTRB(10, 10, 10, 20),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Image.asset("assets/images/reviewImage.png"),
            Expanded(child: Container(
              margin: const EdgeInsets.fromLTRB(0, 20, 0, 20),
              width: double.infinity,
              decoration: BoxDecoration(
                border: Border.all(
                  color: const Color.fromARGB(51, 0, 0, 0)
                ),
                borderRadius: const BorderRadius.all(Radius.circular(5))
              ),
              child: Column(
                children: const [
                  Text(""),
                  SizedBox(height: 10),
                  Text("")
                ],
              )
            )
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                IconButton(onPressed: (){}, icon: const Icon(Icons.arrow_back_ios_rounded, size: 40), color: const Color.fromARGB(255, 72, 216, 22)),
                IconButton(onPressed: (){}, icon: const Icon(Icons.arrow_forward_ios_rounded, size: 40), color: const Color.fromARGB(255, 72, 216, 22))
              ],
            )
          ],
        )
    );
  }

}