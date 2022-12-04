import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AboutScreenWidget extends StatefulWidget {
  @override
  _state createState() => _state();
}

  class _state extends State<AboutScreenWidget> {
  int mode = 0;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children:[
          Container(
              padding: const EdgeInsets.fromLTRB(10, 20, 10, 0),
              child: Column(
                children: [
                  Image.asset("assets/images/aboutImage.png"),
                  const SizedBox(height: 10),
                  mode==0?
                  const Text("Задача организации, в особенности же постоянное информационно-пропагандистское обеспечение нашей деятельности обеспечивает широкому кругу (специалистов) участие в формировании новых предложений. Значимость этих проблем настолько очевидна, что постоянный количественный рост и сфера нашей активности позволяет оценить значение дальнейших направлений развития. Равным образом новая модель организационной деятельности обеспечивает широкому кругу (специалистов) участие в формировании форм развития.  ",
                    style: TextStyle(fontSize: 18),
                  ): mode==1?
                  const Text("Текст о скидках за баллы",
                    style: TextStyle(fontSize: 18),
                  ): mode==2?
                  const Text("Текст о способах оплаты",
                    style: TextStyle(fontSize: 18),
                  ):
                  Image.asset("assets/images/map.png", height: 300, fit: BoxFit.cover),
                  const SizedBox(height: 5),
                  Container(
                    decoration: BoxDecoration(
                      border: Border.all(width: 0.5, color: const Color.fromARGB(128, 0, 0, 0))
                    ),
                  ),
                  const SizedBox(height: 10),
                  GestureDetector(
                    onTap: (){setState(() {
                      mode=1;
                    });},
                    child: Container(
                      padding: const EdgeInsets.all(5),
                      child:Row(
                        children: const [
                          Icon(Icons.arrow_forward_ios_rounded, size: 25, color: Color.fromARGB(255, 255, 173, 78)),
                          Text("Скидки за баллы", style: TextStyle(color: Color.fromARGB(255, 255, 173, 78), fontSize: 22))
                        ],
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: (){setState(() {
                      mode=2;
                    });},
                    child: Container(
                      padding: const EdgeInsets.all(5),
                      child:Row(
                        children: const [
                          Icon(Icons.arrow_forward_ios_rounded, size: 25, color: Color.fromARGB(255, 255, 173, 78)),
                          Text("Способы оплаты", style: TextStyle(color: Color.fromARGB(255, 255, 173, 78), fontSize: 22))
                        ],
                      ),
                    ),
                  ),
                  GestureDetector(
                    onTap: (){setState(() {
                      mode=3;
                    });},
                    child: Container(
                      padding: const EdgeInsets.all(5),
                      child:Row(
                        children: const [
                          Icon(Icons.arrow_forward_ios_rounded, size: 25, color: Color.fromARGB(255, 255, 173, 78)),
                          Text("Как проехать", style: TextStyle(color: Color.fromARGB(255, 255, 173, 78), fontSize: 22))
                        ],
                      ),
                    ),
                  )
                ],
              ),
            ),
          Container(
            color: const Color.fromARGB(255, 255, 173, 78),
            padding: const EdgeInsets.fromLTRB(20, 5, 20, 5),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                IconButton(onPressed: (){}, icon: Image.asset("assets/images/inst.png")),
                IconButton(onPressed: (){}, icon: Image.asset("assets/images/fb.png")),
                IconButton(onPressed: (){}, icon: Image.asset("assets/images/tg.png")),
                Column(
                  children: const [
                    Text("somegmail@gmail.com", style: TextStyle(fontSize: 16)),
                    Text("+375 29 481 1 148", style: TextStyle(fontSize: 16))
                  ],
                )
              ],
            ),
          )
        ]
    );
  }

  }