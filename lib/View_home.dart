import 'dart:io';

import 'package:catage/Categories.dart';
import 'package:catage/Header.dart';
import 'package:catage/age.dart';
import 'package:catage/age_human.dart';
import 'package:catage/generated/l10n.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class Home extends StatelessWidget {
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
      debugShowCheckedModeBanner: false,
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
      home: HomeP(),
    );
  }
}

class HomeP extends StatefulWidget {
  @override
  _HomePState createState() => _HomePState();
}

const String testDevice = 'YOUR_DEVICE_ID';
const int maxFailedLoadAttempts = 3;

class _HomePState extends State<HomeP> {
  InterstitialAd _interstitialAd;
  int _numInterstitialLoadAttempts = 0;

  RewardedAd _rewardedAd;
  int _numRewardedLoadAttempts = 0;

  BannerAd _anchoredBanner;
  bool _loadingAnchoredBanner = false;
  int currentSelectedItem = 0;
  int items = 2;

  @override
  void initState() {
    super.initState();
    _createInterstitialAd();
    _createRewardedAd();
  }

  void _createInterstitialAd() {
    InterstitialAd.load(
        adUnitId: InterstitialAd.testAdUnitId,
        request: AdRequest(),
        adLoadCallback: InterstitialAdLoadCallback(
          onAdLoaded: (InterstitialAd ad) {
            print('$ad loaded');
            _interstitialAd = ad;
            _numInterstitialLoadAttempts = 0;
          },
          onAdFailedToLoad: (LoadAdError error) {
            print('InterstitialAd failed to load: $error.');
            _numInterstitialLoadAttempts += 1;
            _interstitialAd = null;
            if (_numInterstitialLoadAttempts <= maxFailedLoadAttempts) {
              _createInterstitialAd();
            }
          },
        ));
  }

  void _showInterstitialAd() {
    if (_interstitialAd == null) {
      print('Warning: attempt to show interstitial before loaded.');
      return;
    }
    _interstitialAd.fullScreenContentCallback = FullScreenContentCallback(
      onAdShowedFullScreenContent: (InterstitialAd ad) =>
          print('ad onAdShowedFullScreenContent.'),
      onAdDismissedFullScreenContent: (InterstitialAd ad) {
        print('$ad onAdDismissedFullScreenContent.');
        ad.dispose();
        _createInterstitialAd();
      },
      onAdFailedToShowFullScreenContent: (InterstitialAd ad, AdError error) {
        print('$ad onAdFailedToShowFullScreenContent: $error');
        ad.dispose();
        _createInterstitialAd();
      },
    );
    _interstitialAd.show();
    _interstitialAd = null;
  }
  
  void _createRewardedAd() {
    RewardedAd.load(
        adUnitId: RewardedAd.testAdUnitId,
        request: AdRequest(),
        rewardedAdLoadCallback: RewardedAdLoadCallback(
          onAdLoaded: (RewardedAd ad) {
            print('$ad loaded.');
            _rewardedAd = ad;
            _numRewardedLoadAttempts = 0;
          },
          onAdFailedToLoad: (LoadAdError error) {
            print('RewardedAd failed to load: $error');
            _rewardedAd = null;
            _numRewardedLoadAttempts += 1;
            if (_numRewardedLoadAttempts <= maxFailedLoadAttempts) {
              _createRewardedAd();
            }
          },
        ));
  }

  void _showRewardedAd() {
    if (_rewardedAd == null) {
      print('Warning: attempt to show rewarded before loaded.');
      return;
    }
    _rewardedAd.fullScreenContentCallback = FullScreenContentCallback(
      onAdShowedFullScreenContent: (RewardedAd ad) =>
          print('ad onAdShowedFullScreenContent.'),
      onAdDismissedFullScreenContent: (RewardedAd ad) {
        print('$ad onAdDismissedFullScreenContent.');
        ad.dispose();
        _createRewardedAd();
      },
      onAdFailedToShowFullScreenContent: (RewardedAd ad, AdError error) {
        print('$ad onAdFailedToShowFullScreenContent: $error');
        ad.dispose();
        _createRewardedAd();
      },
    );

    _rewardedAd.show(onUserEarnedReward: (RewardedAd ad, RewardItem reward) {
      print('$ad with reward $RewardItem(${reward.amount}, ${reward.type}');
    });
    _rewardedAd = null;
  }

  Future<void> _createAnchoredBanner(BuildContext context) async {
    final AnchoredAdaptiveBannerAdSize size =
        await AdSize.getAnchoredAdaptiveBannerAdSize(
      Orientation.portrait,
      MediaQuery.of(context).size.width.truncate(),
    );

    if (size == null) {
      print('Unable to get height of anchored banner.');
      return;
    }

    final BannerAd banner = BannerAd(
      size: size,
      request: AdRequest(),
      adUnitId: Platform.isAndroid
          ? 'ca-app-pub-4998190920703076/3442032629'
          : 'ca-app-pub-4998190920703076/3442032629',
      listener: BannerAdListener(
        onAdLoaded: (Ad ad) {
          print('$BannerAd loaded.');
          setState(() {
            _anchoredBanner = ad as BannerAd;
          });
        },
        onAdFailedToLoad: (Ad ad, LoadAdError error) {
          print('$BannerAd failedToLoad: $error');
          ad.dispose();
        },
        onAdOpened: (Ad ad) => print('$BannerAd onAdOpened.'),
        onAdClosed: (Ad ad) => print('$BannerAd onAdClosed.'),
      ),
    );
    return banner.load();
  }

  @override
  void dispose() {
    super.dispose();
    _interstitialAd?.dispose();
    _rewardedAd?.dispose();
    _anchoredBanner?.dispose();
  }

  bool _loading = false;

  void _onLoading() {
    setState(() {
      _loading = true;
      new Future.delayed(new Duration(seconds: 10), _login);
    });
  }

  Future _login() async {
    setState(() {
      _loading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return _loading
        ? Scaffold(
            body: Container(
              child: new Stack(
                children: <Widget>[
                  new Container(
                    alignment: AlignmentDirectional.center,
                    decoration: new BoxDecoration(
                      color: Colors.white70,
                    ),
                    child: new Container(
                      decoration: new BoxDecoration(
                          color: Colors.white,
                          borderRadius: new BorderRadius.circular(10.0)),
                      width: 300.0,
                      height: 200.0,
                      alignment: AlignmentDirectional.center,
                      child: new Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          new Center(
                            child: new SizedBox(
                              height: 50.0,
                              width: 50.0,
                              child: new CircularProgressIndicator(
                                color: Colors.lightGreen,
                                value: null,
                                strokeWidth: 7.0,
                              ),
                            ),
                          ),
                          new Container(
                            margin: const EdgeInsets.only(top: 25.0),
                            child: new Center(
                              child: new Text(
                                "Cargando... por favor espera",
                                style: new TextStyle(color: Colors.black),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          )
        : MaterialApp(
            debugShowCheckedModeBanner: false,
            theme: ThemeData(
              primaryColor: Colors.grey,
              cardColor: Colors.white,
              appBarTheme: AppBarTheme(
                color: HexColor("08CAF7"),
                centerTitle: true,
              ),
              bottomAppBarColor: HexColor("08CAF7"),
              floatingActionButtonTheme: FloatingActionButtonThemeData(
                  backgroundColor: Colors.yellow[800]),
            ),
            localizationsDelegates: [
              GlobalMaterialLocalizations.delegate,
              GlobalWidgetsLocalizations.delegate,
              GlobalCupertinoLocalizations.delegate,
              S.delegate,
            ],
            supportedLocales: S.delegate.supportedLocales,
            home: Builder(builder: (BuildContext context) {
              if (!_loadingAnchoredBanner) {
                _loadingAnchoredBanner = true;
                try {
                  _createAnchoredBanner(context);
                } catch (e) {
                  _onLoading();
                }
              }
              return Scaffold(
                body: CustomScrollView(
                  slivers: [
                    SliverToBoxAdapter(
                      child: _anchoredBanner != null
                          ? Container(
                              height: _anchoredBanner.size.height.toDouble(),
                              width: _anchoredBanner.size.width.toDouble(),
                              child: Container(
                                color: HexColor("08CAF7"),
                                width: _anchoredBanner.size.width.toDouble(),
                                height: _anchoredBanner.size.height.toDouble(),
                                child: AdWidget(ad: _anchoredBanner),
                              ),
                            )
                          : Text("no"),
                    ),
                    SliverAppBar(
                      pinned: true,
                      title: Text(
                        "Cat Life",
                        style: GoogleFonts.openSans(
                          textStyle: TextStyle(
                            color: Colors.white,
                            fontSize: 20,
                          ),
                        ),
                      ),
                      //leading: IconButton(icon: Icon(Icons.menu), onPressed: () {}),
                      actions: [
                        IconButton(
                          icon: Icon(
                            Icons.logout,
                            color: Colors.white,
                          ),
                          onPressed: () {
                            exit(0);
                          },
                        )
                      ],
                    ),
                    Header(),
                    SliverToBoxAdapter(
                      child: Container(
                        height: 10.0.h,
                        margin: EdgeInsets.only(
                          left: 20.sp,
                        ),
                        child: Container(
                          width: 90.w,
                          height: 90.h,
                          child: Text(
                            S.of(context).home_text_fourtytwo,
                            style: GoogleFonts.aBeeZee(
                              textStyle: TextStyle(
                                color: Colors.black,
                                fontSize: 20.sp,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                    /*SliverToBoxAdapter(
            child: Container(
              height: 500,
              margin: EdgeInsets.only(
                left: 20,
                right: 0,
              ),
              child: Container(
                width: 90,
                height: 90,
                child: Flexible(
                  child: new FirebaseAnimatedList(
                      query: _ref,
                      itemBuilder: (BuildContext context, DataSnapshot snapshot,
                          Animation<double> animation, int index) {
                        return new ListTile(
                          trailing: IconButton(
                            icon: Icon(Icons.delete),
                            onPressed: () => _ref.child(snapshot.key).remove(),
                          ),
                          title:
                              new Text(ubicacion = snapshot.value['latitude']),
                        );
                      }),
                ),
              ),
            ),
          ),*/
                    SliverToBoxAdapter(
                      child: Container(
                        height: 100,
                        margin: EdgeInsets.only(top: 10),
                        child: ListView.builder(
                          scrollDirection: Axis.horizontal,
                          itemCount: items,
                          itemBuilder: (context, index) => Stack(
                            children: [
                              Column(
                                children: [
                                  Container(
                                    height: 90,
                                    width: 90,
                                    margin: EdgeInsets.only(
                                      left: 75,
                                      //left: queryData.size.width / 5.5,
                                      right: 0,
                                    ),
                                    child: GestureDetector(
                                      onTap: () {
                                        setState(() async {
                                          currentSelectedItem = index;
                                          if (index == 0) {
                                            _showInterstitialAd();
                                            Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                builder:
                                                    (BuildContext context) =>
                                                        Age(),
                                              ),
                                            );
                                          }
                                          if (index == 1) {
                                            _showInterstitialAd();
                                            Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                builder:
                                                    (BuildContext context) =>
                                                        Age_Human(),
                                              ),
                                            );
                                          }
                                          if (index == 2) {}
                                          if (index == 3) {}
                                        });
                                      },
                                      child: Card(
                                        color: index == currentSelectedItem
                                            ? Colors.yellow[800]
                                            : Colors.white,
                                        child: Icon(
                                          index == 0
                                              ? Icons.pets
                                              : index == 1
                                                  ? Icons.person
                                                  : index == 2
                                                      ? Icons.fastfood_rounded
                                                      : index == 3
                                                          ? Icons
                                                              .connect_without_contact
                                                          : Icons.cancel,
                                          color: index == currentSelectedItem
                                              ? Colors.white
                                              : Colors.black.withOpacity(0.7),
                                        ),
                                        elevation: 3,
                                        margin: EdgeInsets.all(10),
                                        shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(25),
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              Positioned(
                                bottom: 0,
                                child: Container(
                                  margin: EdgeInsets.only(
                                    //left: index == 0 ? 20 : 0,
                                    left: 72,
                                    //left: queryData.size.width / 5.5,
                                    right: 0,
                                  ),
                                  width: 90,
                                  child: Row(
                                    children: [
                                      Spacer(),
                                      Text(
                                        index == 0
                                            ? S
                                                .of(context)
                                                .home_text_fourtythree
                                            : index == 1
                                                ? S
                                                    .of(context)
                                                    .home_text_fourtyfour
                                                : index == 2
                                                    ? "Food"
                                                    : index == 3
                                                        ? "Reportar"
                                                        : "",
                                        style: GoogleFonts.aBeeZee(
                                          textStyle: TextStyle(
                                            color: Colors.black,
                                            fontSize: 15.sp,
                                          ),
                                        ),
                                      ),
                                      Spacer(),
                                    ],
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                    ),
                    /*SliverToBoxAdapter(
            child: Container(
              height: 25,
              margin: EdgeInsets.only(
                left: 20,
                right: 0,
              ),
              child: Container(
                width: 90,
                height: 90,
                child: Text(
                  "Food calendar",
                  style: GoogleFonts.openSans(
                    textStyle: TextStyle(
                      color: Colors.black,
                      fontSize: 20,
                    ),
                  ),
                ),
              ),
            ),
          ),*/
                    SliverToBoxAdapter(
                      child: Container(
                        height: 20.h,
                      ),
                    ),
                    /*widget.id_robo != null
              ? SliverToBoxAdapter(
                  child: Container(
                    height: 25,
                    margin: EdgeInsets.only(
                      left: 20,
                      right: 0,
                    ),
                    child: Container(
                      width: 90,
                      height: 90,
                      child: Text(
                        "¡Alertas de robo!",
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 20,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                )
              : SliverToBoxAdapter(
                  child: Container(
                    height: 25,
                    margin: EdgeInsets.only(
                      left: 20,
                      right: 0,
                    ),
                    child: Container(
                      width: 90,
                      height: 90,
                      child: Text(
                        "",
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 20,
                            fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                ),*/
                    /*Portfolio(
            id_robo: widget.id_robo,
            imagen: widget.imagen,
            descripcion: widget.descripcion,
          )*/
                  ],
                ),
                extendBody: true,
                floatingActionButtonLocation:
                    FloatingActionButtonLocation.centerDocked,
                floatingActionButton: FloatingActionButton(
                  onPressed: () {},
                  child: Icon(Icons.home),
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
                            width: 10.0.h,
                          ),
                          IconButton(
                            icon: Icon(Icons.pets),
                            color: Colors.white,
                            onPressed: () {
                              _showInterstitialAd();
                              Navigator.pushReplacement(
                                context,
                                new MaterialPageRoute(
                                  builder: (context) => Age(),
                                ),
                              );
                            },
                          ),
                          SizedBox(
                            width: 15.w,
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
                            width: 15.w,
                          ),
                          IconButton(
                            icon: Icon(Icons.person),
                            color: Colors.white,
                            onPressed: () {
                              _showInterstitialAd();
                              Navigator.pushReplacement(
                                context,
                                new MaterialPageRoute(
                                  builder: (context) => Age_Human(),
                                ),
                              );
                            },
                          ),
                          SizedBox(
                            width: 15.w,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              );
            }));
  }
}
