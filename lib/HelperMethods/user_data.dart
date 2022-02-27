import 'package:bhoomi/DataModels/user_model.dart';
import 'package:firebase_database/firebase_database.dart';

class UserData {
  static getUserData(String userId) async {
    final DataSnapshot snapshot =
        await FirebaseDatabase.instance.ref('users/$userId').get();
    UserModel usermodel = UserModel.fromMap(snapshot.value);
    print(snapshot.value);
    return usermodel;
  }
}
