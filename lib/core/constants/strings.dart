import 'package:flutter_clean_riverpod/config/l10n/app_localization_helper.dart';
import 'package:flutter/cupertino.dart';

String monthText(int month, {bool shortForm = true}) {
  switch (month) {
    case DateTime.january:
      return shortForm ? 'Jan' : 'January';
    case DateTime.february:
      return shortForm ? 'Feb' : 'February';
    case DateTime.march:
      return shortForm ? 'Mar' : 'March';
    case DateTime.april:
      return shortForm ? 'Apr' : 'April';
    case DateTime.may:
      return shortForm ? 'May' : 'May';
    case DateTime.june:
      return shortForm ? 'Jun' : 'June';
    case DateTime.july:
      return shortForm ? 'Jul' : 'July';
    case DateTime.august:
      return shortForm ? 'Aug' : 'August';
    case DateTime.september:
      return shortForm ? 'Sep' : 'September';
    case DateTime.october:
      return shortForm ? 'Oct' : 'October';
    case DateTime.november:
      return shortForm ? 'Nov' : 'November';
    case DateTime.december:
      return shortForm ? 'Dec' : 'December';
    default:
      return '';
  }
}

String weekdaysText(BuildContext context, DateTime day,
    {bool showAsOneLatter = false,}) {
  if (day.weekday == DateTime.saturday) {
    return showAsOneLatter ? 'S' : context.tr.saturday;
  }
  if (day.weekday == DateTime.sunday) {
    return showAsOneLatter ? 'S' : context.tr.sunday;
  }
  if (day.weekday == DateTime.monday) {
    return showAsOneLatter ? 'M' : context.tr.monday;
  }
  if (day.weekday == DateTime.tuesday) {
    return showAsOneLatter ? 'T' : context.tr.tuesday;
  }
  if (day.weekday == DateTime.wednesday) {
    return showAsOneLatter ? 'W' : context.tr.wednesday;
  }
  if (day.weekday == DateTime.thursday) {
    return showAsOneLatter ? 'T' : context.tr.thursday;
  }
  return showAsOneLatter ? 'F' : context.tr.friday;
}
