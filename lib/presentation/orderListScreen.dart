import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:restaurant_v2/domain/model/table.dart';
import 'package:restaurant_v2/presentation/orderListItem.dart';

import '../data/repository.dart';
import '../domain/model/dish.dart';

import 'package:number_selection/number_selection.dart';

List<TableItem> list = <TableItem>[TableItem(id: "0", placeCount: "0"), TableItem(id: "1", placeCount: "0")];
String selectedTable = "";

class OrderListScreenWidget extends StatefulWidget{
  const OrderListScreenWidget({Key? key}) : super(key: key);

  @override
  _state createState() => _state();
}

class _state extends State<OrderListScreenWidget>{
  List dishes = [
    Dish(id: "", type: "", name: "Крем-суп из тыквы", compound: "Тыква,  репчатый лук,  чеснок,  сливочное масло,  сливки,  растительное масло,  бекон, соль . . .", price: "16 р", weight: "220 г", cookTime: "", category: "1", options: List.empty(), imgPath: "assets/images/image.png")
  ];
  String _timeh = "10";
  String _timem = "30";
  int _curTimeh = 10;
  int _curTimem = 0;

  StreamSubscription? subscription, tablesSubscription;

  String getSumm(){
    int _summ = 0;
    for (var element in dishes) {_summ+=int.parse(element.price.replaceAll(RegExp(r'[^0-9]'),''));};
    return _summ.toString();
  }

  @override void initState() {
    var datetime = DateTime.now();
    _curTimeh = datetime.hour;
    _curTimem = datetime.minute;
    Repository.getOrdersFromSP();
    subscription = Repository.dishesController.stream.listen((item) =>
    {
      setState(() {
        dishes = item;
        subscription?.cancel();
      })
    }
    );
    Repository.getTables();
      subscription = Repository.freeTablesController.stream.listen((item) =>
    {
      setState(() {
        list = item;
        selectedTable = list.first.id;
        tablesSubscription?.cancel();
      })
    }
    );

    super.initState();
  }

  @override
  void dispose(){
    subscription?.cancel;
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    String summ = getSumm();

    return Container(
      padding: const EdgeInsets.all(10),
      child: Column(
        children: [
          Image.asset("assets/images/orderImage.png"),
          Expanded(child: ListView.builder(
              itemCount: dishes.length,
              itemBuilder: (BuildContext context, int index) {
                return OrderListItemWidget(
                      id: dishes[index].id,
                      topName: dishes[index].name,
                      compound: dishes[index].compound,
                      price: dishes[index].price,
                      weight: dishes[index].weight,
                      imgPath: dishes[index].imgPath);
              }
          ),),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(child: ElevatedButton(onPressed: (){
                Scaffold.of(context).showBottomSheet<void>(
                      (BuildContext context) {
                    return Container(
                      height: 250,
                      color: const Color.fromARGB(240, 0, 0, 0),
                      child: Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          mainAxisSize: MainAxisSize.min,
                          children: <Widget>[
                            const Text('Выберите стол', style: TextStyle(color: Colors.white, fontSize: 18)),
                            MDropdownButton(f: (String value){selectedTable = value;},),
                            SizedBox(
                              height: 90,
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                const Text("Выберите время      ", style: TextStyle(color: Colors.white, fontSize: 18)),
                                NumberSelection(
                                  theme: NumberSelectionTheme(
                                      draggableCircleColor: const Color.fromARGB(255, 72, 216, 22),
                                      iconsColor: Colors.black,
                                      numberColor: Colors.white,
                                      backgroundColor: Colors.white,
                                      outOfConstraintsColor: Colors.deepOrange),
                                  initialValue: _curTimeh,
                                  minValue: _curTimeh,
                                  maxValue: 21,
                                  direction: Axis.vertical,
                                  withSpring: true,
                                  onChanged: (int value) => _timeh=value.toString(),
                                  enableOnOutOfConstraintsAnimation: true,
                                  onOutOfConstraints: () => print("This value is too high or too low"),
                                ),
                                const SizedBox(width: 10),
                                const Text(":", style: TextStyle(color: Colors.white, fontSize: 20)),
                                const SizedBox(width: 10),
                                NumberSelection(
                                  theme: NumberSelectionTheme(
                                      draggableCircleColor: const Color.fromARGB(255, 72, 216, 22),
                                      iconsColor: Colors.black,
                                      numberColor: Colors.white,
                                      backgroundColor: Colors.white,
                                      outOfConstraintsColor: Colors.deepOrange),
                                  initialValue: 30,
                                  minValue: int.parse(_timeh)>_curTimeh ? 59 : _curTimem,
                                  maxValue: 59,
                                  direction: Axis.vertical,
                                  withSpring: true,
                                  onChanged: (int value) => _timem = value.toString(),
                                  enableOnOutOfConstraintsAnimation: true,
                                  onOutOfConstraints: () => print("This value is too high or too low"),
                                )
                              ],
                            )),
                            const SizedBox(height: 10),
                            ElevatedButton(
                              child: const Text('ПОДТВЕРДИТЬ БРОНЬ'),
                              style: ElevatedButton.styleFrom(primary: const Color.fromARGB(255, 72, 216, 22)),
                              onPressed: () {
                                if(selectedTable.isNotEmpty) {
                                  Repository.addOrder(
                                      selectedTable, _timeh+":"+_timem);
                                }
                                else{
                                  print("empty fields");
                                }
                                Navigator.pop(context);
                              },
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                );
              }, child: const Text("ЗАКАЗАТЬ"), style: ElevatedButton.styleFrom(primary: const Color.fromARGB(255, 72, 216, 22)),)),
              const SizedBox(width: 50,),
              Text("ИТОГО: $summ р ", style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),),
            ],
          )
        ],
      ),
    );
  }
}
class MDropdownButton extends StatefulWidget {
  Function f;
  MDropdownButton({required this.f, Key? key}) : super(key: key);

  @override
  State<MDropdownButton> createState() => _MDropdownButtonState(f);
}

class _MDropdownButtonState extends State<MDropdownButton> {
  late Function f;
  _MDropdownButtonState(this.f);
  String dropdownValue = list.first.id.toString();//"стол "+list.first.id+" количество мест: "+list.first.placeCount;

  @override
  Widget build(BuildContext context) {
    return DropdownButton(
      value: dropdownValue,
      icon: const Icon(Icons.arrow_downward),
      elevation: 16,
      dropdownColor: Colors.black87,
      style: const TextStyle(color: Color.fromARGB(255, 72, 216, 22)),
      underline: Container(
        height: 2,
        color: const Color.fromARGB(255, 72, 216, 22),
      ),
      onChanged: (String? value) {
        // This is called when the user selects an item.
        setState(() {
          f(value);
          dropdownValue = value!;
        });
      },
      items: list.map<DropdownMenuItem<String>>((TableItem value) {
        return DropdownMenuItem(
          value: value.id.toString(),
          child: Text("стол "+value.id+" количество мест: "+value.placeCount),
        );
      }).toList(),
    );
  }
}
