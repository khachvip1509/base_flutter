// ignore_for_file: constant_identifier_names

enum FormatValuePresent { Normal, Money, Percent }

enum KeyboardType { Normal, Number, Phone, Email }

enum TypeInputForm {
  textField,
  dropDownSearch,
  text,
  dateTimePicker,
  checkbox,
  hiddenInput,
  line,
  lineBox,
  buttonOCR,
  button,
  groupPerson,
  kyPhi,
}

enum TypeChildInputForm { undefined, timePicker, datePicker }

enum TypeOCR { cccd, dangKyDangKiem }

enum KieuNhapLoaiXe { A, C, T }

enum TypeFrom { edit, createNew, reNew, copy }

List<Map<String, dynamic>> getYearData() {
  DateTime date = DateTime.now();
  var year = date.year;

  List<Map<String, dynamic>> yearData = [];

  for (var i = 0; i <= 30; i++) {
    yearData.add({"MA": (year - i).toString(), "TEN": (year - i).toString()});
  }

  return yearData;
}

bool validateCMT(String str) {
  str = str.replaceAll('/[^0-9]/g', "");
  if (str.length == 7 ||
      str.length == 14 ||
      str.length == 12 ||
      str.length == 11 ||
      str.length == 9) {
    return true;
  }

  return false;
}
