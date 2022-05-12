import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_application_1/constant/base_api.dart';
import 'package:flutter_application_1/theme/theme_colors.dart';
import 'package:flutter_application_1/pages/index.dart';

import '../constant/util.dart';
class CreateUser extends StatefulWidget {
  @override
  _CreateUserState createState() => _CreateUserState();
}

class _CreateUserState extends State<CreateUser> {
  final TextEditingController _controllerId = new TextEditingController();
  final TextEditingController _controllerEmail = new TextEditingController();
  final TextEditingController _controllerFullName = new TextEditingController();
  final TextEditingController _controllerPhone = new TextEditingController();
  final TextEditingController _controllerAddress = new TextEditingController();
  final TextEditingController _controllerSchool = new TextEditingController();
  final TextEditingController _controllerMajor = new TextEditingController();
  final TextEditingController _controllerYear = new TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Tạo vật dụng"),
        backgroundColor: Color.fromARGB(255, 29, 142, 115),
      ),
      body: getBody(),
    );
  }
  Widget getBody(){
    return ListView(
      padding: EdgeInsets.all(30),
      children: <Widget>[
        SizedBox(height: 30,),
        TextField(
          controller: _controllerId,
          cursorColor: primary,
          decoration: InputDecoration(
            hintText: "ID",
          ),
        ),
        
        SizedBox(height: 30,),
        TextField(
          controller: _controllerEmail,
          cursorColor: primary,
          decoration: InputDecoration(
            hintText: "Tên vật dụng",
          ),
        ),
        SizedBox(height: 30,),
        TextField(
          controller: _controllerFullName,
          cursorColor: primary,
          decoration: InputDecoration(
            hintText: "Hạn sử dụng",
          ),
        ),
        SizedBox(height: 30,),
        TextField(
          controller: _controllerPhone,
          cursorColor: primary,
          decoration: InputDecoration(
            hintText: "Số lượng",
          ),
        ),
        SizedBox(height: 30,),
        TextField(
          controller: _controllerSchool,
          cursorColor: primary,
          decoration: InputDecoration(
            hintText: "Ngày nhập",
          ),
        ),
        SizedBox(height: 30,),
        TextField(
          controller: _controllerMajor,
          cursorColor: primary,
          decoration: InputDecoration(
            hintText: "Giá nhập",
          ),
        ),
        SizedBox(height: 30,),
        TextField(
          controller: _controllerYear,
          cursorColor: primary,
          decoration: InputDecoration(
            hintText: "Giá bán",
          ),
        ),
        SizedBox(height: 30,),
        TextField(
          controller: _controllerAddress,
          cursorColor: primary,
          decoration: InputDecoration(
            hintText: "Mô tả chi tiết",
          ),
        ),
        
        SizedBox(height: 40,),
        FlatButton(
        color: primary,
        onPressed: (){
          createNewUser();
        }, child: Text("Done",style: TextStyle(color: white),))
      ],
    );
  }
  createNewUser() async {
    var Id = _controllerId.text;
    var id =int.parse(Id);
    var fullName = _controllerFullName.text;
    var email = _controllerEmail.text;
    var phone = _controllerPhone.text;
    var school = _controllerSchool.text;
    var major = _controllerMajor.text;
    var address = _controllerAddress.text;
    var year = _controllerYear.text;
    print(id);
    print(fullName);
    print(email);
   

    if(fullName.isNotEmpty && email.isNotEmpty){
      var url = 'http://api.phanmemquocbao.com/api/Doituong/InsertObjects?p0=$fullName&id=$id&p1=$email&p2=$phone&p3=$school&p4=$major&p5=$address&p6=$year&tokenin=lethibaotran';
      var response = await http.get(url);
      if(response.statusCode == 200){
       // tro ve lại trang danh sách
        Navigator.push(context, MaterialPageRoute(builder: (context) => IndexPage()));
        setState(() {
          _controllerFullName.text = "";
          _controllerEmail.text = "";
          _controllerSchool.text = "";
          _controllerMajor.text = "";
          _controllerAddress.text = "";
          _controllerYear.text = "";
          _controllerId.text = "";
           _controllerPhone.text = "";
          
        });
      }else {
        var messageError = "Can not create new user!!";
        showMessage(context,messageError);
      }

    }
  }
}