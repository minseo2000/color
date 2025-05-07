import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:memory_test_game/ad_helper.dart';
import 'package:memory_test_game/screen/game_screen/memorize_color_game_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  
  
  BannerAd? _bannerAd;
  
  @override
  void initState(){
    super.initState();
    _createBannerAd();
  }

  @override
  void dispose(){
    super.dispose();

    _bannerAd!.dispose();
  }

  void _createBannerAd(){
    _bannerAd = BannerAd(size: AdSize.banner, adUnitId: AdHelper.bannerAdUnitId, listener: AdHelper.bannerAdListener, request: AdRequest())..load();
  }
  
  @override
  Widget build(BuildContext context) {
    
    return Scaffold(
      backgroundColor: Color(0xff1C4F80),
      body: SafeArea(
        child: Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          child: Column(
            children: [
              Expanded(
                flex: 7,
                child: Container(
                  child: Image.asset('assets/images/main_logo_remove.png'),
                ),
              ),
              Expanded(
                flex: 3,
                child: Container(
                  child: Column(
                    children: [
                      Container(
                        child: ElevatedButton(
                          onPressed: (){
                            Navigator.push(context, MaterialPageRoute(builder: (context)=>MemorizeColorGameScreen()));
                          },
                          child: Text('시작하기', style: TextStyle(color: Colors.black),),
                          style: ElevatedButton.styleFrom(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(5.0),
                            ),
                            backgroundColor: Colors.white
                          ),
                        ),
                        width: MediaQuery.of(context).size.width/3*2,
                        height: 45.0,
                      ),
                      SizedBox(height: 10.0,),
                      Container(
                        child: ElevatedButton(
                          onPressed: (){
                            renderHowToPlayGame();
                          },
                          child: Text('게임방법', style: TextStyle(color: Colors.black),),
                          style: ElevatedButton.styleFrom(
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(5.0),
                              ),
                              backgroundColor: Colors.white
                          ),
                        ),
                        width: MediaQuery.of(context).size.width/3*2,
                        height: 45.0,
                      ),
                    ],
                  ),
                ),
              ),
              Container(
                width: MediaQuery.of(context).size.width,
                height: 50.0,
                child: AdWidget(ad: _bannerAd!),
              )
            ],
          ),
        ),
      ),
    );
  }

  renderHowToPlayGame(){
    showDialog(context: context, builder: (context){
      return AlertDialog(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(5.0)
        ),
        content: Container(
          child: SingleChildScrollView(
            child: Column(
              children: [

              ],
            ),
          ),
        ),
        actions: [
          ElevatedButton(
              onPressed: (){
                Navigator.pop(context);
              },
              child: Text('닫기', style: TextStyle(color: Colors.white),),
            style: ElevatedButton.styleFrom(
              backgroundColor: Color(0xff1C4F80),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(5.0)
              )
            ),
          )
        ],
      );
    });
  }
}
