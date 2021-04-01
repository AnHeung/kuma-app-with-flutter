
import 'package:intl/intl.dart';

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