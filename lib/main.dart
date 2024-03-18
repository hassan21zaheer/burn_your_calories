import 'package:burnyourcalories/model/aliments.dart';
import 'package:burnyourcalories/widgets/aliment.dart';
import 'package:burnyourcalories/widgets/card_item.dart';
import 'package:burnyourcalories/widgets/page.dart' as CustomPage;
import 'package:burnyourcalories/widgets/pager.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'BurnYourCalories',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: HomePage(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class HomePage extends StatelessWidget {
  HomePage() {
    SystemChrome.setPreferredOrientations(
        <DeviceOrientation>[DeviceOrientation.portraitUp]);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: MenuPager(
          children: Aliments.aliments
              .map(
                (aliment) => CustomPage.Page(
                      title: "Burn Your Calories",
                      background: aliment.background,
                      icon: aliment.bottomImage,
                      child: CardItem(
                        child: AlimentWidget(
                          aliment: aliment,
                          theme: aliment.background,
                        ),
                      ),
                    ),
              )
              .toList(),
        ),
      ),
    );
  }
}
