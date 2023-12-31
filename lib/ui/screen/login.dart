import 'dart:async';

import 'package:adverts247Pass/services/video_service.dart';
import 'package:adverts247Pass/themes.dart';

import 'package:adverts247Pass/services/websocket.dart';
import 'package:adverts247Pass/widget/button.dart';
import 'package:adverts247Pass/widget/input_textform.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  TextEditingController? loginEmail;
  TextEditingController? password;
  @override
  void initState() {
    loginEmail = TextEditingController();
    password = TextEditingController();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    print(MediaQuery.of(context).size.height);
    return Scaffold(
      body: SafeArea(
        child: Container(
          color: Colors.black,
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          child: Center(
            child: Container(
              height: MediaQuery.of(context).size.height > 450
                  ? MediaQuery.of(context).size.height * .7
                  : MediaQuery.of(context).size.height,
              width: MediaQuery.of(context).size.width * .7,
              child: Stack(
                children: [
                  Container(
                    height: MediaQuery.of(context).size.height > 450
                        ? MediaQuery.of(context).size.height * .72
                        : MediaQuery.of(context).size.height,
                    width: MediaQuery.of(context).size.width * .7,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        SvgPicture.asset(
                          'assets/login/top-illustration.svg',
                        ),
                      ],
                    ),
                  ),
                  Container(
                    height: MediaQuery.of(context).size.height > 450
                        ? MediaQuery.of(context).size.height * .8
                        : MediaQuery.of(context).size.height,
                    width: MediaQuery.of(context).size.width * .7,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SvgPicture.asset(
                            'assets/login/bottom-illustration.svg'),
                      ],
                    ),
                  ),
                  Center(
                    child: Container(
                      height: MediaQuery.of(context).size.height * .8,
                      width: MediaQuery.of(context).size.width * .58,
                      decoration: BoxDecoration(
                        color: Colors.black,
                        borderRadius: BorderRadius.circular(5),
                        // boxShadow: [
                        //   BoxShadow(
                        //     color:
                        //         Colors.grey.withOpacity(0.08), // Shadow color
                        //     spreadRadius: 5, // How much the shadow spreads
                        //     blurRadius: 9, // How blurry the shadow is
                        //     offset: Offset(0, 2), // Offset of the shadow
                        //   ),
                        // ],
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(30.0),
                        child: SingleChildScrollView(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Image.asset(
                                'assets/images/Group (6).png',
                                height: 80,
                                width: 350,
                              ),
                              SizedBox(
                                height: 17,
                              ),
                              Text(
                                'Driver Sign-In',
                                style: TextStyles().whiteTextStyle().copyWith(
                                    fontSize: 23, fontWeight: FontWeight.w800),
                              ),
                              // SizedBox(
                              //   height: 13,
                              // ),
                              // Text(
                              //   'Login your details',
                              //   style: TextStyles().greyTextStyle400().copyWith(
                              //         fontSize: 16,
                              //       ),
                              // ),
                              SizedBox(
                                height: 50,
                              ),
                              OutlineInput(
                                labelText: 'Email',
                                controller: loginEmail,
                              ),
                              SizedBox(
                                height: 23,
                              ),
                              OutlineInput(
                                labelText: 'Password',
                                controller: password,
                              ),
                              SizedBox(
                                height: 23,
                              ),
                              MyButton(
                                text: 'Login',
                                onPressed: () {
                                  var body = {
                                    'email': loginEmail?.text,
                                    'password': password?.text

                                    // 'email': 'tested@test.com',
                                    // 'password': '12345678'
                                  };
                                  print(body);
                                  VideoService().login(context, body);

                                  //  AppWebsocketService().sendDriverPingAndListenForPong( 1, 3.222, 4.66666);

                                  // Navigator.push(
                                  //     context,
                                  //     MaterialPageRoute(
                                  //         builder: (context) =>
                                  //             VideoPlayerApp()));
                                },
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
