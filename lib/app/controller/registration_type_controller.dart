import 'package:get/get.dart';

enum RegistrationTypeEnum {
  individual,
  government,
  semiGovernment,
  pilot;

  String get toArString {
    String result = '';
    switch (this) {
      case RegistrationTypeEnum.individual:
        result = 'افراد';
        break;
      case RegistrationTypeEnum.government:
        result = 'حكومي';
        break;
      case RegistrationTypeEnum.semiGovernment:
        result = 'شبه حكومي';
        break;
      case RegistrationTypeEnum.pilot:
        result = 'سائق';
        break;
    }
    return result;
  }

  @override
  toString() {
    String result = '';
    switch (this) {
      case RegistrationTypeEnum.individual:
        result = 'individual';
        break;
      case RegistrationTypeEnum.government:
        result = 'government';
        break;
      case RegistrationTypeEnum.semiGovernment:
        result = 'semiGovernment';
        break;
      case RegistrationTypeEnum.pilot:
        result = 'pilot';
        break;
    }
    return result;
  }
}

class RegistrationTypeController extends GetxController {
  static final Rx<RegistrationTypeEnum> _selected =
      (RegistrationTypeEnum.pilot).obs;

  RegistrationTypeEnum get selected => _selected.value;

  set selected(RegistrationTypeEnum value) {
    _selected.value = value;
    update();
  }
}
