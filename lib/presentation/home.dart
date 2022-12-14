import 'dart:async';

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:restaurant_v2/domain/model/dish.dart';
import 'package:restaurant_v2/presentation/aboutScreen.dart';
import 'package:restaurant_v2/presentation/authRegScreen.dart';
import 'package:restaurant_v2/presentation/drawerListItem.dart';
import 'package:restaurant_v2/presentation/menuTop.dart';
import 'package:restaurant_v2/presentation/orderListScreen.dart';
import 'package:restaurant_v2/presentation/orderitemScreen.dart';
import 'package:restaurant_v2/presentation/reviewScreen.dart';
import 'package:restaurant_v2/presentation/searchBox.dart';
import 'package:restaurant_v2/presentation/topItem.dart';

import '../data/db.dart';
import '../data/repository.dart';
import '../firebase_options.dart';
import 'menuScreen.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  StreamSubscription? subscription, tablesSubscription;
  List<Dish> dishes = List<Dish>.empty(growable: true);
  List<topItemWidget> topWidgets = List<topItemWidget>.empty(growable: true);

  void topitemCallback(int id){
    setState(() {
      screen=5;
      _dishId = id;
    });
  }

  void initFirebase() async{
    WidgetsFlutterBinding.ensureInitialized();
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );
    Repository.getTop();
    subscription = Repository.topController.stream.listen((item) =>
    {
      setState(() {
        dishes = item;
        for (var element in dishes) {
          topWidgets.add(topItemWidget(callback: topitemCallback, id: element.id, topName: element.name, compound: element.compound, price: element.price, weight: element.weight, imgPath: "imgPath"));
        }
        subscription?.cancel();
      })
    }
    );
  }

  int _dishId = 0;
  static int screen = 0;
  //0-main screen
  //1-review screen
  //2-about screen
  //3-menu screen
  //4-details screen
  //5-order screen
  //6-authorisation/registration screen
  int screenParam = 0;

  @override
  void initState(){
    super.initState();
    initFirebase();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: false,
        automaticallyImplyLeading: false,

        title: Row(children: [
          GestureDetector(
              child: Image.asset("assets/images/logo.png"),
            onTap: (){setState(() {
              screen=0;
            });},
          ),
          const SizedBox(width: 25),
          Column(
              children:const [
                Text("Прием звонков",
                  style: TextStyle(
                      fontSize: 16,
                      color: Colors.white
                  ),
                ),
                Text("с 10:00 до 21:00",
                  style: TextStyle(
                      fontSize: 16,
                      color: Colors.white
                  ),
                )
              ]
          ),
        ],
        ),
        actions: [
          IconButton(onPressed: (){

            }, icon: const Icon(Icons.share, color: Colors.white)),
          IconButton(onPressed: (){
            setState(() {
              screen = 4;
            });
          }, icon: Image.asset("assets/images/backet.png")),
          //IconButton(onPressed: () => Scaffold.of().openDrawer(), icon: const Icon(Icons.menu, color: Colors.white))
          Builder(builder: (context){
            return IconButton(onPressed: () => Scaffold.of(context).openDrawer(), icon: const Icon(Icons.menu, color: Colors.white));
          },)
        ],
        backgroundColor: Colors.black,
      ),
      body:
          screen == 0? Container(
            padding: const EdgeInsets.fromLTRB(10, 10, 10, 0),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  menuTopWidget(),
                  const SizedBox(height: 20),
                  searchBoxWidget(),
                  const SizedBox(height: 20),
                  Image.asset("assets/images/topofday.png"),
                  const SizedBox(height: 10),
                  Column(children: topWidgets)
                ],
              ),
            ),
          ) : screen==1? ReviewScreenWidget(

          ): screen==2? AboutScreenWidget(

          ): screen==3? MenuScreenWidget(
            updateRoot: (int dishId){setState(() {
              screen=5;
              _dishId = dishId;
            });},
            mode: screenParam,
            key: UniqueKey(),
          ): screen==4? const OrderListScreenWidget(

          ): screen==5? OrderItemScreenWidget(
            dishId: _dishId
          ): screen==6? AuthRegScreenWidget(
            mode: screenParam,
            key: UniqueKey(),
          ): const SizedBox.shrink(),
      drawer: Drawer(
        child: Padding(
            padding: const EdgeInsets.all(10),
            child: Column(
              children: [
                const SizedBox(
                  width: double.infinity,
                  height: 20,
                ),
                Container(
                  width: double.infinity,
                  decoration: BoxDecoration(
                      color: const Color.fromARGB(255, 72, 216, 22),
                      border: Border.all(
                        color: const Color.fromARGB(255, 72, 216, 22),
                      ),
                      borderRadius: const BorderRadius.all(const Radius.circular(5))
                  ),
                  child: const Text(
                    "+375 29 481 1 148",
                    textDirection: TextDirection.ltr,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 20,
                      color: Colors.white
                    ),
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                        child: ElevatedButton(
                        onPressed: (){
                          setState(() {
                            screenParam=1;
                            screen=6;
                            Navigator.pop(context);
                          });
                        },
                        child: const Text("ВОЙТИ"),
                        style: ElevatedButton.styleFrom(primary: const Color.fromARGB(255, 255, 173, 78)),
                        )
                    ),
                    const SizedBox(width: 20,),
                    Expanded(
                    child: ElevatedButton(
                        onPressed: (){
                          setState(() {
                            screenParam=0;
                            screen=6;
                            Navigator.pop(context);
                          });
                        },
                        child: const Text("РЕГИСТРАЦИЯ"),
                        style: ElevatedButton.styleFrom(primary: const Color.fromARGB(255, 72, 216, 22)),
                        )
                    )
                  ],
                ),
                Container(
                  height: 1,
                  decoration: const BoxDecoration(
                    color: Color.fromARGB(126, 0, 0, 0)
                  ),
                ),
                Expanded(
                  child: ListView(
                    children: [
                      GestureDetector(onTap: (){setState(() {
                        DB.getAllDishes();
                        screenParam=0;
                        screen=3;
                        Navigator.pop(context);
                      });},child: const DrawerListItemWidget(itemName: "ОТКРЫТЬ МЕНЮ", itemIcon: "assets/images/allmenu.png")),
                      GestureDetector(onTap: (){setState(() {
                        DB.getDishesByType("eat");
                        screenParam=1;
                        screen=3;
                        Navigator.pop(context);
                      });},child: const DrawerListItemWidget(itemName: "ЕДА", itemIcon: "assets/images/eat_burger.png")),
                      GestureDetector(onTap: (){setState(() {
                        DB.getDishesByType("drink");
                        screenParam=2;
                        screen=3;
                        Navigator.pop(context);
                      });},child: const DrawerListItemWidget(itemName: "НАПИТКИ", itemIcon: "assets/images/drink.png")),
                      GestureDetector(onTap: (){setState(() {
                        DB.getDishesByType("other");
                        screenParam=3;
                        screen=3;
                        Navigator.pop(context);
                      });},child: const DrawerListItemWidget(itemName: "РАЗНОЕ", itemIcon: "assets/images/spices.png"))
                    ],
                  ),
                ),
                Container(
                  height: 1,
                  decoration: const BoxDecoration(
                      color: Color.fromARGB(126, 0, 0, 0)
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                        child: ElevatedButton(
                          onPressed: (){setState(() {
                            screen=1;
                            //Scaffold.of(context).openEndDrawer();
                            Navigator.pop(context);
                          });},

                          child: const Text("ОТЗЫВЫ"),
                          style: ElevatedButton.styleFrom(primary: const Color.fromARGB(255, 72, 216, 22)),
                        )
                    ),
                    const SizedBox(width: 20,),
                    Expanded(
                        child: ElevatedButton(
                          onPressed: (){setState(() {
                            screen=2;
                            Navigator.pop(context);
                          });},
                          child: const Text("О НАС "),
                          style: ElevatedButton.styleFrom(primary: const Color.fromARGB(255, 72, 216, 22)),
                        )
                    )
                  ],
                ),
              ],
            )
        )
      ),
    );
  }
}