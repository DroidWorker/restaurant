import 'package:restaurant_v2/domain/model/dishOption.dart';

class Dish{
  final String id;
  final String type;
  final String name;
  final String compound;
  final String price;
  final String weight;
  final String cookTime;
  final String category;
  final List<DishOption> options;
  final String imgPath;
  Dish({
    required this.id,
    required this.type,
    required this.name,
    required this.compound,
    required this.price,
    required this.weight,
    required this.cookTime,
    required this.category,
    required this.options,
    required this.imgPath
});
}