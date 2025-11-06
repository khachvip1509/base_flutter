import 'package:intl/intl.dart';
import 'package:untitled/utils/extensions/date.dart';

extension StringMoney on String {
  String formatMoney({String unit = " VNĐ"}) {
    final oCcy = NumberFormat("#,###.##", "en_US");
    if (strimFloat().isNotEmpty || strimFloat() == "null") {
      final money = double.parse(strimFloat().replaceAll(',', ''));
      return oCcy.format(money) + unit;
    }
    return "0 VNĐ";
  }

  String getCurrency() {
    String text = this;
    var a = text.split(",");
    String temp = "";
    for (var i = 0; i < a.length; i++) {
      temp = temp + a[i];
    }
    return temp;
  }

  String strimFloat() {
    String text = this;
    if (text.isNotEmpty) {
      text.replaceAll(',', '');
      final array = text.split('.');
      if (array.length > 1 && array[1].isNotEmpty) {
        final price = double.parse(array[1]);
        if (price == 0) {
          text = array[0];
        }
      }
    }
    return text;
  }
}

extension EmailValidator on String {
  bool isValidEmail() {
    return RegExp(r"^[a-zA-Z0-9.]+@[a-zA-Z0-9]+\.[a-zA-Z]+").hasMatch(this);
  }
}

extension SplitString on String {
  String splitStringtoDateFormat() {
    if (length < 8) {
      return DateTime.now().formatDateToString();
    }
    List<String> list = ['', '', ''];
    list[0] = substring(0, 4);
    list[1] = substring(4, 6);
    list[2] = substring(6, 8);
    String result = "${list[2]}/${list[1]}/${list[0]}";
    return result;
  }
}

extension PassValidator on String {
  bool validatePassword() {
    if (length == 0) {
      return false;
    }
    bool passValid = RegExp(
      r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9]).{6,}$',
    ).hasMatch(this);
    return passValid;
  }
}

extension PhoneValidator on String {
  bool isValidPhone() {
    if (length == 0) {
      return false;
    }
    bool mobileValid = RegExp(r'^(03|09|08|07|05)+([0-9]{8})$').hasMatch(this);
    return mobileValid;
  }
}

extension StringFormatDate on String {
  DateTime? converStringToDate({String dateFormat = 'yyyy-MM-dd'}) {
    try {
      if (isNotEmpty) {
        DateTime tempDate = DateFormat(dateFormat).parse(this);
        return tempDate;
      }
      return null;
    } catch (e) {
      return null;
    }
  }

  String converStringToDateToString({String dateFormat = 'yyyy-MM-dd'}) {
    try {
      if (isNotEmpty) {
        DateTime tempDate = DateFormat(dateFormat).parse(this);
        return tempDate.formatDateToString();
      }
      return "";
    } catch (e) {
      return "";
    }
  }

  DateTime? converTryStringToDate() {
    try {
      DateTime? tempDate = DateTime.tryParse(this);
      return tempDate;
    } catch (e) {
      return null;
    }
  }
}

extension StringFormatDouble on String {
  String? converDoubleToString() {
    try {
      return split(".").first;
    } catch (e) {
      return "0";
    }
  }
}

extension SubString on String {
  String sub({required int start, int? end}) {
    if (end == null) {
      return substring(start);
    }
    if (length < end) {
      return substring(start, length);
    }
    return substring(start, end);
  }
}

// extension FormatCurrencyEx on dynamic {
//   String toVND({String? unit = 'đ'}) {
//     int number = int.parse(this.toString());
//     // var vietNamFormatCurrency =
//     //     NumberFormat.currencyFromString(locale: "vi-VN", symbol: unit);
//     var vietNamFormatCurrency =
//         NumberFormat.currency(locale: "vi-VN", symbol: unit);
//     return vietNamFormatCurrency.format(number);
//   }
// }
// extension ExtString on String {
//   bool get isValidEmail {
//     final emailRegExp = RegExp(r"^[a-zA-Z0-9.]+@[a-zA-Z0-9]+\.[a-zA-Z]+");
//     return emailRegExp.hasMatch(this);
//   }

//   bool get isValidName {
//     final nameRegExp =
//         RegExp(r"^\s*([A-Za-z]{1,}([\.,] |[-']| ))+[A-Za-z]+\.?\s*$");
//     return nameRegExp.hasMatch(this);
//   }

//   bool get isValidPassword {
//     final passwordRegExp = RegExp(
//         r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*?[0-9])(?=.*?[!@#\><*~]).{8,}/pre>');
//     return passwordRegExp.hasMatch(this);
//   }

//   bool get isNotNull {
//     // ignore: unnecessary_null_comparison
//     return this != null;
//   }

//   bool get isValidPhone {
//     final phoneRegExp = RegExp(r"^\+?0[0-9]{10}$");
//     return phoneRegExp.hasMatch(this);
//   }
// }
