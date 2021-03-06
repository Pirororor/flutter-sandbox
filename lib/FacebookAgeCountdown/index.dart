import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';

import 'package:flutter/material.dart';
import 'package:flutter_signin_button/flutter_signin_button.dart';
import 'package:test_flutter/Sidebar/index.dart';

import 'classes/FacebookInfo.dart';
import 'widgets/UserData.dart';

class FacebookAgeCountdown extends StatelessWidget {
  const FacebookAgeCountdown({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider<FacebookInfo>(
        create: (_) => FacebookInfo(),
        child: const FacebookAgeCountdownInner());
  }
}

class FacebookAgeCountdownInner extends StatefulWidget {
  const FacebookAgeCountdownInner({Key? key}) : super(key: key);

  @override
  State<FacebookAgeCountdownInner> createState() =>
      _FacebookAgeCountdownInnerState();
}

class _FacebookAgeCountdownInnerState extends State<FacebookAgeCountdownInner> {
  @override
  void initState() {
    super.initState();
    Provider.of<FacebookInfo>(context, listen: false).init();
  }

  @override
  Widget build(BuildContext context) {
    final facebookInfo = Provider.of<FacebookInfo>(context, listen: true);
    return Scaffold(
      appBar: AppBar(
        title: const Text("Old Age Countdown"),
      ),
      drawer: const Sidebar(),
      body: Center(
          child: !facebookInfo.isInitialized
              ? const Text('Loading')
              : facebookInfo.isLoggedIn
                  ? UserData(
                      profileData: facebookInfo.profileInfo,
                      onLogout: () async {
                        await facebookInfo.logout();
                        Fluttertoast.showToast(msg: 'Logged out!');
                      },
                    )
                  : Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [_displayLoginButton()])),
    );
  }

  _displayLoginButton() {
    return SignInButton(
      Buttons.FacebookNew,
      text: "Login with Facebook",
      onPressed: () =>
          Provider.of<FacebookInfo>(context, listen: false).login(),
    );
  }
}
