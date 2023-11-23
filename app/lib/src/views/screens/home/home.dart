import 'package:app/resources/sizing/device_type.dart';
import 'package:app/resources/sizing/screen_size.dart';
import 'package:app/src/router/router.dart';
import 'package:app/src/views/screens/home/welcome_drooti.dart';
import 'package:app/src/views/shared/buttons/game_button.dart';
import 'package:app/src/views/screens/logo/logo.dart';
import 'package:app/src/views/design/palette.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class Home extends StatefulWidget {
  const Home({required this.navigator, super.key});
  final INavigation navigator;

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  bool loggedIn = false;
  @override
  Widget build(BuildContext context) {
    Size s = ScreenSize.getSize(context);
    final l = AppLocalizations.of(context)!;
    final d = DeviceType(s.width, s.height);

    //Drooti

    var movementX = d.getValueForScreen<double>(
            onMobile: 12, onTablet: 35, onDesktop: 50) ??
        12;
    var movementY = d.getValueForScreen<double>(
            onMobile: 16, onTablet: 18, onDesktop: 18) ??
        16;
    var boxWidth = d.getValueForScreen(
            onMobile: s.width * 0.85,
            onTablet: s.width * 0.75,
            onDesktop: s.width * 0.6) ??
        s.width * 0.8;

    var drootiDisplay = WelcomeDrooti(
      boxWidth: boxWidth,
      drootiSize: s.height * 0.35,
      maxOffsetX: movementX,
      maxOffsetY: movementY,
    );

    //Logo
    var logoSize = s.height * 0.08;
    var logo = SizedBox(
        child: Center(
            child: Padding(
      padding: EdgeInsets.all(logoSize * 0.2),
      child: Logo(
        size: logoSize,
        color: Palette().chromeSilver,
        shadows: kElevationToShadow[1],
      ),
    )));

    ///Buttons
    var btnHeight = s.height * 0.075;
    var btnWidth = d.getValueForScreen(
            onMobile: btnHeight * 4,
            onTablet: btnHeight * 5,
            onDesktop: btnHeight * 6) ??
        btnHeight * 4;

    var settingsBtn = GameButton(
      text: l.settings.toUpperCase(),
      onPressed: () {
        widget.navigator.goToSettings();
      },
      height: btnHeight,
      width: btnWidth,
    );
    Widget account;
    if (loggedIn) {
      account = GameButton(
        text: l.account.toUpperCase(),
        onPressed: () {
          //todo pending
          // widget.navigator.goToAccount()
        },
        height: btnHeight,
        width: btnWidth,
      );
    } else {
      var loginBtn = GameButton(
        text: l.login.toUpperCase(),
        onPressed: () {
          widget.navigator.goToLogin();
        },
        height: btnHeight,
        width: btnWidth * 0.48,
      );
      var signUpBtn = GameButton(
        text: l.signUp.toUpperCase(),
        onPressed: () {
          widget.navigator.goToSignUp();
        },
        height: btnHeight,
        width: btnWidth * 0.48,
      );
      account = SizedBox(
        width: btnWidth,
        child: Row(
          children: [loginBtn, const Spacer(), signUpBtn],
        ),
      );
    }
    var playBtn = GameButton(
      text: l.play.toUpperCase(),
      onPressed: () {
        widget.navigator.goToPickBackground();
      },
      height: btnHeight * 1.1,
      width: btnWidth,
    );

    var buttons = [account, settingsBtn, playBtn];
    buttons = buttons
        .map((btn) =>
            Padding(padding: EdgeInsets.all(btnHeight / 5), child: btn))
        .toList();

    return Scaffold(
      backgroundColor: Colors.grey[100]!,
      body: ConstrainedBox(
        constraints: BoxConstraints(minHeight: s.height, minWidth: s.width),
        child: SingleChildScrollView(
            child: Column(children: [
          const SizedBox(height: 40),
          drootiDisplay,
          logo,
          ...buttons,
        ])),
      ),
    );
  }
}
