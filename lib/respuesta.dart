import 'package:catage/View_home.dart';
import 'package:catage/age.dart';
import 'package:catage/generated/l10n.dart';
import 'package:catage/main.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class Respuesta extends StatefulWidget {
  int id;
  Respuesta({this.id});

  @override
  _RespuestaState createState() => _RespuestaState();
}

class _RespuestaState extends State<Respuesta> {
  @override
  Widget build(BuildContext context) {
    return ResponsiveSizer(
      builder: (context, orientation, screenType) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          home: Scaffold(
              backgroundColor: HexColor("08CAF7"),
              body: Center(
                  child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    height: Adaptive.h(10.0),
                  ),
                  Container(
                    //height: 261.0,
                    height: Adaptive.h(30.0),
                    width: 500.0,
                    child: Card(
                      color: Colors.grey[300],
                      margin: new EdgeInsets.only(
                          left: 20.0, right: 20.0, top: 8.0, bottom: 5.0),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10.0)),
                      child: new Padding(
                        padding: new EdgeInsets.all(25.0),
                        child: new Column(
                          children: <Widget>[
                            new Container(
                              child: Text(
                                widget.id == 0
                                    ? S.of(context).home_text_seventeen
                                    : widget.id == 1
                                        ? S.of(context).home_text_eighteen
                                        : widget.id == 2
                                            ? S.of(context).home_text_nineteen
                                            : widget.id == 3
                                                ? S.of(context).home_text_thirty
                                                : widget.id == 4
                                                    ? S.of(context).home_text_thirtyone
                                                    : widget.id == 5
                                                        ? S.of(context).home_text_thirtytwo
                                                        : widget.id == 6
                                                            ? S.of(context).home_text_thirtythree
                                                            : widget.id == 7
                                                                ? S.of(context).home_text_thirtyfour
                                                                : widget.id == 8
                                                                    ? S.of(context).home_text_thirtyfive
                                                                    : widget.id ==
                                                                            9
                                                                        ? S.of(context).home_text_thirtysix
                                                                        : widget.id ==
                                                                                10
                                                                            ? S.of(context).home_text_thirtyseven
                                                                            : widget.id == 11
                                                                                ? S.of(context).home_text_thirtyeight
                                                                                : S.of(context).home_text_thirtyeight,
                                style: GoogleFonts.aBeeZee(
                                  textStyle: TextStyle(
                                    fontWeight: FontWeight.bold,
                                    color: Colors.black,
                                    fontSize: 18.sp,
                                  ),
                                ),
                                textAlign: TextAlign.center,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                  SvgPicture.asset(
                    'images/banner-1.svg',
                    height: Adaptive.h(40.0),
                    width: Adaptive.w(40.0),
                  ),
                  RaisedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (BuildContext context) => Age(),
                        ),
                      );
                    },
                    child: Text(S.of(context).home_text_thirtynine,
                        style: GoogleFonts.aBeeZee(
                          textStyle: TextStyle(
                            color: Colors.white,
                            fontSize: 18.sp,
                          ),
                        )),
                    color: Colors.deepOrange,
                    textColor: Colors.white,
                  )
                ],
              ))),
        );
      },
    );
  }
}
