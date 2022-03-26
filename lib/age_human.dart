import 'package:catage/View_home.dart';
import 'package:catage/age.dart';
import 'package:catage/generated/l10n.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:google_fonts/google_fonts.dart';

class Age_Human extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      localizationsDelegates: [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
        S.delegate,
      ],
      supportedLocales: S.delegate.supportedLocales,
      theme: ThemeData(
        primaryColor: Colors.grey,
        cardColor: Colors.white,
        appBarTheme: AppBarTheme(
          color: HexColor("08CAF7"),
          centerTitle: true,
        ),
        bottomAppBarColor: HexColor("08CAF7"),
        floatingActionButtonTheme:
            FloatingActionButtonThemeData(backgroundColor: Colors.yellow[800]),
      ),
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
            centerTitle: true,
            title: Text(S.of(context).home_text_fourtyfive,
                style: GoogleFonts.aBeeZee(
                  textStyle: TextStyle(
                    fontWeight: FontWeight.bold,
                    color: Colors.white,
                    fontSize: 17.sp,
                  ),
                ))),
        body: DropDown(),
      ),
    );
  }
}

class DropDown extends StatefulWidget {
  @override
  DropDownWidget createState() => DropDownWidget();
}

class DropDownWidget extends State {
  String dropdownValue = 'Selecciona';

  String holder = '';

  List<String> actorsName = [
    '1 mes',
    '2 - 3 meses',
    '4 meses',
    '6 meses',
    '7 meses',
    '12 meses',
    '18 meses',
    '2 años',
    '3 años',
    '4 años',
    '5 años',
    '6 años',
    '7 años',
    '8 años',
    '9 años',
    '10 años',
    '11 años',
    '12 años',
    '13 años',
    '14 años',
    '15 años',
    '16 años',
    '17 años',
    '18 años',
    '19 años',
    '20 años',
    'Selecciona'
  ];

  void getDropDownItem() {
    setState(() {
      holder = dropdownValue;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        child: Icon(Icons.person),
      ),
      bottomNavigationBar: ClipRRect(
        borderRadius: BorderRadius.vertical(top: Radius.circular(45)),
        child: Container(
          color: Colors.black38,
          child: BottomAppBar(
            shape: CircularNotchedRectangle(),
            child: Row(
              children: [
                SizedBox(
                  width: 80,
                ),
                IconButton(
                  icon: Icon(Icons.home),
                  color: Colors.white,
                  onPressed: () {
                    Navigator.pushReplacement(
                      context,
                      new MaterialPageRoute(
                        builder: (context) => Home(),
                      ),
                    );
                  },
                ),
                SizedBox(
                  width: 20,
                ),
                /*IconButton(
                  icon: Icon(Icons.contact_phone_outlined),
                  color: Colors.white,
                  onPressed: () {},
                ),*/
                Spacer(),
                /*IconButton(
                  icon: Icon(Icons.textsms_outlined),
                  color: Colors.white,
                  onPressed: () {},
                ),*/
                SizedBox(
                  width: 20,
                ),
                IconButton(
                  icon: Icon(Icons.pets),
                  color: Colors.white,
                  onPressed: () {
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                        builder: (context) => Age(),
                      ),
                    );
                  },
                ),
                SizedBox(
                  width: 80,
                ),
              ],
            ),
          ),
        ),
      ),
      body: Center(
        child: Column(children: <Widget>[
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.08,
                  ),
                  Center(
                    child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: 40.0),
                      child: Text(
                        S.of(context).home_text_fourtysix,
                        style: GoogleFonts.aBeeZee(
                          textStyle: TextStyle(
                            color: Colors.black,
                            fontSize: 18.sp,
                          ),
                        ),
                        textAlign: TextAlign.center,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
          SizedBox(height: 30.0),
          ListTile(
            title: Row(
              children: <Widget>[
                Expanded(
                    child: Text(
                  S.of(context).home_text_fourtyseven,
                  textAlign: TextAlign.center,
                  style: GoogleFonts.aBeeZee(
                    textStyle: TextStyle(
                      color: HexColor("08CAF7"),
                      fontSize: 19.sp,
                    ),
                  ),
                )),
                Expanded(
                  child: DropdownButton<String>(
                    value: dropdownValue,
                    icon: Icon(Icons.arrow_drop_down),
                    iconSize: 24,
                    elevation: 16,
                    style: GoogleFonts.aBeeZee(
                      textStyle: TextStyle(
                        color: Colors.black,
                        fontSize: 18.sp,
                      ),
                    ),
                    underline: Container(
                      height: 2,
                      color: HexColor("08CAF7"),
                    ),
                    onChanged: (String data) {
                      setState(() {
                        dropdownValue = data;
                      });
                    },
                    items: actorsName
                        .map<DropdownMenuItem<String>>((String value) {
                      return DropdownMenuItem<String>(
                        value: value,
                        child: Text(value == "1 mes"
                            ? S.of(context).home_text_fourtynine
                            : value == "2 - 3 meses"
                                ? S.of(context).home_text_fifty
                                : value == "4 meses"
                                    ? S.of(context).home_text_fiftyone
                                    : value == "6 meses"
                                        ? S.of(context).home_text_fiftytwo
                                        : value == "7 meses"
                                            ? S.of(context).home_text_fiftythree
                                            : value == "12 meses"
                                                ? S
                                                    .of(context)
                                                    .home_text_fiftyfour
                                                : value == "18 meses"
                                                    ? S
                                                        .of(context)
                                                        .home_text_fiftyfive
                                                    : value == "2 años"
                                                        ? S
                                                            .of(context)
                                                            .home_text_fiftysix
                                                        : value == "3 años"
                                                            ? S
                                                                .of(context)
                                                                .home_text_fiftyseven
                                                            : value == "4 años"
                                                                ? S
                                                                    .of(context)
                                                                    .home_text_fiftyeight
                                                                : value ==
                                                                        "5 años"
                                                                    ? S
                                                                        .of(
                                                                            context)
                                                                        .home_text_fiftynine
                                                                    : value ==
                                                                            "6 años"
                                                                        ? S
                                                                            .of(
                                                                                context)
                                                                            .home_text_seventy
                                                                        : value ==
                                                                                "7 años"
                                                                            ? S.of(context).home_text_seventyone
                                                                            : value == "8 años"
                                                                                ? S.of(context).home_text_seventytwo
                                                                                : value == "9 años"
                                                                                    ? S.of(context).home_text_seventythree
                                                                                    : value == "10 años"
                                                                                        ? S.of(context).home_text_seventyfour
                                                                                        : value == "11 años"
                                                                                            ? S.of(context).home_text_seventyfive
                                                                                            : value == "12 años"
                                                                                                ? S.of(context).home_text_seventysix
                                                                                                : value == "13 años"
                                                                                                    ? S.of(context).home_text_seventyseven
                                                                                                    : value == "14 años"
                                                                                                        ? S.of(context).home_text_seventyeight
                                                                                                        : value == "15 años"
                                                                                                            ? S.of(context).home_text_seventynine
                                                                                                            : value == "16 años"
                                                                                                                ? S.of(context).home_text_ninety
                                                                                                                : value == "17 años"
                                                                                                                    ? S.of(context).home_text_ninetyone
                                                                                                                    : value == "18 años"
                                                                                                                        ? S.of(context).home_text_ninetytwo
                                                                                                                        : value == "19 años"
                                                                                                                            ? S.of(context).home_text_ninetythree
                                                                                                                            : value == "20 años"
                                                                                                                                ? S.of(context).home_text_ninetyfour
                                                                                                                                : value == "Selecciona"
                                                                                                                                    ? S.of(context).home_text_ninetyfive
                                                                                                                                    : ""),
                      );
                    }).toList(),
                  ),
                ),
              ],
            ),
          ),
          Padding(
              padding: EdgeInsets.only(top: 30, bottom: 30),
              child:
                  //Printing Item on Text Widget
                  Text(
                holder == "1 mes"
                    ? S.of(context).home_text_onehundredone
                    : holder == "2 - 3 meses"
                        ? S.of(context).home_text_onehundredtwo
                        : holder == "4 meses"
                            ? S.of(context).home_text_onehundredthree
                            : holder == "6 meses"
                                ? S.of(context).home_text_onehundredfour
                                : holder == "7 meses"
                                    ? S.of(context).home_text_onehundredfive
                                    : holder == "12 meses"
                                        ? S.of(context).home_text_onehundredsix
                                        : holder == "18 meses"
                                            ? S
                                                .of(context)
                                                .home_text_onehundredseven
                                            : holder == "2 años"
                                                ? S
                                                    .of(context)
                                                    .home_text_onehundredeight
                                                : holder == "3 años"
                                                    ? S
                                                        .of(context)
                                                        .home_text_onehundrednine
                                                    : holder == "4 años"
                                                        ? S
                                                            .of(context)
                                                            .home_text_onehundredten
                                                        : holder == "5 años"
                                                            ? S
                                                                .of(context)
                                                                .home_text_onehundredeeleven
                                                            : holder == "6 años"
                                                                ? S
                                                                    .of(context)
                                                                    .home_text_onehundredtwuelve
                                                                : holder ==
                                                                        "7 años"
                                                                    ? S
                                                                        .of(
                                                                            context)
                                                                        .home_text_onehundredthirteen
                                                                    : holder ==
                                                                            "8 años"
                                                                        ? S
                                                                            .of(
                                                                                context)
                                                                            .home_text_onehundredfourteen
                                                                        : holder ==
                                                                                "9 años"
                                                                            ? S.of(context).home_text_onehundredfiveteen
                                                                            : holder == "10 años"
                                                                                ? S.of(context).home_text_onehundredsixteen
                                                                                : holder == "11 años"
                                                                                    ? S.of(context).home_text_onehundredseventeen
                                                                                    : holder == "12 años"
                                                                                        ? S.of(context).home_text_onehundredeighteteen
                                                                                        : holder == "13 años"
                                                                                            ? S.of(context).home_text_onehundrednineteen
                                                                                            : holder == "14 años"
                                                                                                ? S.of(context).home_text_onehundredthirty
                                                                                                : holder == "15 años"
                                                                                                    ? S.of(context).home_text_onehundredthirtyone
                                                                                                    : holder == "16 años"
                                                                                                        ? S.of(context).home_text_onehundredthirthytwo
                                                                                                        : holder == "17 años"
                                                                                                            ? S.of(context).home_text_onehundredthirtythree
                                                                                                            : holder == "18 años"
                                                                                                                ? S.of(context).home_text_onehundredthirtyfour
                                                                                                                : holder == "19 años"
                                                                                                                    ? S.of(context).home_text_onehundredthirtyfive
                                                                                                                    : holder == "20 años"
                                                                                                                        ? S.of(context).home_text_onehundredthirtysix
                                                                                                                        : holder == 'Selecciona'
                                                                                                                            ? S.of(context).home_text_onehundredthirtyseven
                                                                                                                            : " ",
                style: GoogleFonts.aBeeZee(
                  textStyle: TextStyle(
                    color: Colors.black,
                    fontSize: 20.sp,
                  ),
                ),
              )),
          RaisedButton(
            child: Text(
              S.of(context).home_text_fourtyeight,
              style: GoogleFonts.aBeeZee(
                textStyle: TextStyle(
                  color: Colors.white,
                  fontSize: 18.sp,
                ),
              ),
            ),
            onPressed: getDropDownItem,
            color: Colors.yellow[800],
            textColor: Colors.white,
            padding: EdgeInsets.fromLTRB(12, 12, 12, 12),
          ),
        ]),
      ),
    );
  }
}
