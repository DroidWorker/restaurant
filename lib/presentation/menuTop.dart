import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class menuTopWidget extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 270,
      padding: EdgeInsets.all(10),
      decoration: const BoxDecoration(
        color: Color.fromARGB(255, 240, 238, 238),
        borderRadius: BorderRadius.all(Radius.circular(5))
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            height: 90,
            child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(child: Container(
                height: 90,
                color: Colors.white,
                padding: EdgeInsets.all(5),
                margin: EdgeInsets.fromLTRB(5, 0, 5, 5),
                child:
                  Column(
                    children: [
                      Image.asset("assets/images/image.png"),
                      Text("text")
                    ],
                  )
              ),
              ),
              Expanded(child: Container(
                  height: 90,
                  color: Colors.white,
                  padding: EdgeInsets.all(5),
                  margin: EdgeInsets.fromLTRB(5, 0, 5, 5),
                  child:
                  Column(
                    children: [
                      Image.asset("assets/images/image.png"),
                      Text("text")
                    ],
                  )
              ),
              ),
              Expanded(child: Container(
                  height: 90,
                  color: Colors.white,
                  padding: EdgeInsets.all(5),
                  margin: EdgeInsets.fromLTRB(5, 0, 5, 5),
                  child:
                  Column(
                    children: [
                      Image.asset("assets/images/image.png"),
                      Text("text")
                    ],
                  )
              )
              ),
            ],
          ),
          ),
          Container(
            height: 90,
            child:Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(child: Container(
                  color: Colors.white,
                  padding: EdgeInsets.all(5),
                  margin: const EdgeInsets.fromLTRB(5, 0, 5, 5),
                  child:
                  Column(
                    children: [
                      Image.asset("assets/images/image.png"),
                      Text("text")
                    ],
                  )
              ),
              ),
              Expanded(child: Container(
                  color: Colors.white,
                  padding: EdgeInsets.all(5),
                  margin: const EdgeInsets.fromLTRB(5, 0, 5, 5),
                  child:
                  Column(
                    children: [
                      Image.asset("assets/images/image.png"),
                      Text("text")
                    ],
                  )
              ),
              ),
              Expanded(child: Container(
                  color: Colors.white,
                  padding: EdgeInsets.all(5),
                  margin: const EdgeInsets.fromLTRB(5, 0, 5, 5),
                  child:
                  Column(
                    children: [
                      Image.asset("assets/images/image.png"),
                      Text("text")
                    ],
                  )
              ),
              )
            ],
          ),
          ),
          Container(
              height: 50,
              child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(child: Container(
                    color: Colors.white,
                    padding: EdgeInsets.all(5),
                    margin: const EdgeInsets.fromLTRB(5, 0, 5, 5),
                    child:
                    Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: const [
                        Text("text")
                      ],
                    )
                ),
                ),
                Expanded(child: Container(
                    color: Colors.white,
                    padding: EdgeInsets.all(5),
                    margin: const EdgeInsets.fromLTRB(5, 0, 5, 5),
                    child:
                    Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: const [
                        Text("text")
                      ],
                    )
                ),
                ),
                Expanded(child: Container(
                    color: Colors.white,
                    padding: EdgeInsets.all(5),
                    margin: const EdgeInsets.fromLTRB(5, 0, 5, 5),
                    child:
                    Column(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: const [
                        Text("text")
                      ],
                    )
                ),
                )
              ],
          )
          ),
        ],
      ),
    );
  }

}