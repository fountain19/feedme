





import 'dart:developer';

import 'package:feedme/provider/counter.dart';
import 'package:feedme/provider/endPrice.dart';
import 'package:feedme/provider/marketInfo.dart';
import 'package:feedme/provider/productInfo.dart';
import 'package:feedme/provider/totalPrice.dart';
import 'package:feedme/screen/homepage.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:geolocator/geolocator.dart';
import 'package:provider/provider.dart';
import 'screen/skipScreen.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  runApp(MyApp());
}


class MyApp extends StatefulWidget {

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  Future<Position> _determinePosition() async {
    bool serviceEnabled;
    LocationPermission permission;

    // Test if location services are enabled.
    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      return Future.error('Location services are disabled.');
    }

    permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return Future.error('Location permissions are denied');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      // Permissions are denied forever, handle appropriately.
      return Future.error(
          'Location permissions are permanently denied, we cannot request permissions.');
    }

    // When we reach here, permissions are granted and we can
    // continue accessing the position of the device.
    return await Geolocator.getCurrentPosition();
  }


  @override
  void initState() {
    _determinePosition();
  }

  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
    ]);
    return  MultiProvider(
      providers: [
        ChangeNotifierProvider<EndPrice>(create: (_)=>EndPrice()),
        ChangeNotifierProvider<ItemCount>(create: (_)=>ItemCount()),
        ChangeNotifierProvider<MarketInfo>(create: (_)=>MarketInfo()),
        ChangeNotifierProvider<ProductInfo>(create: (_)=>ProductInfo()),
        ChangeNotifierProvider<TotalPrice>(create: (_)=>TotalPrice()),

      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          primarySwatch: Colors.blueGrey,
        ),

        home: StreamBuilder(
          stream: FirebaseAuth.instance.authStateChanges(),
          builder: (context,snapshot){
            if(snapshot.hasData)
              {
                return HomePage();
              }else{
              return SkipScreen();
            }
          },
        ),
        debugShowCheckedModeBanner: false,
      ),
    );
  }
}

