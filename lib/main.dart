import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:tutornest/firebase_options.dart';
import 'package:tutornest/pages/Admin/admin_main_page.dart';
import 'package:tutornest/pages/ApplicationProcessing.dart';
import 'package:tutornest/pages/Student/payment_page_content.dart';
import 'package:tutornest/pages/Student/student_live_stream_page.dart';
import 'package:tutornest/pages/Student/student_main_page.dart';
import 'package:tutornest/pages/forgot_password_otp.dart';
import 'package:tutornest/pages/forgot_password_page_content.dart';
import 'package:tutornest/pages/get_started_page.dart';
import 'package:tutornest/pages/login_page.dart';
import 'package:tutornest/pages/otp_page_register.dart';
import 'package:tutornest/pages/password_reset_page.dart';
import 'package:tutornest/pages/register_page.dart';
import 'package:tutornest/pages/Student/tutor_details_content.dart';
import 'package:tutornest/pages/tutor/tutor_main_page.dart';



void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  try {
    await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform,);
  } catch (e) {
    print("Firebase initialization error: $e");
  }
  runApp(const MyApp());
}


class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // Replace these with your actual Agora App ID and a valid Token
  // final String agoraAppId = 'e852fa884df2463f83c3684bba401896';
  // final String agoraToken = '007eJxTYHhyiEnLpueB+sTXsSU3+470lDVNbzjtdOAtV5PwJAHuwj4FhlQLU6O0RAsLk5Q0IxMz4zQL42RjMwuTpKREEwNDC0szZ76I9IZARoY9i48yMzJAIIjPw1CSWlwSn5yRmJeXmsPAAABbfiJP';
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      initialRoute: '/',
      routes: {
        '/': (context) => GetStartedPage(),
        '/login': (context) => LoginPage(),
        '/signup': (context) => RegisterPage(),
        // '/main': (context) => ChangePasswordPage(),
        // '/main': (context) => ChangePasswordPage(),
        // '/main': (context) => OtpPage(userEmail: userEmail),
        '/livestreamstudent': (context) => StudentLiveStreamPage(),
        // '/main': (context) => ProfilePageContent(),
        '/studentmain': (context) => MainPage(),
        '/esewaPayment': (context) => PaymentPage(),
        // '/main': (context) => SettingsPageContent(),
        // '/main': (context) => TutorDetailsContent(),
        '/main': (context) => TutorMainPage(),
        // '/main': (context) => WalletPage(),
        '/adminmain': (context) => AdminMainPage(),
        '/processing':(context)=>TutorApplicationProcessingPage(),



      },
    );
  }
}



