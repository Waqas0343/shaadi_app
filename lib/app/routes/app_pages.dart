import 'package:get/get_navigation/src/routes/get_route.dart';
import 'package:shaadi_app/app/home/home_screen.dart';
import 'package:shaadi_app/app/login/login_screen.dart';
import '../forget_password/forget_password_screen.dart';
import '../introduction/introduction.dart';
import '../payment/bank_payment.dart';
import '../payment/easy_paisa_payment.dart';
import '../payment/jazz_cash_payment.dart';
import '../payment/payment_packages.dart';
import '../payment/payment_video.dart';
import '../signup/signup_screen.dart';
import '../signup/user_information_stepper.dart';
import '../signup/user_information_one.dart';
import '../splash/splash_screen.dart';
import '../user_chat/chat_with_user_screen.dart';
import '../view_profile/view_profile_screen.dart';
import '../welcome/welcome_screen.dart';
import 'app_routes.dart';

class AppPages {
  static final List<GetPage> pages = <GetPage>[
    GetPage(
      name: AppRoutes.splash,
      page: () => const Splash(),
    ),
    GetPage(
      name: AppRoutes.introduction,
      page: () => const IntroScreen(),
    ),
    GetPage(
      name: AppRoutes.welcomeScreen,
      page: () => const WelcomeScreen(),
    ),
    GetPage(
      name: AppRoutes.login,
      page: () => const Login(),
    ),
    GetPage(
      name: AppRoutes.signUpScreen,
      page: () => const SignUpScreen(),
    ),
    GetPage(
      name: AppRoutes.userInformation,
      page: () => const UserInformationOne(),
    ),
    GetPage(
      name: AppRoutes.userInformationStepper,
      page: () => const UserInformationStepper(),
    ),
    GetPage(
      name: AppRoutes.home,
      page: () => const HomePage(),
    ),
    GetPage(
      name: AppRoutes.paymentPackagesModel,
      page: () => const PaymentPackages(),
    ),
    GetPage(
      name: AppRoutes.bankpayment,
      page: () => const BankPayment(),
    ),
    GetPage(
      name: AppRoutes.jazzCashPayment,
      page: () => const JazzCashPayment(),
    ),
    GetPage(
      name: AppRoutes.easyPaisaPayment,
      page: () => const EasyPaisaPayment(),
    ),
    GetPage(
      name: AppRoutes.viewProfile,
      page: () => const ViewProfileScreen(),
    ),
    GetPage(
      name: AppRoutes.forgetPassword,
      page: () => const ForgetPassScreen(),
    ),
    GetPage(
      name: AppRoutes.chatWithUser,
      page: () => const ChatWithUserScreen(),
    ),
    GetPage(
      name: AppRoutes.paymentVideo,
      page: () => const PaymentVideo(),
    ),

  ];
}
