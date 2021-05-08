





import 'package:feedme/provider/counter.dart';
import 'package:feedme/provider/marketInfo.dart';
import 'package:feedme/provider/productInfo.dart';
import 'package:feedme/provider/totalPrice.dart';
import 'package:feedme/screen/homepage.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'screen/skipScreen.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  runApp(MyApp());
}


class MyApp extends StatelessWidget {

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
    ]);
    return  MultiProvider(
      providers: [
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

