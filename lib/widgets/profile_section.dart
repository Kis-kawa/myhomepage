import 'package:flutter/material.dart';
import 'package:myhomepage/l10n/l10n.dart';

class ProfileSection extends StatelessWidget {
  final double width;

  const ProfileSection({
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
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 22),
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
            fontSize: 20,
            fontWeight: FontWeight.bold,
            letterSpacing: 1.0,
            color: theme.colorScheme.onSurface,
          ),
        ),
        const SizedBox(height: 8),
        Divider(
          thickness: 1.5,
          color: theme.colorScheme.primary.withValues(alpha: 0.4),
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
      padding: const EdgeInsets.only(top: 10, bottom: 6),
      child: Text(
        title,
        style: TextStyle(
          fontSize: 15,
          fontWeight: FontWeight.w700,
          color: theme.colorScheme.primary,
        ),
      ),
    );
  }

  Widget _buildBulletItem({
    required BuildContext context,
    required String text,
  }) {
    final theme = Theme.of(context);

    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(top: 7, right: 10, left: 4),
            child: Container(
              width: 6,
              height: 6,
              decoration: BoxDecoration(
                color: theme.colorScheme.primary.withValues(alpha: 0.8),
                shape: BoxShape.circle,
              ),
            ),
          ),
          Expanded(
            child: Text(
              text,
              style: TextStyle(
                fontSize: 14,
                height: 1.55,
                color: theme.colorScheme.onSurface,
              ),
            ),
          ),
        ],
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
        // 1. プロフィール基本情報
        _buildCard(
          context: context,
          children: [
            _buildHeader(
              context: context,
              title: l10n.profileSectionTitle,
            ),
            _buildSubHeader(
              context: context,
              title: l10n.profileNameLabel,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 14, bottom: 8),
              child: Text(
                l10n.profileNameValue,
                style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.w600,
                  color: theme.colorScheme.onSurface,
                ),
              ),
            ),
            _buildSubHeader(
              context: context,
              title: l10n.profileEducationLabel,
            ),
            _buildBulletItem(
              context: context,
              text: l10n.profileEdu1,
            ),
            _buildBulletItem(
              context: context,
              text: l10n.profileEdu2,
            ),
            _buildSubHeader(
              context: context,
              title: l10n.profileInternshipLabel,
            ),
            _buildBulletItem(
              context: context,
              text: l10n.profileIntern1,
            ),
            _buildBulletItem(
              context: context,
              text: l10n.profileIntern2,
            ),
          ],
        ),

        const SizedBox(height: 24),

        // 2. 課外活動
        _buildCard(
          context: context,
          children: [
            _buildHeader(
              context: context,
              title: l10n.activitiesSectionTitle,
            ),
            _buildBulletItem(
              context: context,
              text: l10n.activity1,
            ),
            _buildBulletItem(
              context: context,
              text: l10n.activity2,
            ),
            _buildBulletItem(
              context: context,
              text: l10n.activity3,
            ),
            _buildBulletItem(
              context: context,
              text: l10n.activity4,
            ),
            _buildBulletItem(
              context: context,
              text: l10n.activity5,
            ),
            _buildBulletItem(
              context: context,
              text: l10n.activity6,
            ),
            _buildBulletItem(
              context: context,
              text: l10n.activity7,
            ),
          ],
        ),

        const SizedBox(height: 24),

        // 3. 部活動
        _buildCard(
          context: context,
          children: [
            _buildHeader(
              context: context,
              title: l10n.clubSectionTitle,
            ),
            _buildBulletItem(
              context: context,
              text: l10n.clubActivity1,
            ),
            _buildBulletItem(
              context: context,
              text: l10n.clubActivity2,
            ),
            _buildBulletItem(
              context: context,
              text: l10n.clubActivity3,
            ),
            _buildBulletItem(
              context: context,
              text: l10n.clubActivity4,
            ),
            _buildBulletItem(
              context: context,
              text: l10n.clubActivity5,
            ),
            _buildBulletItem(
              context: context,
              text: l10n.clubActivity6,
            ),
          ],
        ),
      ],
    );
  }
}
