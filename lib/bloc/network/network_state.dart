part of 'network_bloc.dart';

enum  NetworkStatus { Connect, Disconnect}

class NetworkState extends Equatable{

  final NetworkStatus status;

  const NetworkState({this.status = NetworkStatus.Connect});

  @override
  List<Object> get props => [status];
}

