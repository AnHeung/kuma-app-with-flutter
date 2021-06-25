import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:connectivity/connectivity.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

part 'network_event.dart';

part 'network_state.dart';

class NetworkBloc extends Bloc<NetworkEvent, NetworkState> {
  StreamSubscription streamSubscription;

  NetworkBloc() : super(const NetworkState()) {
    streamSubscription = Connectivity().onConnectivityChanged.listen((event) {
      print('networkEvent : ${event}');
      if (event == ConnectivityResult.mobile ||
          event == ConnectivityResult.wifi) {
        add(NetworkConnect());
        print('web on ');
      } else {
        print('web off ');
        add(NetworkDisconnect());
      }
    });
  }

  @override
  Future<Function> close() {
    streamSubscription?.cancel();
    return super.close();
  }

  @override
  Stream<NetworkState> mapEventToState(
    NetworkEvent event,
  ) async* {
    if (event is NetworkConnect) {
      yield const NetworkState(status: NetworkStatus.Connect);
    } else if (event is NetworkDisconnect) {
      yield const NetworkState(status: NetworkStatus.Disconnect);
    } else if (event is CheckNetwork) {
      yield* _mapToNetworkState();
    }
  }

  Stream<NetworkState> _mapToNetworkState() async* {
    await Future.delayed(const Duration(seconds: 1));
    var connectivityResult = await (Connectivity().checkConnectivity());
    if (connectivityResult == ConnectivityResult.mobile ||
        connectivityResult == ConnectivityResult.wifi) {
      yield const NetworkState(status: NetworkStatus.Connect);
    } else {
      yield const NetworkState(status: NetworkStatus.Disconnect);
    }
  }
}
