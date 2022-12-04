import 'package:firebase_database/firebase_database.dart';

class DB{
  static void register(String surname, String name, String phone, String email, String password) async{
    DatabaseReference ref = FirebaseDatabase(databaseURL: "https://restaurant-2f63c-default-rtdb.europe-west1.firebasedatabase.app/").ref("accounts");
    final snapshot = await ref.get();
    if (snapshot.exists) {
      print(snapshot.value);
      int id = 1;
      for (var element in snapshot.children) {
        if(int.parse(element.key!)>id){
          id = int.parse(element.key!);
        }
      }
      id++;
      await ref.child(id.toString()).set({
          "surname":surname,
          "name": name,
          "phone": phone,
          "email": email,
          "password": password
      });
    } else {
      print('No data available.');
    }
  }
}