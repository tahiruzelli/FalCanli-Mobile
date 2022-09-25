import 'package:falcanli/Globals/Constans/storage_keys.dart';
import 'package:falcanli/Globals/Utils/booleans.dart';
import 'package:falcanli/Globals/Utils/exit_app.dart';
import 'package:falcanli/Globals/Widgets/custom_snackbar.dart';
import 'package:falcanli/Repository/User/CreditRepository/user_credit_repository.dart';
import 'package:falcanli/Repository/User/ProfileRepository/user_profile_repository.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

class UserCreditController extends GetxController {
  UserCreditRepository creditRepository = UserCreditRepository();
  RxBool isGetCreditLoading = false.obs;
  Future getCredit(int amount) async {
    String? userId = GetStorage().read(userIdKey);
    if (userId != null) {
      isGetCreditLoading.value = true;
      creditRepository.getCredit(amount: amount, userId: userId).then((value) {
        if (isHttpOK(value['statusCode'])) {
          UserProfileRepository userProfileRepository = UserProfileRepository();

          successSnackBar("Kredi yuklemeniz basariyla tamamlanmistir");
          userProfileRepository.getUserCredit(userId).then((value) {
            if (isHttpOK(value['statusCode'])) {
              int? currentCredit = value['result']['remainingCredit'];
              infoSnackBar("Mevcut Krediniz: $currentCredit");
            }
          });
        } else {
          warningSnackBar(value['message']);
        }
        isGetCreditLoading.value = false;
      });
    } else {
      errorSnackBar("Bir hata ile karsilastik uygulama kapanacaktir");
      exitApp();
    }
  }
}
