import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_application_1/theme/theme_colors.dart';
import 'package:flutter_application_1/constant/base_api.dart';
import 'package:flutter_application_1/pages/create.dart';
import 'package:flutter_application_1/pages/edit.dart';
class IndexPage extends StatefulWidget {
  @override
  _IndexPageState createState() => _IndexPageState();
}

class _IndexPageState extends State<IndexPage> 
{
  List users = [];
  bool isLoading = false;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    this.fetchUser();
  }
  fetchUser() async {
    setState(() {
      isLoading = true;
    });
    var url = "http://api.phanmemquocbao.com/api/Doituong/getobjectsall?tokenget=lethibaotran";
    var response = await http.get(url);
    if(response.statusCode == 200){
      var items = json.decode(response.body
      );
      setState(() {
        users = items;
        isLoading = false;
      });
    }else{
      setState(() {
        users = [];
        isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Quản lý cửa hàng vật dụng Phạm Tri Thức"),
        backgroundColor: Color.fromARGB(255, 29, 142, 115),
        actions: <Widget>[
          FlatButton(onPressed: (){
            Navigator.push(context, MaterialPageRoute(builder: (context) => CreateUser()));
          }, child: Icon(Icons.add,color: white,))
        ],
      ),
      body: getBody(),
    );
  }
  Widget getBody(){
    if(isLoading || users.length == 0){
      return Center(child: CircularProgressIndicator(
        valueColor: new AlwaysStoppedAnimation<Color>(primary)
      ));
    }
    return ListView.builder(
      itemCount: users.length,
      itemBuilder: (context,index){
      return cardItem(users[index]);
    });
  }
  Widget cardItem(item){
    var id = item['Id'];
    var fullname = item['p0'];
    var email = item['p1'];
    var phone = item['p2'];
    var address = item['p3'];
    var school = item['p4'];
    var major = item['p6'];
    var year = item['p5'];


    return Card(
          child: Slidable(
          actionPane: SlidableDrawerActionPane(),
          actionExtentRatio: 0.25,
          child: Container(
            color: Colors.white,
            child: ListTile(
              title: Text(fullname??'error'),
              subtitle: Text(email??'error'),
            ),
          ),
          actions: <Widget>[
            IconSlideAction(
              caption: 'Edit',
              color:  Color.fromARGB(255, 29, 142, 115),
              icon: Icons.edit,
              onTap: () => editUser(item),
            ),
          ],
          secondaryActions: <Widget>[
            
            IconSlideAction(
              caption: 'Delete',
              color: Colors.red,
              icon: Icons.delete,
              onTap: () => showDeleteAlert(context,item),
            ),
          ],
        ),
    );
  }
  editUser(item){
    var Id = item['Id'].toString();
    var phone = item['p2'].toString();
    var address = item['p5'].toString();
    var school = item['p3'].toString();
    var major = item['p4'].toString();
    var year = item['p6'].toString();
    var fullname = item['p0'].toString();
    var email = item['p1'].toString();
    Navigator.push(context, MaterialPageRoute(builder: (context) => EditUser(id: Id,fullName: fullname,email: email,phone: phone,address:address,school: school,year: year,major:major,)));
  }



  deleteUser(id) async {
    print(id);
    var url = "http://api.phanmemquocbao.com/api/Doituong/deleteObject?id=$id&tokende=lethibaotran";
    var response = await http.get(url);
    if(response.statusCode == 200){
      this.fetchUser();
    } 
  }
  showDeleteAlert(BuildContext context,item) {

  // set up the buttons
    Widget noButton = FlatButton(
      child: Text("No",style: TextStyle(color: primary),),
      onPressed:  () {
        Navigator.pop(context);
      },
    );

    Widget yesButton = FlatButton(
      child: Text("Yes",style: TextStyle(color: primary)),
      onPressed:  () {
        Navigator.pop(context);
       
        deleteUser(item['Id']);
      },
    );

    // set up the AlertDialog
    AlertDialog alert = AlertDialog(
      title: Text("Message"),
      content: Text("Would you like to delete this user?"),
      actions: [
        noButton,
        yesButton,
      ],
    );
    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }
}