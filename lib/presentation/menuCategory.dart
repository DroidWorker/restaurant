import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class Menucategory extends StatelessWidget{
  final String text;
  final String imageAssetPath;
  final bool iconDown;

  const Menucategory({Key? key, required this.text, required this.imageAssetPath, required this.iconDown}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: const Color.fromARGB(153, 170, 170, 170))
      ),
      child: Row(
        children: [
          Image.asset(imageAssetPath),
          const SizedBox(width: 10,),
          Expanded(child: Text(text, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),)),
          Icon(iconDown ? Icons.keyboard_arrow_down_rounded : Icons.keyboard_arrow_up_rounded, color: const Color.fromARGB(153, 170, 170, 170),)
        ],
      ),
    );
  }
  
}