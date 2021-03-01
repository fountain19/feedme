import 'package:feedme/widget/button.dart';
import 'package:feedme/widget/textformField.dart';
import 'package:flutter/material.dart';

import 'homepage.dart';

class Profile extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final TextEditingController _email = TextEditingController();

    final TextEditingController _password = TextEditingController();

    final TextEditingController _name = TextEditingController();

    final TextEditingController _number = TextEditingController();

    final TextEditingController _address = TextEditingController();

    final GlobalKey<ScaffoldState> scaffold = GlobalKey<ScaffoldState>();
    return Scaffold(
      backgroundColor:  Theme.of(context).accentColor,
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          'Profile page',style: TextStyle(
            color: Colors.white,fontSize: 20
        ),
        ),
        leading: GestureDetector(
          child: Icon(Icons.keyboard_arrow_left,color: Colors.white,),
          onTap: (){
            Navigator.pushAndRemoveUntil(context, MaterialPageRoute(builder: (ctx){
              return HomePage();
            }), (route) => false);
          },
        ),
        backgroundColor:Color(0xff193044),
        elevation: 0.0,
        actions: [
          Padding(
            padding: const EdgeInsets.all(15.0),
            child: GestureDetector(
              onTap: (){},
              child: Text('Edit',style: TextStyle(
                color: Colors.white,fontSize: 20
              ),),
            ),
          )
        ],
      ),
      body: Container(
height: double.infinity,width: double.infinity,
        child: SingleChildScrollView(
          child: Column(
            children: [
              Stack(
                children: [
                  Container(
                    height: 200,
                    color: Color(0xff193044),
                  ),
                  Align(
                    alignment: Alignment.bottomCenter,
                    child: Padding(
                      padding:  EdgeInsets.only(top: 80),
                      child: Stack(
                        children: [
                          CircleAvatar(
                            radius: 75,backgroundColor: Colors.white,
                            child: CircleAvatar(
                              radius: 70,
                              backgroundImage: AssetImage('images/man.jpg'),
                            ),
                          ),
                          Positioned(
                            right: 0.0,bottom: 0.0,
                            child: CircleAvatar(
                              radius: 20,
                              child: Icon(Icons.edit),
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(
                height: 15,
              ),
              TextFormFd(
                title:'Full name',
                controller:_name ,),
              SizedBox(
                height: 15,
              ),
              TextFormFd(
                title:'Email',
                controller:_email ,),
              SizedBox(
                height: 15,
              ),
              TextFormFd(
                input: TextInputType.number,
                title:'Phone number',
                controller:_number ,),
              SizedBox(
                height: 15,
              ),
              TextFormFd(
                title:'Address',
                controller:_address ,),
              SizedBox(
                height: 15,
              ),
              Button(
                title: 'Update'
              )
            ],
          ),
        ),
      ),
    );
  }
}
