import 'auth_manager.dart';

class ApiExeption {
  int? code;
  String? message;
  int? status;
  ApiExeption(this.message, this.code, {this.status = null});
  String getFarsiMessage() {
    switch (code) {
      case 404:
        return '!!ثبت نام نکرده اید';
      // case 422:
      //   return 'تلاش بیش از حد مجاز لطفا صبر کنید';
      // case 420:
      // return 'این کدملی سجامی نیست';
      // case 401:
      //   AuthMnager.authChangeNotifier.value == '';
      //   AuthMnager.logout();
      //   return "!!شما لاگین نیستید";
      case 403:
        AuthMnager.authChangeNotifier.value == '';
        AuthMnager.logout();
        return "درخواست بیش از حد مجاز لطفا صبر کنید";
      case -1:
        return 'خطا در برقراری ارتباط با سرور';
      default:
        if (code != status) {
          return message ?? 'خطا در برقراری ارتباط با سرور';
        } else {
          return code?.toString() ?? 'خطا در برقراری ارتباط با سرور';
        }
    }
  }
}

// class Unauthorized extends StatelessWidget {
//   const Unauthorized({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return context.pushReplacement(RouteNames.login);
//   }
// }
