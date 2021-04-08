import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:json_to_sqflite_poc/app/data/repository.dart';
import 'dart:async';

import 'package:json_to_sqflite_poc/app/models/user_model.dart';

class HomeView extends StatefulWidget {
  @override
  _HomeViewState createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {

  var repository = Repository();
  List<UserModel> userList = [];

  Future<void> populateDataToDatabase() async {
    Dio dio = Dio();
    String url = "https://jsonplaceholder.typicode.com/users";
    List<dynamic> users;

    Response<List<dynamic>> response = await dio.get(url);
    users = response.data;

    users.forEach((user) {
      user.remove("id");
      user.remove("address");
      user.remove('company');
    });

    users.map((user) => UserModel.fromJson(user)).toList().forEach((
        user) async {
      await repository.insertUser(user);
    });
  }

  Future<List<UserModel>> getUsersFromDatabase() async {
    var databaseUsers = await repository.getAllUsers();
    return databaseUsers.map((user) => UserModel.fromJson(user)).toList();
  }



  @override
  void initState() {
    super.initState();
    populateDataToDatabase();
    getUsersFromDatabase().then((value) {
      setState(()  {
        userList.clear();
        userList = value;
      });
    });

  }

  @override
  Widget build(BuildContext context) {

    return FutureBuilder(
        future: populateDataToDatabase(),
        builder: (context, AsyncSnapshot snapshot) {
          return (snapshot.connectionState == ConnectionState.done)
              ? Scaffold(
            appBar: AppBar(
              title: Text('Json to SQFLite'),
              centerTitle: true,
            ),
            body: !(userList.isEmpty || userList == null)
                ? Center(
              child: ListView.builder(
                  itemCount: userList.length,
                  itemBuilder: (context, index) {
                    return Card(
                      child: ListTile(
                        title: Text(userList[index].name),
                        subtitle: Text(userList[index].email),
                      ),
                    );
                  }),
            )
                : Scaffold(
              body: Center(
                child: Text(
                  "Erro no retorno! $userList",
                  style: TextStyle(fontSize: 32),
                ),
              ),
            ),
          )
              : Scaffold(
            appBar: AppBar(
              title: Text("Json to SQFLite"),
              centerTitle: true,
            ),
            body: Center(child: CircularProgressIndicator()),
          );
        });
  }
}
