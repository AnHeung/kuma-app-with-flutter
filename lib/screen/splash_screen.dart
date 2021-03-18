
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kuma_flutter_app/bloc/splash/splash_bloc.dart';
import 'package:kuma_flutter_app/util/view_utils.dart';
import 'package:kuma_flutter_app/widget/loading_indicator.dart';

class SplashScreen extends StatefulWidget {

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> with SingleTickerProviderStateMixin{


  AnimationController animationController;
  Animation<double> sizeUpAnimation;
  Animation<double> spinAnimation;
  Offset _offset = Offset(0.2, 0.6);


  @override
  void initState() {
    animationController =  AnimationController(vsync: this, duration: Duration(seconds: 1));
    sizeUpAnimation =  CurvedAnimation(parent: animationController, curve: Curves.easeOut);
    // RotationTransition(turns: Tween(begin: 0.0 , end: 1.0).animate(spinAnimation) ,child:ImageItem(imgRes: "assets/images/google_icon.png", type: ImageShapeType.FLAT,) ,);
    sizeUpAnimation.addListener(() => this.setState(() {}));
    // animationController.forward();
  }


  @override
  void dispose() {
    animationController?.dispose();
    super.dispose();
  }


  // Container( width: sizeUpAnimation.value * 250,
  // height: sizeUpAnimation.value * 250, child: ImageItem(imgRes: "assets/images/google_icon.png", type: ImageShapeType.FLAT,)))
  
  @override
  Widget build(BuildContext context) {
    return Scaffold(
            backgroundColor: Colors.blue,
            body: BlocBuilder<SplashBloc, SplashState>(
              builder: (context, state) {
                bool isLoading = state is SplashLoadInProgress;
                if(state is SplashLoadSuccess){
                  WidgetsBinding.instance.addPostFrameCallback((_) => Navigator.pop(context));
                }else if(state is SplashLoadFailure){
                  WidgetsBinding.instance.addPostFrameCallback((_) {
                    showToast(msg: "에러발생 다시 시도해주세요");
                    SystemNavigator.pop();
                  });
                }
                // return Center(
                //     child: GestureDetector(
                //       onPanUpdate: (details) => setState(() => _offset += details.delta),
                //       onDoubleTap: () => setState(() => _offset = Offset(0.2, 0.6)),
                //       child: Transform(
                //         transform: Matrix4.identity()
                //           ..setEntry(3, 2, 0.001)
                //           ..rotateX(0.01 * _offset.dy)
                //           ..rotateY(-0.01 * _offset.dx),
                //         alignment: FractionalOffset.center, child: Container(width:200 , height: 200,child: ImageItem(imgRes: "assets/images/google_icon.png", type: ImageShapeType.FLAT,)),),
                //     ));
                return LoadingIndicator(
                  isVisible: isLoading,
                  color: Colors.white,
                );
              },
            )
          );
  }
}
