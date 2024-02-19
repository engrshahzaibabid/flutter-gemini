import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:markdown/markdown.dart' as md;
import 'package:url_launcher/url_launcher.dart';

import '../../../constants/colors.dart';

class MessageTile extends StatelessWidget {
  const MessageTile({super.key, required this.sendByMe, required this.message});

  final bool sendByMe;
  final String message;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Column(
      crossAxisAlignment:
          sendByMe ? CrossAxisAlignment.end : CrossAxisAlignment.start,
      children: [
        Text(
          sendByMe ? 'You' : 'AI Model',
          style: const TextStyle(fontSize: 11.5, color: Colors.grey),
        ),
        const SizedBox(
          height: 5,
        ),
        Row(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              width: size.width / 1.3,
              padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 13),
              decoration: BoxDecoration(
                  color:
                      sendByMe ? MyColors.primaryColor : Colors.grey.shade200,
                  borderRadius: BorderRadius.only(
                    bottomLeft: sendByMe
                        ? const Radius.circular(12)
                        : const Radius.circular(5),
                    topLeft: const Radius.circular(12),
                    topRight: const Radius.circular(12),
                    bottomRight: sendByMe
                        ? const Radius.circular(5)
                        : const Radius.circular(12),
                  )),
              child: MarkdownBody(
                  selectable: true,
                  data: message,
                  extensionSet: md.ExtensionSet(
                    md.ExtensionSet.gitHubFlavored.blockSyntaxes,
                    <md.InlineSyntax>[
                      md.EmojiSyntax(),
                      ...md.ExtensionSet.gitHubFlavored.inlineSyntaxes
                    ],
                  ),
                  onTapLink: (text, href, title) async {
                    await _launchUrl(text);
                  },
                  styleSheet: MarkdownStyleSheet.fromTheme(ThemeData(
                      textTheme: TextTheme(
                          bodyMedium: GoogleFonts.lexend(
                    fontSize: 14,
                    color: sendByMe ? Colors.white : Colors.black87,
                  ))))),
            ),
            if (!sendByMe) ...[
              // const SizedBox(
              //   width: 8,
              // ),
              IconButton(
                  onPressed: () async {
                    await Clipboard.setData(ClipboardData(text: message, ));
                  },
                  icon: Icon(Icons.file_copy_outlined, color: Colors.grey.shade300, size: 20,)),
              // Icon(
              //   Icons.file_copy_outlined,
              //   color: Colors.grey.shade300,
              //   size: 20,
              // )
            ]
          ],
        ),
      ],
    );
  }

  Future<void> _launchUrl(String url) async {
    if (!await launchUrl(Uri.parse(url))) {
      throw Exception('Could not launch $url');
    }
  }
}

