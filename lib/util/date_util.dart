
import 'package:intl/intl.dart';
import 'package:kuma_flutter_app/app_constants.dart';

getFourYearMapData(){
  DateTime now = DateTime.now();
  int currentYear = now.year;
  List<int> yearList = [currentYear,  currentYear-1 , currentYear-2, currentYear-3];
  DateFormat dateFormat = DateFormat('yyyy-MM-dd');

  return yearList.fold(Map<String,String>(),(acc, year){
    if(year == currentYear){
      (acc as Map<String,String>).addAll({year.toString() : "${dateFormat.format(DateTime(currentYear))}~${dateFormat.format(now)}"});
    }else{
      (acc as Map<String,String>).addAll({year.toString() : "${dateFormat.format(DateTime(year,1))}~${dateFormat.format(DateTime(year,12,31))}"});
    }
    return acc;
  });
}

getToday(){
  DateTime now = DateTime.now();
  DateFormat dateFormat = DateFormat(kTimeFormat);
  return dateFormat.format(now);
}

dateTimeToFormat(DateTime time){
  DateFormat dateFormat = DateFormat(kTimeFormat);
  return dateFormat.format(time);
}

bool compareTime(String time1 ,String time2){
  int time =  DateTime.parse(time1).compareTo(DateTime.parse(time2));
  switch(time){
    case 0 :
    case -1:
    return false;
    case 1:
      return true;
  }
  return false;
}