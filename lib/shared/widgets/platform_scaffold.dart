import 'package:flutter/foundation.dart' show kIsWeb, defaultTargetPlatform, TargetPlatform;
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

/// Platform-aware scaffold that adapts to iOS and Android
class PlatformScaffold extends StatelessWidget {
  final String? title;
  final Widget? titleWidget;
  final Widget body;
  final Widget? bottomNavigationBar;
  final Widget? floatingActionButton;
  final List<Widget>? actions;
  final Widget? leading;
  final bool showBackButton;

  const PlatformScaffold({
    super.key,
    this.title,
    this.titleWidget,
    required this.body,
    this.bottomNavigationBar,
    this.floatingActionButton,
    this.actions,
    this.leading,
    this.showBackButton = true,
  });

  Widget? get _titleWidget {
    if (titleWidget != null) return titleWidget;
    if (title != null) return Text(title!);
    return null;
  }

  @override
  Widget build(BuildContext context) {
    final resolvedTitle = _titleWidget;

    if (!kIsWeb && defaultTargetPlatform == TargetPlatform.iOS) {
      return CupertinoPageScaffold(
        navigationBar: resolvedTitle != null
            ? CupertinoNavigationBar(
                middle: resolvedTitle,
                trailing: actions != null
                    ? Row(
                        mainAxisSize: MainAxisSize.min,
                        children: actions!,
                      )
                    : null,
                leading: leading,
                automaticallyImplyLeading: showBackButton,
              )
            : null,
        child: SafeArea(child: body),
      );
    }

    return Scaffold(
      appBar: resolvedTitle != null
          ? AppBar(
              title: resolvedTitle,
              actions: actions,
              leading: leading,
              automaticallyImplyLeading: showBackButton,
            )
          : null,
      body: body,
      bottomNavigationBar: bottomNavigationBar,
      floatingActionButton: floatingActionButton,
    );
  }
}
