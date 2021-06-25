part of 'animation_widget.dart';

class OffsetListenableProvider extends InheritedWidget {
  final ValueListenable<double> offset;

  OffsetListenableProvider({Key key, @required this.offset, Widget child})
      : super(key: key, child: child);

  @override
  bool updateShouldNotify(InheritedWidget oldWidget) {
    return true;
  }

  static ValueListenable<double> of(BuildContext context) {
    return context
        .dependOnInheritedWidgetOfExactType<OffsetListenableProvider>()
        .offset;
  }
}
