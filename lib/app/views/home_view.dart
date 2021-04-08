import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:json_to_sqflite_poc/app/data/repository.dart';
import 'dart:async';

import 'package:json_to_sqflite_poc/app/models/user_model.dart';

class HomeView extends StatelessWidget {

  var repository = Repository();


  Future<void> populateDataToDatabase() async {

    Dio dio = Dio();
    String url = "https://jsonplaceholder.typicode.com/users";
    List<dynamic> users;

    Response<List<dynamic>> response = await dio.get(url);
    users = response.data;

    users.forEach((user) {
      user.remove("address");
      user.remove('company');
    });


     users.map((user) => UserModel.fromJson(user)).toList().forEach((user) {
       repository.insertUser(user).then((value) => print("User inserting"));
     });



  }

   Future<List<UserModel>> getUsersFromDatabase() async {
    var databaseUsers = await repository.getAllUsers();
    return databaseUsers.map((user) => UserModel.fromJson(user)).toList();
  }


  @override
  Widget build(BuildContext context) {

    populateDataToDatabase();

    List<UserModel> userList;

     return Scaffold(body: Container(color: Colors.cyan,),);
    // FutureBuilder(
    //     future: getUsersFromDatabase(),
    //     builder: (context, AsyncSnapshot snapshot) {
    //       if(snapshot.connectionState == ConnectionState.done) {
    //
    //         return Scaffold(
    //           appBar: AppBar(
    //             title: Text('Json to SQFLite'),
    //             centerTitle: true,
    //           ),
    //           body: Center(
    //             child: ListView.builder(
    //                 itemCount: userList.length,
    //                 itemBuilder: (context, index) {
    //                   return Card(
    //                     child: ListTile(
    //                       title: Text(userList[index].name),
    //                       subtitle: Text(userList[index].email),
    //                     ),
    //                   );
    //                 }
    //             ),
    //           ),
    //         );
    //       }
    //
    //       return Scaffold(
    //         appBar: AppBar(
    //           title: Text("Json to SQFLite"),
    //           centerTitle: true,
    //         ),
    //         body: Center(child: CircularProgressIndicator()),
    //       );
    //
    //     });
  }
}
