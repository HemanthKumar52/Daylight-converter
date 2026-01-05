import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../models/timezone_item.dart';
import '../utils/theme_colors.dart';
import 'package:timezone/timezone.dart' as tz;

class TimeSlider extends StatefulWidget {
  final double hourOffset;
  final ValueChanged<double> onHourOffsetChanged;
  final TimeZoneItem? homeTimeZone;
  final ThemeColors theme;

  const TimeSlider({
    super.key,
    required this.hourOffset,
    required this.onHourOffsetChanged,
    required this.homeTimeZone,
    required this.theme,
  });

  @override
  State<TimeSlider> createState() => _TimeSliderState();
}

class _TimeSliderState extends State<TimeSlider> {
  bool isDragging = false;
  double dragStartOffset = 0;
  int lastHapticHour = 0;

  double get currentHomeHour {
    if (widget.homeTimeZone == null) return 12;
    final now = DateTime.now().toUtc();
    final zonedDate = tz.TZDateTime.from(now, widget.homeTimeZone!.location);
    return zonedDate.hour + zonedDate.minute / 60.0;
  }
  
  String formatTimeLabel() {
    if (widget.homeTimeZone != null) {
      return widget.homeTimeZone!.formattedTime(offsetBy: widget.hourOffset);
    }
    final hours = widget.hourOffset.round();
    final label = hours > 0 ? "later" : "earlier";
    return "${hours.abs()}h $label";
  }

  @override
  Widget build(BuildContext context) {
    const trackPadding = 25.5;
    const knobWidth = 38.0;
    
    return LayoutBuilder(builder: (context, constraints) {
      final sliderWidth = constraints.maxWidth;
      final trackWidth = sliderWidth - (trackPadding * 2);
      final centerX = trackWidth / 2;
      final pixelsPerHour = trackWidth / 24.0;
      final knobX = centerX + (widget.hourOffset * pixelsPerHour);

      return GestureDetector(
        onDoubleTap: () {
             widget.onHourOffsetChanged(0);
        },
        child: Container(
          height: 161,
          padding: const EdgeInsets.symmetric(horizontal: 12),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
               // Label
               Row(
                 mainAxisAlignment: MainAxisAlignment.center,
                 children: [
                   Text(
                     (widget.hourOffset.abs() < 0.01) ? "Now" : formatTimeLabel(),
                     style: const TextStyle(
                       fontSize: 18,
                       fontWeight: FontWeight.w900,
                       color: Color(0xFFFF9900), // Gradient text difficult in Flutter simple Text, using solid color for this step
                     ),
                   ),
                   if (widget.hourOffset.abs() >= 0.01)
                     Padding(
                       padding: const EdgeInsets.only(left: 8.0),
                       child: GestureDetector(
                         onTap: () => widget.onHourOffsetChanged(0),
                         child: Icon(Icons.cancel, color: widget.theme.closeButton, size: 16),
                       ),
                     )
                 ],
               ),
               const SizedBox(height: 8),
               
               // Track
               SizedBox(
                 width: trackWidth,
                 height: 24,
                 child: Stack(
                   alignment: Alignment.centerLeft,
                   clipBehavior: Clip.none,
                   children: [
                     CustomPaint(
                       size: Size(trackWidth, 6),
                       painter: SliderTrackPainter(
                         currentHour: currentHomeHour,
                         pixelsPerHour: pixelsPerHour,
                         centerX: centerX,
                         trackWidth: trackWidth,
                         theme: widget.theme,
                       ),
                     ),
                     Positioned(
                       left: knobX - (knobWidth / 2),
                       top: -9, // (24 - 6)/2 = 9? No 24 height. Knob height 24. Track height 6. (24-6)/2 = 9.
                       child: GestureDetector(
                         onHorizontalDragStart: (details) {
                           setState(() {
                             isDragging = true;
                             dragStartOffset = widget.hourOffset;
                           });
                         },
                         onHorizontalDragUpdate: (details) {
                             final dragHours = details.primaryDelta! / pixelsPerHour;
                             // We accumulate change
                             // Actually better to use local position difference?
                             // But widget.hourOffset is state from parent.
                             // Let's implement relative drag.
                             
                             double newOffset = widget.hourOffset + dragHours;
                             newOffset = newOffset.clamp(-12.0, 12.0);
                             
                             // Snap logic
                             final currentMinuteFraction = DateTime.now().minute / 60.0;
                             final targetTime = currentMinuteFraction + newOffset;
                             final snappedTarget = (targetTime * 4).round() / 4.0;
                             final snappedOffset = snappedTarget - currentMinuteFraction;
                             
                             // Haptic
                             final currentInterval = (snappedOffset * 4).round();
                             if (currentInterval != lastHapticHour) {
                               HapticFeedback.selectionClick();
                               lastHapticHour = currentInterval;
                             }
                             
                             widget.onHourOffsetChanged(snappedOffset);
                         },
                         onHorizontalDragEnd: (details) {
                           setState(() {
                             isDragging = false;
                           });
                         },
                         child: _buildKnob(),
                       )
                     )
                   ],
                 ),
               ),
               
               // Ticks
               const SizedBox(height: 8),
               SizedBox(
                 width: trackWidth,
                 height: 4,
                 child: CustomPaint(
                    painter: TickPainter(trackWidth: trackWidth, knobX: knobX, theme: widget.theme),
                 ),
               ),
               
               // Current Time
               const SizedBox(height: 8),
               if (widget.homeTimeZone != null)
                 Row(
                   mainAxisAlignment: MainAxisAlignment.center,
                   children: [
                     Icon(Icons.navigation, size: 14, color: widget.theme.sliderText),
                     const SizedBox(width: 4),
                     Text(
                       widget.homeTimeZone!.formattedTime(offsetBy: 0),
                       style: TextStyle(fontSize: 18, fontWeight: FontWeight.w300, color: widget.theme.sliderText),
                     ),
                   ],
                 ),
                const SizedBox(height: 16),
            ],
          ),
        ),
      );
    });
  }

  Widget _buildKnob() {
     return Container(
       width: 38,
       height: 24,
       decoration: BoxDecoration(
         color: isDragging ? Colors.white.withOpacity(0.6) : Colors.white,
         borderRadius: BorderRadius.circular(12),
         boxShadow: [
           BoxShadow(
             color: isDragging ? const Color(0xFFFF9900).withOpacity(0.4) : Colors.black.withOpacity(0.12),
             blurRadius: isDragging ? 8 : 6.5,
             offset: Offset(0, isDragging ? 0 : 3),
           )
         ],
         border: Border.all(color: Colors.white.withOpacity(0.8), width: 1),
       ),
     );
  }
}

class SliderTrackPainter extends CustomPainter {
  final double currentHour;
  final double pixelsPerHour;
  final double centerX;
  final double trackWidth;
  final ThemeColors theme;

  SliderTrackPainter({
    required this.currentHour,
    required this.pixelsPerHour,
    required this.centerX,
    required this.trackWidth,
    required this.theme,
  });

  @override
  void paint(Canvas canvas, Size size) {
    // Center the track vertically
    final trackY = (size.height - 6) / 2;
    final trackRect = Rect.fromLTWH(0, trackY, trackWidth, 6);
    final trackRRect = RRect.fromRectAndRadius(trackRect, const Radius.circular(3));
    
    // Draw Night Background
    final nightPaint = Paint()..color = theme.nightBlock;
    canvas.drawRRect(trackRRect, nightPaint);

    // Calculate Segments
    final segments = _calculateDaySegments();
    
    final dayPaint = Paint()
      ..shader = const LinearGradient(colors: [ThemeColors.daylightStart, ThemeColors.daylightEnd])
          .createShader(trackRect);
          
    for (final segment in segments) {
       final startX = max(0.0, segment.startX);
       final endX = min(trackWidth, segment.endX);
       final width = endX - startX;
       
       if (width > 0) {
         final dayRect = Rect.fromLTWH(startX, trackY, width, 6);
         
         // Corner radii
         // If startX <= 0, left corners rounded
         // If endX >= trackWidth, right corners rounded
         // Else flat
         final leftRadius = startX <= 0 ? const Radius.circular(3) : Radius.zero;
         final rightRadius = endX >= trackWidth ? const Radius.circular(3) : Radius.zero;
         
         final dayRRect = RRect.fromRectAndCorners(
           dayRect,
           topLeft: leftRadius, bottomLeft: leftRadius,
           topRight: rightRadius, bottomRight: rightRadius,
         );
         
         canvas.drawRRect(dayRRect, dayPaint);
       }
    }
  }

  List<_DaySegment> _calculateDaySegments() {
    List<_DaySegment> segments = [];
    for (int dayOffset = -1; dayOffset <= 1; dayOffset++) {
       final dayOffsetHours = dayOffset * 24.0;
       final dayStart = 6.0 + dayOffsetHours;
       final dayEnd = 18.0 + dayOffsetHours;
       
       final hoursToStart = dayStart - currentHour;
       final hoursToEnd = dayEnd - currentHour;
       
       if (hoursToEnd >= -12 && hoursToStart <= 12) {
         final clampedStart = max(-12.0, hoursToStart);
         final clampedEnd = min(12.0, hoursToEnd);
         
         final startX = centerX + clampedStart * pixelsPerHour;
         final endX = centerX + clampedEnd * pixelsPerHour;
         
         if (endX > startX) {
           segments.add(_DaySegment(startX, endX));
         }
       }
    }
    return segments;
  }

  @override
  bool shouldRepaint(covariant SliderTrackPainter oldDelegate) {
     return oldDelegate.currentHour != currentHour || oldDelegate.theme != theme;
  }
}

class TickPainter extends CustomPainter {
  final double trackWidth;
  final double knobX;
  final ThemeColors theme;

  TickPainter({required this.trackWidth, required this.knobX, required this.theme});

  @override
  void paint(Canvas canvas, Size size) {
    final totalTicks = 17;
    for (int i = 0; i < totalTicks; i++) {
       final isMajor = i % 2 == 0;
       final tickX = i * (trackWidth / (totalTicks - 1));
       final isAtKnob = (tickX - knobX).abs() < (trackWidth / (totalTicks - 1) / 2);
       
       final paint = Paint()
         ..color = isAtKnob ? const Color(0xFFFF9900) : theme.tickMark
         ..style = PaintingStyle.fill;
         
       if (!isAtKnob && !isMajor) paint.color = paint.color.withOpacity(0.5);
       
       canvas.drawCircle(Offset(tickX, size.height / 2), isMajor ? 2 : 2, paint);
    } 
  }

  @override
  bool shouldRepaint(covariant TickPainter oldDelegate) {
    return oldDelegate.knobX != knobX;
  }
}

class _DaySegment {
  final double startX;
  final double endX;
  _DaySegment(this.startX, this.endX);
}
