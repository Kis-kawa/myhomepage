import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:myhomepage/providers/locale_provider.dart';

class LanguageButton extends ConsumerWidget {
  const LanguageButton({super.key});

  Widget _buildLanguageItem({
    required BuildContext context,
    required String label,
    required bool isSelected,
    required VoidCallback onTap,
  }) {
    final activeColor = Theme.of(context).colorScheme.onSurface;
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(4),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 2),
        decoration: BoxDecoration(
          border: Border(
            bottom: BorderSide(
              color: isSelected ? activeColor : Colors.transparent,
              width: 2.0,
            ),
          ),
        ),
        child: Text(
          label,
          style: TextStyle(
            fontSize: 14,
            fontWeight: isSelected ? FontWeight.bold : FontWeight.w500,
            color: isSelected ? activeColor : Colors.grey,
            letterSpacing: 0.5,
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // 現在のLocaleを取得（未設定時は端末設定のLocaleを参照）
    final currentLocale = ref.watch(localeProvider) ?? Localizations.localeOf(context);
    final isJp = currentLocale.languageCode == 'jp' || currentLocale.languageCode == 'ja';
    final isEn = currentLocale.languageCode == 'en';

    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        _buildLanguageItem(
          context: context,
          label: 'JAPAN',
          isSelected: isJp,
          onTap: () {
            ref.read(localeProvider.notifier).setLocale('jp');
          },
        ),
        const Padding(
          padding: EdgeInsets.symmetric(horizontal: 6.0),
          child: Text(
            '/',
            style: TextStyle(
              fontSize: 14,
              color: Colors.grey,
              fontWeight: FontWeight.w300,
            ),
          ),
        ),
        _buildLanguageItem(
          context: context,
          label: 'GLOBAL',
          isSelected: isEn,
          onTap: () {
            ref.read(localeProvider.notifier).setLocale('en');
          },
        ),
      ],
    );
  }
}

