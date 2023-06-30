import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:upla/ui/components/responsive.dart';
import 'package:upla/ui/pages/login/widget/desktop_login.dart';
import 'package:upla/ui/pages/login/widget/mobile_login.dart';

class LoginScreen extends StatelessWidget {
  static String id = "login_page";

  const LoginScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: AnnotatedRegion(
        value: const SystemUiOverlayStyle(
          statusBarColor: Colors.transparent,
          statusBarIconBrightness: Brightness.dark,
        ),
        child: Responsive(
          mobile: MobileLogin(),
          tablet: DesktopLogin(),
          desktop: DesktopLogin(),
        ),
      ),
    );
  }
}
