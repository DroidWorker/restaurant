import 'package:flutter/material.dart';

class DrawerListItemWidget extends StatelessWidget{
  final String itemName;
  final String itemIcon;
  const DrawerListItemWidget({Key? key, required this.itemName, required this.itemIcon}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: Align(alignment: Alignment.center, child: Image.asset(itemIcon)),
          ),
          Expanded(

            child: Align(alignment: Alignment.center, child: Text(itemName, style: const TextStyle(fontSize: 20)),
          ),
          )
        ],
      ),
    );
  }

}