// lib/utils/dashed_line.dart
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;

class DashedLine extends pw.StatelessWidget {
  final double dash;
  final double gap;
  final double width;
  final double height;
  final PdfColor color;

  DashedLine({
    this.dash = 3,
    this.gap = 2,
    required this.width,
    required this.height,
    required this.color,
  });

  @override
  pw.Widget build(pw.Context context) {
    return pw.Container(
      width: width,
      height: height,
      child: pw.Row(
        children: List.generate(
          (width / (dash + gap)).floor(),
          (index) => pw.Container(
            width: dash,
            height: height,
            color: color,
            margin: pw.EdgeInsets.only(right: gap),
          ),
        ),
      ),
    );
  }
}
