import 'package:flutter/material.dart';
import 'package:gpt_markdown/gpt_markdown.dart';

class MarkdownPreview extends StatelessWidget {
  const MarkdownPreview({super.key, required this.markdown});

  final String markdown;

  @override
  Widget build(BuildContext context) {
    if (markdown.trim().isEmpty) {
      return Center(
        child: Text(
          '预览区域会随着 Markdown 源码实时刷新',
          style: Theme.of(
            context,
          ).textTheme.bodyMedium?.copyWith(color: const Color(0xFF94A3B8)),
        ),
      );
    }

    final textTheme = Theme.of(context).textTheme;
    return SelectionArea(
      child: SingleChildScrollView(
        padding: const EdgeInsets.fromLTRB(32, 32, 32, 56),
        child: DefaultTextStyle.merge(
          style: textTheme.bodyLarge?.copyWith(
            color: const Color(0xFF334155),
            fontSize: 16,
            height: 1.8,
          ),
          child: GptMarkdown(
            markdown,
            followLinkColor: true,
            useDollarSignsForLatex: true,
            style: textTheme.bodyLarge?.copyWith(
              color: const Color(0xFF334155),
              fontSize: 16,
              height: 1.8,
            ),
            onLinkTap: (url, title) {},
          ),
        ),
      ),
    );
  }
}
