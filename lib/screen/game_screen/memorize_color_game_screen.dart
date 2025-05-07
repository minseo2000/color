import 'dart:async';
import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:memory_test_game/core/game_level.dart';
import 'package:memory_test_game/screen/game_screen/memorize_color_game_screen2.dart';

import '../../ad_helper.dart';
import '../../widget/animated_countdown.dart';

class MemorizeColorGameScreen extends StatefulWidget {
  const MemorizeColorGameScreen({Key? key}) : super(key: key);

  @override
  State<MemorizeColorGameScreen> createState() => _MemorizeColorGameScreenState();
}

class _MemorizeColorGameScreenState extends State<MemorizeColorGameScreen> {


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
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Expanded(
                flex: 1,
                child: Container(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      AnimatedCountdown(
                        countdownNumbers: ['3', '2', '1', '시작!'],
                        onFinished: () {
                          print('✅ 카운트다운 완료!');
                          Navigator.of(context).push(
                            PageRouteBuilder(
                              pageBuilder: (context, animation, secondaryAnimation) => MemorizeColorGameScreen2(
                                changeCount: gameLevels[0].changeCount,
                                interval: gameLevels[0].interval,
                                currentLevel: 0,
                              ),
                              transitionDuration: Duration.zero,
                              reverseTransitionDuration: Duration.zero,
                            ),
                          );
                        },
                      ),
                      const SizedBox(height: 30),
                      Text(
                        '화면에 나오는 색 순서를 기억하세요!',
                        style: TextStyle(fontSize: MediaQuery.of(context).size.width / 20),
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
}
