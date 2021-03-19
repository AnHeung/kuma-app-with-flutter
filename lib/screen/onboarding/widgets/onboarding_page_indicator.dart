import 'dart:math';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:kuma_flutter_app/app_constants.dart';



class OnboardingPageIndicator extends StatelessWidget {
  final double angle;
  final int currentPage;
  final Widget child;

  const OnboardingPageIndicator({
    @required this.angle,
    @required this.currentPage,
    @required this.child,
  })  : assert(angle != null),
        assert(currentPage != null),
        assert(child != null);

  Color _getPageIndicatorColor(int pageIndex) {
    return currentPage > pageIndex ? kWhite : kWhite.withOpacity(0.25);
  }

  double get indicatorGap => pi / 12;
  double get indicatorLength => pi / 3;

  @override
  Widget build(BuildContext context) {
    return Container(
      child: CustomPaint(
        painter: _OnboardignPageIndicatorPainter(
          color: _getPageIndicatorColor(0),
          startAngle:
              (4 * indicatorLength) - (indicatorLength + indicatorGap) + angle,
          indicatorLength: indicatorLength,
        ),
        child: CustomPaint(
          painter: _OnboardignPageIndicatorPainter(
            color: _getPageIndicatorColor(1),
            startAngle: 4 * indicatorLength + angle,
            indicatorLength: indicatorLength,
          ),
          child: CustomPaint(
            painter: _OnboardignPageIndicatorPainter(
              color: _getPageIndicatorColor(2),
              startAngle: (4 * indicatorLength) +
                  (indicatorLength + indicatorGap) +
                  angle,
              indicatorLength: indicatorLength,
            ),
            child: child,
          ),
        ),
      ),
    );
  }
}

class _OnboardignPageIndicatorPainter extends CustomPainter {
  final Color color;
  final double startAngle;
  final double indicatorLength;

  const _OnboardignPageIndicatorPainter({
    @required this.color,
    @required this.startAngle,
    @required this.indicatorLength,
  })  : assert(color != null),
        assert(startAngle != null),
        assert(indicatorLength != null);

  @override
  void paint(Canvas canvas, Size size) {
    var paint = Paint()
      ..color = color
      ..style = PaintingStyle.stroke
      ..strokeWidth = 4.0;

    canvas.drawArc(
      Rect.fromCircle(
        center: Offset(size.width / 2, size.height / 2),
        radius: (size.shortestSide + 12.0) / 2,
      ),
      startAngle,
      indicatorLength,
      false,
      paint,
    );
  }

  @override
  bool shouldRepaint(_OnboardignPageIndicatorPainter oldDelegate) {
    return this.color != oldDelegate.color ||
        this.startAngle != oldDelegate.startAngle;
  }
}


class PieChart extends CustomPainter {

  int percentage = 0;
  double textScaleFactor = 1.0;

  @override
  void paint(Canvas canvas, Size size) {
  Paint paint = Paint() // 화면에 그릴 때 쓸 Paint를 정의합니다.
  ..color = Colors.orangeAccent
  ..strokeWidth = 10.0 // 선의 길이를 정합니다.
  ..style = PaintingStyle.stroke // 선의 스타일을 정합니다. stroke면 외곽선만 그리고, fill이면 다 채웁니다.
  ..strokeCap = StrokeCap.round; // stroke의 스타일을 정합니다. round를 고르면 stroke의 끝이 둥글게 됩니다.


  double radius = min(size.width / 2 - paint.strokeWidth / 2 , size.height / 2 - paint.strokeWidth/2); // 원의 반지름을 구함. 선의 굵기에 영향을 받지 않게 보정함.
  Offset center = Offset(size.width / 2, size.height/ 2); // 원이 위젯의 가운데에 그려지게 좌표를 정함.

  canvas.drawCircle(center, radius, paint); // 원을 그림.

  double arcAngle = 2 * pi * (percentage / 100); // 호(arc)의 각도를 정함. 정해진 각도만큼만 그리도록 함.

  paint..color = Colors.deepPurpleAccent; // 호를 그릴 때는 색을 바꿔줌.
  canvas.drawArc(Rect.fromCircle(center: center, radius: radius), -pi / 2, arcAngle, false, paint); // 호(arc)를 그림.

  drawText(canvas, size, "$percentage / 100"); // 텍스트를 화면에 표시함.
  }

  // 원의 중앙에 텍스트를 적음.
  void drawText(Canvas canvas, Size size, String text) {
  double fontSize = getFontSize(size, text);

  TextSpan sp = TextSpan(style: TextStyle(fontSize: fontSize, fontWeight: FontWeight.bold, color: Colors.black), text: text); // TextSpan은 Text위젯과 거의 동일하다.
  TextPainter tp = TextPainter(text: sp, textDirection: TextDirection.ltr);

  tp.layout(); // 필수! 텍스트 페인터에 그려질 텍스트의 크기와 방향를 정함.
  double dx = size.width / 2 - tp.width / 2;
  double dy = size.height / 2 - tp.height / 2;

  Offset offset = Offset(dx, dy);
  tp.paint(canvas, offset);
  }

  // 화면 크기에 비례하도록 텍스트 폰트 크기를 정함.
  double getFontSize(Size size, String text) {
  return size.width / text.length * textScaleFactor;
  }

  @override
  bool shouldRepaint(PieChart old) {
  return old.percentage != percentage;
  }
}