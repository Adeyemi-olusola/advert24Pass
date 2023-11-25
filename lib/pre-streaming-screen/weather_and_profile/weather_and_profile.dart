import 'dart:async';

import 'package:adverts247Pass/services/video_service.dart';
import 'package:adverts247Pass/state/location_weather_state.dart';
import 'package:adverts247Pass/state/user_state.dart';
import 'package:adverts247Pass/themes.dart';
import 'package:adverts247Pass/ui/screen/waiting_Page.dart';
import 'package:adverts247Pass/widget/loader.dart';
import 'package:flutter/material.dart ';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';
import 'package:get/get.dart';

class ProfileWeatherView extends StatefulWidget {
  const ProfileWeatherView({super.key});

  @override
  State<ProfileWeatherView> createState() => _ProfileWeatherViewState();
}

class _ProfileWeatherViewState extends State<ProfileWeatherView> {
  bool? isLoading = true;

  Map<String, dynamic>? walletDetail;

  var weatherApiResult;
  Timer? _timer;
  var showWeather = true;
  @override
  void initState() {
    getWalletBalance();
    super.initState();
    _timer = Timer.periodic(Duration(seconds: 5), (timer) {
      setState(() {
        showWeather = !showWeather;
      });
    });

    Future.delayed(Duration(seconds: 8), () {
      Get.to(WaitingPage(),
        transition: Transition.fadeIn,
        curve: Curves.easeIn,
        duration: Duration(seconds: 1), 
      
      
      );
    });
  }

  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  getWalletBalance() async {
    //  VideoService().getWallet(context);

    setState(() {
      isLoading = true;
    });
    walletDetail =
        await Provider.of<UserState>(context, listen: false).userDetails;
    print(walletDetail);

    // get weather from state
    weatherApiResult =
        await Provider.of<WeatherLocationState>(context, listen: false)
            .weatherApiResult;
    print(weatherApiResult);

    setState(() {
      isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    var screenHeight = MediaQuery.of(context).size.height;

    return SafeArea(
      child: Scaffold(
          body: isLoading!
              ? Container(
                  color: Colors.black,
                  child: Center(
                    child: CircularProgressIndicator(),
                  ),
                )
              : Row(
                  children: [
                    Expanded(
                      child: Container(
                        width: MediaQuery.of(context).size.width * .5,
                        height: MediaQuery.of(context).size.height,
                        decoration: BoxDecoration(color: Colors.black),
                        child: Padding(
                          padding: EdgeInsets.symmetric(
                              vertical: screenHeight < 450
                                  ? 0
                                  : MediaQuery.of(context).size.height / 8),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: isLoading!
                                ? []
                                : showWeather
                                    ? [
                                        Padding(
                                          padding: const EdgeInsets.only(
                                              left: 30, right: 50),
                                          child: Column(
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Row(
                                                children: [
                                                  ClipRRect(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            2000),
                                                    child: Image.network(
                                                      'https://ads247-center.lazynerdstudios.com/${walletDetail!['image']}',
                                                      fit: BoxFit.cover,
                                                      height: screenHeight < 400
                                                          ? 20
                                                          : 80,
                                                      width: screenHeight < 400
                                                          ? 20
                                                          : 80,
                                                    ),
                                                  ),
                                                  SizedBox(
                                                    width: 10,
                                                  ),
                                                  Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      Text(
                                                        'You are riding with',
                                                        style: TextStyles()
                                                            .whiteTextStyle()
                                                            .copyWith(
                                                                fontSize: 15),
                                                      ),
                                                      SizedBox(
                                                        height: 5,
                                                      ),
                                                      Text(
                                                        walletDetail![
                                                            'firstname'],
                                                        style: TextStyles()
                                                            .whiteTextStyle()
                                                            .copyWith(
                                                                fontSize: 14,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w700),
                                                      ),
                                                    ],
                                                  ),
                                                ],
                                              ),
                                              SizedBox(
                                                height: screenHeight < 400
                                                    ? 10
                                                    : 24,
                                              ),

                                              Text(
                                                'About Me',
                                                style: TextStyles()
                                                    .whiteTextStyle()
                                                    .copyWith(fontSize: 15),
                                              ),
                                              SizedBox(
                                                height: screenHeight < 400
                                                    ? 10
                                                    : 15,
                                              ),
                                              leftAboutMeCard(
                                                  'Favourite Food',
                                                  walletDetail!['driver']
                                                      ['favourite_food']),
                                              SizedBox(
                                                height: 10,
                                              ),
                                              leftAboutMeCard(
                                                  'Favourite Hobby',
                                                  walletDetail!['driver']
                                                      ['favourite_hobby']),
                                              SizedBox(
                                                height: 10,
                                              ),
                                              leftAboutMeCard(
                                                  ' Ask Me',
                                                  walletDetail!['driver']
                                                      ['ask_me']),
                                              SizedBox(
                                                height: 10,
                                              ),
                                              leftAboutMeCard(
                                                  'Vacation Spot',
                                                  walletDetail!['driver']
                                                      ['vacation_spot']),
                                              // aboutMeCard()
                                            ],
                                          ),
                                        )
                                      ]
                                    : [
                                        Column(
                                          children: [
                                            Text(
                                              //'ugyg',
                                              'You are riding with',
                                              style: TextStyles()
                                                  .whiteTextStyle()
                                                  .copyWith(
                                                      fontSize:
                                                          screenHeight < 450
                                                              ? 20
                                                              : 24),
                                            ),
                                            Text(
                                              //'ugyg',
                                              '${walletDetail == null ? 'Advert24' : walletDetail!['firstname']}',
                                              style: TextStyles()
                                                  .whiteTextStyle()
                                                  .copyWith(
                                                      fontSize:
                                                          screenHeight < 450
                                                              ? 22
                                                              : 24,
                                                      fontWeight:
                                                          FontWeight.w800),
                                            ),
                                          ],
                                        ),
                                        ClipRRect(
                                          borderRadius:
                                              BorderRadius.circular(7000),
                                          child: Image.network(
                                            walletDetail == null
                                                ? ' '
                                                : 'https://ads247-center.lazynerdstudios.com/${walletDetail!['image']}',
                                            height:
                                                screenHeight < 450 ? 130 : 200,
                                            width:
                                                screenHeight < 450 ? 130 : 200,
                                            fit: BoxFit.cover,
                                          ),
                                        ),
                                        Image.asset(
                                          'assets/images/Group (6).png',
                                          height: screenHeight < 450 ? 80 : 200,
                                          width: screenHeight < 450 ? 80 : 200,
                                        ),
                                      ],
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                      child: Container(
                        width: MediaQuery.of(context).size.width * .5,
                        height: MediaQuery.of(context).size.height,
                        decoration: BoxDecoration(color: Colors.red),
                        child: AnimatedSwitcher(
                            duration: Duration(seconds: 4),
                            transitionBuilder:
                                (Widget child, Animation<double> animation) {
                              return FadeTransition(
                                opacity: animation,
                                child: child,
                              );
                            },
                            child: showWeather
                                ? weatherWidget()
                                : Padding(
                                    padding: EdgeInsets.symmetric(
                                        vertical: screenHeight < 450
                                            ? 0
                                            : MediaQuery.of(context)
                                                    .size
                                                    .height /
                                                8,
                                        horizontal:
                                            MediaQuery.of(context).size.height /
                                                35),
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          'About Me',
                                          style: TextStyles()
                                              .whiteTextStyle()
                                              .copyWith(fontSize: 24),
                                        ),
                                        SizedBox(
                                          height: 40,
                                        ),
                                        aboutMeCard(
                                            'Favourite Food',
                                            walletDetail!['driver']
                                                ['favourite_food']),
                                        SizedBox(
                                          height: 10,
                                        ),
                                        aboutMeCard(
                                            'Favourite Hobby',
                                            walletDetail!['driver']
                                                ['favourite_hobby']),
                                        SizedBox(
                                          height: 10,
                                        ),
                                        aboutMeCard(' Ask Me',
                                            walletDetail!['driver']['ask_me']),
                                        SizedBox(
                                          height: 10,
                                        ),
                                        aboutMeCard(
                                            'Vacation Spot',
                                            walletDetail!['driver']
                                                ['vacation_spot']),
                                        // aboutMeCard()
                                      ],
                                    ),
                                  )),
                      ),
                    )
                  ],
                )),
    );
  }

  aboutMeCard(String firstText, SecondText) {
    var screenHeight = MediaQuery.of(context).size.height;
    return Column(
      children: [
        Row(
          children: [
            SvgPicture.asset('assets/images/Group 48095515.svg'),
            SizedBox(
              width: 30,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  firstText,
                  style: TextStyles().whiteTextStyle().copyWith(
                      fontSize: screenHeight < 450 ? 10 : 14,
                      fontWeight: FontWeight.w400),
                ),
                Text(
                  walletDetail == null ? 'Loading...' : SecondText,
                  style: TextStyles().whiteTextStyle().copyWith(
                      fontSize: screenHeight < 400 ? 15 : 24,
                      fontWeight: FontWeight.bold),
                )
              ],
            )
          ],
        ),
        SizedBox(
          height: screenHeight < 450 ? 5 : 15,
        ),
        Divider(
          height: 0.1,
          color: Color(0xffD6DDEB),
        ),
        SizedBox(
          height: screenHeight < 450 ? 5 : 15,
        ),
      ],
    );
  }

  leftAboutMeCard(String firstText, SecondText) {
    var screenHeight = MediaQuery.of(context).size.height;
    return Column(
      children: [
        Row(
          children: [
            SvgPicture.asset('assets/images/Group 48095515.svg', height: screenHeight < 450 ? 35 :50,),
            SizedBox(
              width: 30,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  firstText,
                  style: TextStyles().whiteTextStyle().copyWith(
                      fontSize: screenHeight < 450 ? 10 : 14,
                      fontWeight: FontWeight.w400),
                ),
                Text(
                  walletDetail == null ? 'Loading...' : SecondText,
                  style: TextStyles().whiteTextStyle().copyWith(
                      fontSize: screenHeight < 450 ? 14 : 24,
                      fontWeight: FontWeight.bold),
                )
              ],
            )
          ],
        ),
        SizedBox(
          height: screenHeight < 450 ? 2 : 15,
        ),
        Divider(
          height: 0.1,
          color: Color(0xffD6DDEB),
        ),
        SizedBox(
          height: screenHeight < 450 ? 2 : 15,
        ),
      ],
    );
  }

  weatherWidget() {
    var now = DateTime.now();
    var formatter = DateFormat('EEEE, MMMM d, y');
    String formattedDate = formatter.format(now);
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Container(
        height: MediaQuery.of(context).size.height,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(formattedDate,
                style: TextStyles()
                    .whiteTextStyle()
                    .copyWith(fontSize: 22, fontWeight: FontWeight.w800)),
            SizedBox(
              height: 20,
            ),
            Row(
              children: [
                Image.asset(
                  'assets/images/brain shaped cloud.png',
                  height: 50,
                  width: 50,
                ),
                SizedBox(
                  width: 30,
                ),
                Text(
                    (weatherApiResult['main']['temp'] - 273.15)
                            .toStringAsFixed(2) +
                        '°C',
                    style: TextStyles()
                        .whiteTextStyle()
                        .copyWith(fontSize: 22, fontWeight: FontWeight.w800))
              ],
            ),
            SizedBox(
              height: 20,
            ),
            Row(
              children: [
                squareBox(
                  'HIGH/LOW',
                  (weatherApiResult['main']['temp_max'] - 273)
                          .toStringAsFixed(1) +
                      '/' +
                      (weatherApiResult['main']['temp_min'] - 273.1)
                          .toStringAsFixed(1),
                ),
                SizedBox(
                  width: 20,
                ),
                squareBox('WIND',
                    weatherApiResult['wind']['speed'].toString() + 'm/s')
              ],
            ),
            SizedBox(
              height: 20,
            ),
            Row(
              children: [
                squareBox('RAIN CHANCE', 'Rain Chance'),
                SizedBox(
                  width: 20,
                ),
                squareBox('HUMIDITY',
                    weatherApiResult['main']['humidity'].toString() + '%')
              ],
            )
          ],
        ),
      ),
    );
  }

  squareBox(String topText, bottomText) {
    var height = MediaQuery.of(context).size.height;
    return Container(
        color:
            //Colors.black,
            Color(0xff66594e),
        height: height < 500 ? 80 : 130,
        width: height < 500 ? 140 : 180,
        child: Padding(
          padding: EdgeInsets.all(height < 500 ? 10.0 : 15),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(topText,
                  style: TextStyles().whiteTextStyle().copyWith(
                      fontSize: height < 500 ? 10 : 15,
                      fontWeight: FontWeight.w600)),
              SizedBox(
                height: 10,
              ),
              Text(bottomText,
                  style: TextStyles().whiteTextStyle().copyWith(
                      fontSize: height < 500 ? 15 : 23,
                      fontWeight: FontWeight.w600))
            ],
          ),
        ));
  }
}
