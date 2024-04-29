import 'package:intl/intl.dart';


  String formattedDate(DateTime dateTime) {
    var now = dateTime;
    var formatter = DateFormat('hh:mm a. dd/MM ');
    String formattedDate = formatter.format(now);
    return formattedDate;
  }

