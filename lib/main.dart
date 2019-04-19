import 'dart:async';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

void main() => runApp(new MyApp());

class MyApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return new MaterialApp(
      title: 'Flutter Code Sample for material.AppBar.actions',
      theme: new ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: new MyHomePage(title: 'Users'),
    );
  }
}

class MyHomePage extends StatefulWidget{
  MyHomePage({Key key, this.title}):super(key:key);
  final String title;
  @override
  _MyHomePageState createState() => new _MyHomePageState();

}
class _MyHomePageState extends State<MyHomePage>{

  Future<List<User>> _getUser() async{
    var data = await http.get("http://www.json-generator.com/api/json/get/bYUlzUPxsO?indent=2");
    var jsonData = json.decode(data.body);

    List<User> users =[];
    for(var u in jsonData){
      User user = User(u["index"], u["about"], u["name"], u["picture"], u["gender"], u["age"], u["phone"], u["addesss"], u["email"]);

      users.add(user);
    }
    print(users.length);


    return users;
  }

  @override
  Widget build(BuildContext context) {
    return new Scaffold(
      appBar: new AppBar(
        title: new Text(widget.title),
      ),
      body: Container(
        child: FutureBuilder(
            future: _getUser(),
            builder: (BuildContext context,AsyncSnapshot snapshot ) {
              if (snapshot.data == null) {
                return Container(
                  child: Center(
                    child: Text("Loading..."),
                  ),
                );
              }
              else {
                return ListView.builder(
                  itemCount: snapshot.data.length,
                  itemBuilder: (BuildContext context, int index) {
                    return ListTile(
                      leading: CircleAvatar(
                        backgroundImage: NetworkImage(
                          snapshot.data[index].picture
                        ),
                      ),
                      title: Text(snapshot.data[index].name),
                      subtitle: Text(snapshot.data[index].email),
                      onTap: (){
                        Navigator.push(context,
                        new MaterialPageRoute(builder: (context) => DetailPage(snapshot.data[index]))
                        );
                      },
                    );
                  },
                );
              }
            }
        ),

      ),
    );
  }

}
class DetailPage extends StatelessWidget{
  final User user;
  DetailPage(this.user);
  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: Text(user.name),
      ),
    );
  }

}
class User  {
   final int index;
   final String about;
   final String name;
   final String picture;
   final String gender;
   final int age;
   final int phone;
   final String address;
   final String email;

   User(this.index,this.about,this.name,this.picture,this.gender,this.age,this.phone,this.address,this.email);




}

