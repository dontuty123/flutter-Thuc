import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:flutter_application_1/constant/base_api.dart';
import 'package:flutter_application_1/constant/util.dart';
import 'package:flutter_application_1/pages/index.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_application_1/theme/theme_colors.dart';

class EditUser extends StatefulWidget {
  String id;
  String fullName;
  String email;
  String phone;
  String address;
  String school;
  String major;
  String year;
  EditUser({required this.id, required this.fullName, required this.email, required this.phone, required this.address, required this.school, required this.year, required this.major});

  @override
  _EditUserState createState() => _EditUserState();
}

class _EditUserState extends State<EditUser> {
  final TextEditingController _controllerEmail = new TextEditingController();
  final TextEditingController _controllerFullName = new TextEditingController();
  final TextEditingController _controllerPhone = new TextEditingController();
  final TextEditingController _controllerAddress = new TextEditingController();
  final TextEditingController _controllerSchool = new TextEditingController();
  final TextEditingController _controllerMajor = new TextEditingController();
  final TextEditingController _controllerYear = new TextEditingController();
  String id = '';
  @override
  void initState() {
    // TODO: implement initState
    super.initState();


    setState(() {
      id = widget.id;
     _controllerEmail.text = widget.email;
     _controllerFullName.text = widget.fullName;
     _controllerPhone.text = widget.phone;
     _controllerAddress.text = widget.address;
     _controllerSchool.text = widget.school;
     _controllerMajor.text = widget.major;
     _controllerYear.text = widget.year;
    });


  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Chỉnh sửa thông tin vật dụng"),
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
          controller: _controllerFullName,
          cursorColor: primary,
          decoration: InputDecoration(
            hintText: "Tên vật dụng",
          ),
        ),
        SizedBox(height: 30,),
        TextField(
          controller: _controllerEmail,
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
          controller: _controllerAddress,
          cursorColor: primary,
          decoration: InputDecoration(
            hintText: "Ngày nhập",
          ),
        ),
         SizedBox(height: 30,),
        TextField(
          controller: _controllerSchool,
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
          controller: _controllerMajor,
          cursorColor: primary,
          decoration: InputDecoration(
            hintText: "Mô tả chi tiết",
          ),
        ),
        SizedBox(height: 40,),
        FlatButton(
        color: primary,
        onPressed: (){
          editUser();
        }, child: Text("Done",style: TextStyle(color: white),))
      ],
    );
  }
  editUser() async {

    var fullName = _controllerFullName.text;
    var email = _controllerEmail.text;
    var phone = _controllerPhone.text;
    var address = _controllerAddress.text;
    var school = _controllerSchool.text;
    var year = _controllerYear.text;
    var major = _controllerMajor.text;
    if(fullName.isNotEmpty && email.isNotEmpty){
      var url = "http://api.phanmemquocbao.com/api/Doituong/updateObjects?id=$id&p0=$fullName&p1=$email&p2=$phone&p3=$school&p4=$major&p5=$address&p6=$year&tokenup=lethibaotran";
  
      var response = await http.get(url);
      if(response.statusCode == 200){
        //trở về lại trang danh sách
         Navigator.push(context, MaterialPageRoute(builder: (context) => IndexPage()));
      }else {
         var messageError = "Can not update this user!!";
        showMessage(context,messageError);
      }
    }
  }
}