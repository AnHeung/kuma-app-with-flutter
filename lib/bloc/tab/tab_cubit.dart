import 'package:bloc/bloc.dart';
import 'package:kuma_flutter_app/enums/app_tab.dart';

class TabCubit extends Cubit<AppTab> {

  TabCubit() : super(AppTab.Animation);

  tabUpdate(AppTab appTab){
    emit(appTab);
  }
}
