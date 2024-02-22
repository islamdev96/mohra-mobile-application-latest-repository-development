import 'package:starter_application/generated/l10n.dart';
import 'package:intl/intl.dart';

class DateTimeHelper {
  static getToDoListTitle(DateTime dateToCheck) {
    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);
    final aDate =
        DateTime(dateToCheck.year, dateToCheck.month, dateToCheck.day);
    if (aDate == today) {
      return Translation.current.today_todo_list;
    } else {
      String monthShortName = DateFormat.MMM().format(dateToCheck);
      String dayNumber = dateToCheck.day.toString();
      return '$dayNumber,$monthShortName ${Translation.current.todo_list}';
    }
  }

  static getAppointmentTitle(DateTime dateToCheck) {
    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);
    final aDate =
        DateTime(dateToCheck.year, dateToCheck.month, dateToCheck.day);
    if (aDate == today) {
      return Translation.current.today_appointment;
    } else {
      String monthShortName = DateFormat.MMM().format(dateToCheck);
      String dayNumber = dateToCheck.day.toString();
      return '$dayNumber,$monthShortName ${Translation.current.appointment}';
    }
  }

  static getPositivityTitle(DateTime dateToCheck) {
    final now = DateTime.now();
    final today = DateTime(now.year, now.month, now.day);
    final aDate =
        DateTime(dateToCheck.year, dateToCheck.month, dateToCheck.day);
    if (aDate == today) {
      return Translation.current.today;
    } else {
      String monthShortName = DateFormat.MMM().format(dateToCheck);
      String dayNumber = dateToCheck.day.toString();
      return '$dayNumber,$monthShortName ${dateToCheck.year}';
    }
  }

  static getDateOnly(String? date) {
    if (date == null) {
      return null;
    }
    DateTime input = DateTime.parse(date);
    DateTime dateTime = DateTime.parse(
      DateFormat("yyyy-MM-dd", "en").format(input),
    );
    return dateTime;
  }

  static stringToParsedString(String? date) {
    if (date == null) {
      return null;
    }
    return DateFormat("yyyy-MM-dd").format(DateTime.parse(date));
  }

  static dateTo12Format(DateTime? time) {
    if (time == null) {
      return '';
    }
    return DateFormat("hh:mm a").format(time);
  }

  static getFormatedDate(DateTime? dateTime) {
    if (dateTime == null) return '';
    return DateFormat("yyyy-MM-dd").format(dateTime);
  }

  static String getStringDateInEnglish(String? date) {
    if (date == null) {
      return '';
    } else {
      String parsedString = _convertToEnglishDate(date);
      return parsedString;
    }
  }

  static DateTime getDateInEnglish(String? date) {
    if (date == null || date == '') {
      return DateTime.now();
    } else {
      String parsedString = _convertToEnglishDate(date);
      return DateTime.parse(parsedString);
    }
  }

  static _convertToEnglishDate(String stringDate) {
    String result = '';
    for (int i = 0; i < 10; i++) {
      print('unicode of $i is ${'$i'.codeUnitAt(0)}');
    }

    for (int i = 0; i < stringDate.length; i++) {
      String temp = stringDate[i];
      String tempReplaced = _replaceString(temp);
      result += tempReplaced;
    }
    return result;
  }

  static _replaceString(String temp) {
    print('unicode of $temp is ${temp.codeUnitAt(0)}');
    switch (temp.codeUnitAt(0)) {
      case 1632:
        return String.fromCharCode(48);
      case 1633:
        return String.fromCharCode(49);
      case 1634:
        return String.fromCharCode(50);
      case 1635:
        return String.fromCharCode(51);
      case 1636:
        return String.fromCharCode(52);
      case 1637:
        return String.fromCharCode(53);
      case 1638:
        return String.fromCharCode(54);
      case 1639:
        return String.fromCharCode(55);
      case 1640:
        return String.fromCharCode(56);
      case 1641:
        return String.fromCharCode(57);
      default:
        {
          return temp;
        }
    }
  }

  static eventDate(DateTime date) {
    return DateFormat("EE dd MMM yyyy").format(date).toString();
  }
}
