import 'dart:math';
import 'dart:ui';
import 'package:catage/generated/l10n.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class Header extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    MediaQueryData queryData;
    queryData = MediaQuery.of(context);
    return SliverList(
        delegate: SliverChildListDelegate(
      [
        Stack(
          children: [
            Column(
              children: [
                Container(
                  padding: EdgeInsets.symmetric(horizontal: 15),
                  height: 25.0.h,
                  decoration: BoxDecoration(
                      color: HexColor("08CAF7"),
                      borderRadius: BorderRadius.vertical(
                        bottom: Radius.circular(45),
                      ),
                      boxShadow: [BoxShadow(blurRadius: 2)]),
                  child: Container(
                    child: Column(
                      children: [
                        SizedBox(
                          height: 20,
                        ),
                        Row(
                          children: [
                            CircleAvatar(
                              backgroundColor: Colors.white70,
                              radius: 35,
                              child: CircleAvatar(
                                radius: 30,
                                child: CircleAvatar(
                                  backgroundImage:
                                      AssetImage('images/logo.png'),
                                  radius: 30,
                                ),
                              ),
                            ),
                            SizedBox(
                              width: 5.w,
                            ),
                            Column(
                              children: [
                                Text(
                                  S.of(context).home_text_fourtyone ?? "",
                                  style: GoogleFonts.aBeeZee(
                                    textStyle: TextStyle(
                                      color: Colors.white,
                                      fontSize: 20.sp,
                                    ),
                                  ),
                                ),
                                Container(
                                  padding: EdgeInsets.all(4),
                                  child: Text(""),
                                ),
                                /*Container(
                                      padding: EdgeInsets.all(4),
                                      decoration: BoxDecoration(
                                          borderRadius:
                                          BorderRadius.circular(20),
                                          color: Colors.black54),
                                      child: Text("detailsUser.email" ?? "",
                                          style: GoogleFonts.openSans(
                                            textStyle: TextStyle(
                                              color: Colors.white,
                                              fontSize:
                                              queryData.size.width / 30,
                                            ),
                                          )),
                                    ),*/
                              ],
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
              ],
            ),
            /*Positioned(
              bottom: 0,
              child: Container(
                height: 50,
                width: size.width,
                child: Card(
                  margin: EdgeInsets.symmetric(horizontal: 50),
                  elevation: 3,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15)),
                  child: TextFormField(
                    decoration: InputDecoration(
                      border: InputBorder.none,
                      labelText: "What does your belly want to eat?",
                      suffixIcon: Icon(Icons.search),
                      contentPadding: EdgeInsets.only(left: 20)
                    ),
                  ),
                ),
              ),
            )*/
          ],
        ),
      ],
    ));
  }
}
