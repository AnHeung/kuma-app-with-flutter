part of 'common.dart';

Future<bool> isNetworkConnect ()async{
    ConnectivityResult result =  await (Connectivity().checkConnectivity());
    return result == ConnectivityResult.mobile ||
        result == ConnectivityResult.wifi;
}