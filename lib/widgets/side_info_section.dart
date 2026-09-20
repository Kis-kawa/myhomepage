import 'package:flutter/material.dart';
import 'package:myhomepage/l10n/l10n.dart';
import 'package:web/web.dart' as web;

class SideInfoSection extends StatelessWidget {
  final double width;

  const SideInfoSection({
    super.key,
    required this.width,
  });

  Widget _buildCard({
    required BuildContext context,
    required List<Widget> children,
  }) {
    final theme = Theme.of(context);

    return Container(
      width: width,
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
      decoration: BoxDecoration(
        color: theme.scaffoldBackgroundColor,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.05),
            blurRadius: 8,
            offset: const Offset(0, 3),
          ),
        ],
        border: Border.all(
          color: theme.colorScheme.outlineVariant.withValues(alpha: 0.3),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: children,
      ),
    );
  }

  Widget _buildHeader({
    required BuildContext context,
    required String title,
  }) {
    final theme = Theme.of(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            letterSpacing: 1.0,
            color: theme.colorScheme.onSurface,
          ),
        ),
        const SizedBox(height: 8),
        Divider(
          thickness: 1.5,
          color: theme.colorScheme.primary.withValues(alpha: 0.6),
        ),
        const SizedBox(height: 12),
      ],
    );
  }

  Widget _buildSubHeader({
    required BuildContext context,
    required String title,
  }) {
    final theme = Theme.of(context);

    return Padding(
      padding: const EdgeInsets.only(top: 8, bottom: 4),
      child: Text(
        title,
        style: TextStyle(
          fontSize: 14,
          fontWeight: FontWeight.w700,
          color: theme.colorScheme.primary,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final l10n = L10n.of(context)!;
    final theme = Theme.of(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // 1. リンク & 連絡先
        _buildCard(
          context: context,
          children: [
            _buildHeader(
              context: context,
              title: l10n.linksSectionTitle,
            ),
            _buildSubHeader(
              context: context,
              title: l10n.githubLabel,
            ),
            InkWell(
              onTap: () {
                web.window.open('https://github.com/Kis-kawa', '_blank');
              },
              borderRadius: BorderRadius.circular(6),
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 2),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Flexible(
                      child: Text(
                        "Kis-kawa",
                        style: TextStyle(
                          fontSize: 14,
                          color: theme.colorScheme.primary,
                          decoration: TextDecoration.underline,
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                    const SizedBox(width: 4),
                    Icon(
                      Icons.open_in_new,
                      size: 14,
                      color: theme.colorScheme.primary,
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 8),
            _buildSubHeader(
              context: context,
              title: l10n.emailLabel,
            ),
            InkWell(
              onTap: () {
                web.window.open('mailto:${l10n.renrakuMail}', '_self');
              },
              borderRadius: BorderRadius.circular(6),
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 2),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: Text(
                        l10n.renrakuMail,
                        style: TextStyle(
                          fontSize: 13,
                          color: theme.colorScheme.onSurface,
                          decoration: TextDecoration.underline,
                          height: 1.4,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),

        const SizedBox(height: 24),

        // 2. 自己紹介
        _buildCard(
          context: context,
          children: [
            _buildHeader(
              context: context,
              title: l10n.aboutMeSectionTitle,
            ),
            Text(
              l10n.aboutMeBody,
              style: TextStyle(
                fontSize: 14,
                height: 1.7,
                color: theme.colorScheme.onSurface,
                letterSpacing: 0.3,
              ),
            ),
          ],
        ),
      ],
    );
  }
}
