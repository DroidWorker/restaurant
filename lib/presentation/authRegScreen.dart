import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../data/repository.dart';

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


  final TextEditingController _surname = TextEditingController();
  final TextEditingController _name = TextEditingController();
  final TextEditingController _phone = TextEditingController();
  final TextEditingController _email = TextEditingController();
  final TextEditingController _password = TextEditingController();
  final TextEditingController _passwordCheck = TextEditingController();

  int err = 0;
  //1-surname
  //2-name
  //3-phone
  //4-email
  //5-password
  //6-passwordCheck

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
            child: TextField(
              style: TextStyle(color: err==1 ? Colors.red : Colors.black),
              keyboardType: TextInputType.name,
              controller: _surname,
              decoration: const InputDecoration.collapsed(
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
            child: TextField(
              style: TextStyle(color: err==2 ? Colors.red : Colors.black),
              keyboardType: TextInputType.name,
              controller: _name,
              decoration: const InputDecoration.collapsed(
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
            child: TextField(
              style: TextStyle(color: err==3 ? Colors.red : Colors.black),
              keyboardType: TextInputType.phone,
              controller: _phone,
              decoration: const InputDecoration.collapsed(
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
            child: TextField(
              style: TextStyle(color: err==4 ? Colors.red : Colors.black),
              keyboardType: TextInputType.emailAddress,
              controller: _email,
              decoration: const InputDecoration.collapsed(
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
            child: TextField(
              style: TextStyle(color: err==5 ? Colors.red : Colors.black),
              keyboardType: TextInputType.visiblePassword,
              obscureText: true,
              obscuringCharacter: "·",
              controller: _password,
              decoration: const InputDecoration.collapsed(
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
            child: TextField(
              style: TextStyle(color: err==6 ? Colors.red : Colors.black),
              keyboardType: TextInputType.visiblePassword,
              obscureText: true,
              obscuringCharacter: "·",
              controller: _passwordCheck,
              decoration: const InputDecoration.collapsed(
                  hintText: 'Подтвердите пароль'
              ),
            ),          ),
          const SizedBox(height: 10),
          ElevatedButton(onPressed: (){
            if(_checkIfDataCorrect()){
              Repository.register(_surname.text, _name.text, _phone.text, _email.text, _password.text);
              Repository.addStringToSP("mySurname", _surname.text);
              Repository.addStringToSP("myName", _name.text);
              Repository.addStringToSP("myPhone", _phone.text);
              Repository.addStringToSP("myEmail", _email.text);
            }
          }, child: const Text("ЗАРЕГИСТРИРОВАТЬСЯ", style: TextStyle(fontSize: 18)), style: ElevatedButton.styleFrom(primary: const Color.fromARGB(255, 72, 216, 22)),),
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

  bool _checkIfDataCorrect(){
    bool flag = true;
    if(_surname.text.length<3||_surname.text.length>30){
      err = 1;
      flag = false;
    }
    else if(_name.text.length<3||_name.text.length>30){
      err = 2;
      flag = false;
    }
    else if(_phone.text.length<9||_phone.text.length>13){
      err = 3;
      flag = false;
    }
    else if(!RegExp(r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+").hasMatch(_email.text)){
      err = 4;
      flag = false;
    }
    else if(_password.text.length<5||_password.text.length>30){
      err = 5;
      flag = false;
    }
    else if(_password.text!=_passwordCheck.text){
      err = 6;
      flag = false;
    }
    if(flag){err = 0;}
    else{
      setState(() {

      });
    }
    return flag;
  }
}