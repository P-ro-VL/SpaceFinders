import 'package:flutter/material.dart';
import 'package:web/web.dart';

class PowerbiReportPage extends StatelessWidget {
  const PowerbiReportPage({super.key});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: MediaQuery.sizeOf(context).height,
      child: HtmlElementView.fromTagName(
        tagName: 'iframe',
        onElementCreated: (frame) {
          frame as HTMLIFrameElement;
          frame.src =
              'https://app.powerbi.com/reportEmbed?reportId=7d5f6d56-4630-403c-b4a0-bbaaea16868d&autoAuth=true';
          frame.style.width = '100%';
          frame.style.height = '80%';
        },
      ),
    );
  }
}
