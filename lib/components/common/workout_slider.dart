import 'package:flutter/material.dart';
import 'package:vibration/vibration.dart';

class WorkoutSlider extends StatefulWidget {
  const WorkoutSlider({super.key});

  @override
  State<WorkoutSlider> createState() => _SliderWorkoutState();
}

class _SliderWorkoutState extends State<WorkoutSlider> with SingleTickerProviderStateMixin {
  static const double initialValue = .5;
  static const divisions = 5;
  static const min = 0;
  static const max = 1;
  double currentValue = initialValue;

  bool hasClosestVibrated = false;

  late AnimationController _controller;
  @override
  void initState() {
    _controller = AnimationController(vsync: this, duration: const Duration(milliseconds: 40));

    _controller.addListener(() {
      setState(() {
        currentValue = _controller.value;
      });
    });
    super.initState();
  }

  _getClosestDivision(double value) {
    return (currentValue * divisions).roundToDouble() / divisions;
  }

  _getNewValue(double deltaY) {
    double newValue = deltaY / 240 + currentValue;
    if (newValue < min) {
      newValue = min.toDouble();
    } else if (newValue > max) {
      newValue = max.toDouble();
    }
    return newValue;
  }
  _divisionVibrate() async {
    bool? hasVibrator = await Vibration.hasVibrator();
    if (hasVibrator == null || !hasVibrator) return;

    bool? hasAmplitude = await Vibration.hasCustomVibrationsSupport();
    if (hasAmplitude == null || !hasAmplitude) return;

    Vibration.vibrate(amplitude: 255, duration: 25);
  }

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(20),
      child: SizedBox(
        width: 105,
        height: 240,
        child: GestureDetector(
          onVerticalDragUpdate: (details) {
            setState(() {
              currentValue = _getNewValue(details.delta.dy);
              double closest = _getClosestDivision(currentValue);
              double distanceToClosest = (closest - currentValue).abs();
              if (distanceToClosest < .005) {
                if (!hasClosestVibrated) {
                  _divisionVibrate();
                  hasClosestVibrated = true;
                }
              }else {
                hasClosestVibrated = false;
              }
              _controller.value = currentValue;
            });
          },
          onVerticalDragEnd: (details) {
            setState(() {
              _controller.animateTo(_getClosestDivision(currentValue), duration: const Duration(milliseconds: 200), curve: Curves.linear);
            });
            _divisionVibrate();
          },
          child: CustomPaint(
            painter: SliderPainter(currentValue: currentValue, divisions: divisions),
        ),
      ),
      ),
    );
  }
}

class SliderPainter extends CustomPainter {
  double currentValue;
  int divisions;
  SliderPainter({required this.currentValue, this.divisions = 5});

  @override
  void paint(Canvas canvas, Size size) {
    // Paints
    var inactiveTrackPaint = Paint()..color = Colors.grey.shade300;
    var activeTrackPaint = Paint()..color = Colors.grey.shade200;
    var divisionPaint = Paint()..color = Colors.grey.shade400;

    var centerX = size.width / 2;

    // Render Inactive Track
    canvas.drawRect(Rect.fromLTRB(0, 0, size.width, size.height), inactiveTrackPaint);

    // Render Active Track
    canvas.drawRect(Rect.fromLTRB(0, currentValue * size.height, size.width, size.height), activeTrackPaint);


    // Render divisions
    for (var i = 1; i < divisions; i++) {
      var divisionY = size.height / divisions * i;
      canvas.drawRRect(RRect.fromRectAndRadius(Rect.fromCenter(center: Offset(centerX, divisionY), width: size.width * 0.5, height: 10), Radius.circular(10)), divisionPaint);
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
  
}