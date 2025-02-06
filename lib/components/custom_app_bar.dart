import 'package:flutter/material.dart';
import 'package:telepatia_ai/l10n/app_localizations.dart';

class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  const CustomAppBar({super.key});

  @override
  AppBar build(BuildContext context) {
    final colorScheme = Theme.of(context).colorScheme;

    return AppBar(
      title: Center(
        child: Text(
          AppLocalizations.of(context)!.appName,
          style: Theme.of(context).textTheme.titleLarge,
        )
      ),
      backgroundColor: colorScheme.surface,
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);
}
