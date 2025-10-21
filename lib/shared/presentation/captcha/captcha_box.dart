import 'dart:math';


import 'package:flutter_clean_riverpod/core/constants/colors.dart';
import 'package:flutter_clean_riverpod/core/constants/dimensions.dart';
import 'package:flutter_clean_riverpod/shared/presentation/widgets/primary_rectangle.dart';
import 'package:flutter/material.dart';

class CaptchaBox extends StatefulWidget {
  const CaptchaBox(this.captchaText, {super.key});

  final String captchaText;

  @override
  _CaptchaBoxState createState() => _CaptchaBoxState();
}

class _CaptchaBoxState extends State<CaptchaBox> {
  late List<Offset> _lines;

  @override
  void initState() {
    super.initState();
    _lines = _generateLines();
  }

  List<Offset> _generateLines() {
    final random = Random();
    final lines = <Offset>[];
    for (int i = 0; i < 5; i++) {
      final startX = random.nextDouble() * 260;
      final startY = random.nextDouble() * 56;
      final endX = random.nextDouble() * 260;
      final endY = random.nextDouble() * 56;
      lines
        ..add(Offset(startX, startY))
        ..add(Offset(endX, endY));
    }
    return lines;
  }

  @override
  Widget build(BuildContext context) {
    return PrimaryRectangle(
      borderColor: cIcon,
      radius: 4,
      height: 56,
      color: cGrey,
      padding: const EdgeInsets.all(dimen8),
      child: CustomPaint(
        painter: CaptchaPainter(widget.captchaText, _lines),
      ),
    );
  }
}

class CaptchaPainter extends CustomPainter {
  CaptchaPainter(this.text, this.lines);

  final String text;
  final List<Offset> lines;

  @override
  void paint(Canvas canvas, Size size) {
    // Draw background lines first
    final linePaint = Paint()
      ..color = cSecondary
      ..strokeWidth = 3.0;

    for (int i = 0; i < lines.length; i += 2) {
      canvas.drawLine(lines[i], lines[i + 1], linePaint);
    }

    double fontSize = 32;
    TextStyle textStyle = TextStyle(
      fontSize: fontSize,
      fontWeight: FontWeight.bold,
      color: Colors.black,
    );

    final List<TextPainter> charPainters = [];
    double totalWidth = 0;

    for (int i = 0; i < text.length; i++) {
      final char = text[i];
      final charSpan = TextSpan(text: char, style: textStyle);
      final charPainter = TextPainter(
        text: charSpan,
        textDirection: TextDirection.ltr,
      )

      ..layout();
      charPainters.add(charPainter);
      totalWidth += charPainter.width + 2;
    }

    totalWidth -= 2;

    while (totalWidth > size.width && fontSize > 8) {
      fontSize -= 1;
      textStyle = textStyle.copyWith(fontSize: fontSize);
      totalWidth = 0;

      for (int i = 0; i < text.length; i++) {
        charPainters[i].text = TextSpan(text: text[i], style: textStyle);
        charPainters[i].layout();
        totalWidth += charPainters[i].width + 2;
      }
      totalWidth -= 2;
    }

    final startX = (size.width - totalWidth) / 2;
    final startY = (size.height - charPainters[0].height) / 2;

    double currentX = startX;
    for (int i = 0; i < charPainters.length; i++) {
      final charPainter = charPainters[i];
      final y = startY + sin(i * 0.5) * 5;

      charPainter.paint(canvas, Offset(currentX, y));
      currentX += charPainter.width + 2;
    }
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return false;
  }
}
