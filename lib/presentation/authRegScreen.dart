import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class AuthRegScreenWidget extends StatefulWidget{
  int mode = 1;

  AuthRegScreenWidget({required this.mode, Key? key}) : super(key: key);

  @override
  _state createState() => _state(this.mode);
}

class _state extends State<AuthRegScreenWidget>{
  int mode = 1;
  //0-registration
  //1-authorisation

  _state(this.mode);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(20),
      child: mode==0? Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const SizedBox(height: 10),
          Container(
            height: 40,
            padding: const EdgeInsets.fromLTRB(5, 0, 0, 0),
            alignment: Alignment.centerLeft,
            decoration: const BoxDecoration(
                color: Color.fromARGB(255, 241, 241, 241),
                borderRadius: BorderRadius.all(Radius.circular(5))
            ),
            child: const TextField(
              decoration: InputDecoration.collapsed(
                  hintText: 'Фамилия'
              ),
            ),
          ),
          Container(
            height: 40,
            padding: const EdgeInsets.fromLTRB(5, 0, 0, 0),
            alignment: Alignment.centerLeft,
            decoration: const BoxDecoration(
                color: Color.fromARGB(255, 241, 241, 241),
                borderRadius: BorderRadius.all(Radius.circular(5))
            ),
            child: const TextField(
              decoration: InputDecoration.collapsed(
                  hintText: 'Имя, отчество'
              ),
            ),
          ),
          Container(
            height: 40,
            padding: const EdgeInsets.fromLTRB(5, 0, 0, 0),
            alignment: Alignment.centerLeft,
            decoration: const BoxDecoration(
                color: Color.fromARGB(255, 241, 241, 241),
                borderRadius: BorderRadius.all(Radius.circular(5))
            ),
            child: const TextField(
              decoration: InputDecoration.collapsed(
                  hintText: 'Телефон'
              ),
            ),          ),
          Container(
            height: 40,
            padding: const EdgeInsets.fromLTRB(5, 0, 0, 0),
            alignment: Alignment.centerLeft,
            decoration: const BoxDecoration(
                color: Color.fromARGB(255, 241, 241, 241),
                borderRadius: BorderRadius.all(Radius.circular(5))
            ),
            child: const TextField(
              decoration: InputDecoration.collapsed(
                  hintText: 'Email'
              ),
            ),          ),
          Container(
            height: 40,
            padding: const EdgeInsets.fromLTRB(5, 0, 0, 0),
            alignment: Alignment.centerLeft,
            decoration: const BoxDecoration(
                color: Color.fromARGB(255, 241, 241, 241),
                borderRadius: BorderRadius.all(Radius.circular(5))
            ),
            child: const TextField(
              decoration: InputDecoration.collapsed(
                  hintText: 'Пароль'
              ),
            ),          ),
          Container(
            height: 40,
            padding: const EdgeInsets.fromLTRB(5, 0, 0, 0),
            alignment: Alignment.centerLeft,
            decoration: const BoxDecoration(
                color: Color.fromARGB(255, 241, 241, 241),
                borderRadius: BorderRadius.all(Radius.circular(5))
            ),
            child: const TextField(
              decoration: InputDecoration.collapsed(
                  hintText: 'Подтвердите пароль'
              ),
            ),          ),
          const SizedBox(height: 10),
          ElevatedButton(onPressed: (){}, child: const Text("ЗАРЕГИСТРИРОВАТЬСЯ", style: TextStyle(fontSize: 18)), style: ElevatedButton.styleFrom(primary: const Color.fromARGB(255, 72, 216, 22)),),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Text("Уже с нами?", style: TextStyle(fontSize: 16),),
              GestureDetector(
                onTap: (){
                  setState(() {
                    mode=1;
                  });
                },
                child: const Text(" Войдите", style: TextStyle(color: Color.fromARGB(255, 72, 216, 22), fontSize: 16),),
              )
            ],
          )
        ],
      ):
        Column(
          children: [
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Container(
                    height: 40,
                    padding: const EdgeInsets.fromLTRB(5, 0, 0, 0),
                    alignment: Alignment.centerLeft,
                    decoration: const BoxDecoration(
                        color: Color.fromARGB(255, 241, 241, 241),
                        borderRadius: BorderRadius.all(Radius.circular(5))
                    ),
                    child: const TextField(
                      decoration: InputDecoration.collapsed(
                          hintText: 'Email'
                      ),
                    ),          ),
                  const SizedBox(height: 20,),
                  Container(
                    height: 40,
                    padding: const EdgeInsets.fromLTRB(5, 0, 0, 0),
                    alignment: Alignment.centerLeft,
                    decoration: const BoxDecoration(
                        color: Color.fromARGB(255, 241, 241, 241),
                        borderRadius: BorderRadius.all(Radius.circular(5))
                    ),
                    child: const TextField(
                      decoration: InputDecoration.collapsed(
                          hintText: 'Пароль'
                      ),
                    ),          ),
                ],
              ),
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                ElevatedButton(onPressed: (){}, child: const Text("ЗАРЕГИСТРИРОВАТЬСЯ", style: TextStyle(fontSize: 18)), style: ElevatedButton.styleFrom(primary: const Color.fromARGB(255, 72, 216, 22)),),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text("Ещё не с нами?", style: TextStyle(fontSize: 16),),
                    GestureDetector(
                      onTap: (){
                        setState(() {
                          mode=0;
                        });
                      },
                      child: const Text(" Зарегистрируйтесь", style: TextStyle(color: Color.fromARGB(255, 72, 216, 22), fontSize: 16),),
                    )
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text("Забыли пароль?", style: TextStyle(fontSize: 16),),
                    GestureDetector(
                      onTap: (){},
                      child: const Text("Восстановить", style: TextStyle(color: Color.fromARGB(255, 72, 216, 22), fontSize: 16),),
                    )
                  ],
                )
              ],
            )
          ],
        )
    );
  }

}