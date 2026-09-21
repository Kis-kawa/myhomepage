import 'package:flutter/material.dart';
import 'package:web/web.dart' as web;

class WorkItem {
  final String title;
  final String description;
  final String? imageAsset;
  final List<String> techStack;
  final String? externalUrl;
  final String? githubUrl;
  final bool isComingSoon;

  const WorkItem({
    required this.title,
    required this.description,
    this.imageAsset,
    this.techStack = const [],
    this.externalUrl,
    this.githubUrl,
    this.isComingSoon = false,
  });
}

class WorkCard extends StatefulWidget {
  final WorkItem item;

  const WorkCard({
    super.key,
    required this.item,
  });

  @override
  State<WorkCard> createState() => _WorkCardState();
}

class _WorkCardState extends State<WorkCard> {
  bool _isHovered = false;

  void _showDetailDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => WorkDetailDialog(item: widget.item),
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return MouseRegion(
      cursor: SystemMouseCursors.click,
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      child: GestureDetector(
        onTap: () => _showDetailDialog(context),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(14),
            border: Border.all(
              color: _isHovered
                  ? theme.colorScheme.primary
                  : theme.colorScheme.outlineVariant.withValues(alpha: 0.3),
              width: _isHovered ? 2 : 1,
            ),
            boxShadow: [
              BoxShadow(
                color: _isHovered
                    ? theme.colorScheme.primary.withValues(alpha: 0.2)
                    : Colors.black.withValues(alpha: 0.08),
                blurRadius: _isHovered ? 16 : 8,
                offset: Offset(0, _isHovered ? 6 : 3),
              ),
            ],
          ),
          child: ClipRRect(
            borderRadius: BorderRadius.circular(13),
            child: AspectRatio(
              aspectRatio: 16 / 9,
              child: Stack(
                fit: StackFit.expand,
                children: [
                  // サムネイル画像またはComing Soon背景
                  if (widget.item.imageAsset != null)
                    Image.asset(
                      widget.item.imageAsset!,
                      fit: BoxFit.cover,
                    )
                  else
                    _buildPlaceholder(context),

                  // ホバー時のオーバーレイ効果
                  AnimatedContainer(
                    duration: const Duration(milliseconds: 200),
                    color: _isHovered
                        ? Colors.black.withValues(alpha: 0.15)
                        : Colors.transparent,
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildPlaceholder(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: isDark
              ? [
                  const Color(0xFF1E293B),
                  const Color(0xFF0F172A),
                ]
              : [
                  const Color(0xFFE2E8F0),
                  const Color(0xFFCBD5E1),
                ],
        ),
      ),
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.rocket_launch_outlined,
              size: 36,
              color: theme.colorScheme.primary.withValues(alpha: 0.8),
            ),
            const SizedBox(height: 8),
            Text(
              "COMING SOON",
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.bold,
                letterSpacing: 2.0,
                color: theme.colorScheme.onSurface.withValues(alpha: 0.7),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class WorkDetailDialog extends StatelessWidget {
  final WorkItem item;

  const WorkDetailDialog({
    super.key,
    required this.item,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    return Dialog(
      backgroundColor: theme.scaffoldBackgroundColor,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      insetPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 24),
      child: ConstrainedBox(
        constraints: const BoxConstraints(
          maxWidth: 560,
          maxHeight: 700,
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(16),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.min,
              children: [
                // 1. 上部サムネイル
                Stack(
                  children: [
                    AspectRatio(
                      aspectRatio: 16 / 9,
                      child: item.imageAsset != null
                          ? Image.asset(
                              item.imageAsset!,
                              fit: BoxFit.cover,
                            )
                          : Container(
                              decoration: BoxDecoration(
                                gradient: LinearGradient(
                                  begin: Alignment.topLeft,
                                  end: Alignment.bottomRight,
                                  colors: isDark
                                      ? [
                                          const Color(0xFF1E293B),
                                          const Color(0xFF0F172A),
                                        ]
                                      : [
                                          const Color(0xFFE2E8F0),
                                          const Color(0xFFCBD5E1),
                                        ],
                                ),
                              ),
                              child: Center(
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Icon(
                                      Icons.rocket_launch_outlined,
                                      size: 44,
                                      color: theme.colorScheme.primary,
                                    ),
                                    const SizedBox(height: 8),
                                    Text(
                                      "COMING SOON",
                                      style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold,
                                        letterSpacing: 2.5,
                                        color: theme.colorScheme.onSurface
                                            .withValues(alpha: 0.8),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                    ),
                    Positioned(
                      top: 8,
                      right: 8,
                      child: CircleAvatar(
                        backgroundColor: Colors.black.withValues(alpha: 0.5),
                        radius: 18,
                        child: IconButton(
                          padding: EdgeInsets.zero,
                          icon: const Icon(Icons.close, size: 20, color: Colors.white),
                          onPressed: () => Navigator.of(context).pop(),
                        ),
                      ),
                    ),
                  ],
                ),

                Padding(
                  padding: const EdgeInsets.all(24),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // 2. タイトル
                      Text(
                        item.title,
                        style: TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                          color: theme.colorScheme.onSurface,
                        ),
                      ),
                      const SizedBox(height: 14),

                      // 3. 使用した技術（タグ）
                      if (item.techStack.isNotEmpty) ...[
                        Wrap(
                          spacing: 8,
                          runSpacing: 8,
                          children: item.techStack.map((tech) {
                            return Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 10,
                                vertical: 4,
                              ),
                              decoration: BoxDecoration(
                                color: theme.colorScheme.primary
                                    .withValues(alpha: 0.12),
                                borderRadius: BorderRadius.circular(6),
                                border: Border.all(
                                  color: theme.colorScheme.primary
                                      .withValues(alpha: 0.35),
                                ),
                              ),
                              child: Text(
                                tech,
                                style: TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w600,
                                  color: theme.colorScheme.primary,
                                ),
                              ),
                            );
                          }).toList(),
                        ),
                        const SizedBox(height: 18),
                      ],

                      // 4. 外部リンク / 遷移リンク
                      if (item.externalUrl != null || item.githubUrl != null) ...[
                        Row(
                          children: [
                            if (item.externalUrl != null)
                              Padding(
                                padding: const EdgeInsets.only(right: 12),
                                child: ElevatedButton.icon(
                                  onPressed: () {
                                    web.window.open(item.externalUrl!, '_blank');
                                  },
                                  icon: const Icon(Icons.open_in_new, size: 16),
                                  label: Text(
                                    Localizations.localeOf(context).languageCode == 'en'
                                        ? "Open Site"
                                        : "サイトを開く",
                                  ),
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: theme.colorScheme.primary,
                                    foregroundColor: theme.colorScheme.onPrimary,
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                  ),
                                ),
                              ),
                            if (item.githubUrl != null)
                              OutlinedButton.icon(
                                onPressed: () {
                                  web.window.open(item.githubUrl!, '_blank');
                                },
                                icon: const Icon(Icons.code, size: 16),
                                label: const Text("GitHub"),
                                style: OutlinedButton.styleFrom(
                                  foregroundColor: theme.colorScheme.primary,
                                  side: BorderSide(
                                    color: theme.colorScheme.primary,
                                  ),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                ),
                              ),
                          ],
                        ),
                        const SizedBox(height: 18),
                      ],

                      // 5. テキスト説明文
                      Divider(
                        color: theme.colorScheme.onSurface
                            .withValues(alpha: 0.15),
                      ),
                      const SizedBox(height: 14),
                      Text(
                        item.description,
                        style: TextStyle(
                          fontSize: 14,
                          height: 1.65,
                          color: theme.colorScheme.onSurface
                              .withValues(alpha: 0.85),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
