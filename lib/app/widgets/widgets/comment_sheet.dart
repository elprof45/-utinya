import 'package:egliloo/app/theme/theme/app_colors.dart';
import 'package:egliloo/data/data/models/comment_model.dart' show CommentModel;
import 'package:egliloo/data/datasources/local/mock_data_provider.dart';
import 'package:flutter/material.dart';
import 'avatar_placeholder.dart';

/// A draggable-feeling bottom sheet that lists comments for a piece of
/// content and lets the user add a new one. Backed by [MockDataProvider]
/// so it stays in sync no matter which page opened it.
class CommentSheetContent extends StatefulWidget {
  final String contentId;
  final ValueChanged<int>? onCountChanged;

  const CommentSheetContent({
    super.key,
    required this.contentId,
    this.onCountChanged,
  });

  @override
  State<CommentSheetContent> createState() => _CommentSheetContentState();
}

class _CommentSheetContentState extends State<CommentSheetContent> {
  late List<CommentModel> comments;
  final TextEditingController _inputController = TextEditingController();

  @override
  void initState() {
    super.initState();
    comments = List<CommentModel>.from(
      MockDataProvider.commentsFor(widget.contentId),
    );
  }

  void _send() {
    final text = _inputController.text.trim();
    if (text.isEmpty) return;
    MockDataProvider.addComment(widget.contentId, text);
    setState(() {
      comments = List<CommentModel>.from(
        MockDataProvider.commentsFor(widget.contentId),
      );
      _inputController.clear();
    });
    widget.onCountChanged?.call(comments.length);
  }

  @override
  void dispose() {
    _inputController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: MediaQuery.of(context).size.height * 0.72,
      decoration: BoxDecoration(
        color: Theme.of(context).scaffoldBackgroundColor,
        borderRadius: const BorderRadius.vertical(top: Radius.circular(26)),
      ),
      child: Column(
        children: [
          const SizedBox(height: 12),
          Container(
            width: 42,
            height: 4,
            decoration: BoxDecoration(
              color: AppColors.ochre.withValues(alpha: 0.4),
              borderRadius: BorderRadius.circular(4),
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(20, 14, 20, 10),
            child: Row(
              children: [
                Text(
                  '${comments.length} Comments',
                  style: Theme.of(context).textTheme.titleLarge,
                ),
              ],
            ),
          ),
          const Divider(height: 1),
          Expanded(
            child: comments.isEmpty
                ? Center(
                    child: Text(
                      'Be the first to comment.',
                      style: Theme.of(context).textTheme.bodyMedium,
                    ),
                  )
                : ListView.separated(
                    padding: const EdgeInsets.fromLTRB(20, 14, 20, 14),
                    itemCount: comments.length,
                    separatorBuilder: (_, _) => const SizedBox(height: 18),
                    itemBuilder: (context, index) {
                      final c = comments[index];
                      return Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          AvatarPlaceholder(
                            colorIndex: c.avatarColorIndex,
                            size: 38,
                          ),
                          const SizedBox(width: 12),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    Text(
                                      c.authorName,
                                      style: const TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 13.5,
                                      ),
                                    ),
                                    const SizedBox(width: 8),
                                    Text(
                                      c.timeAgo,
                                      style: Theme.of(
                                        context,
                                      ).textTheme.bodySmall,
                                    ),
                                  ],
                                ),
                                const SizedBox(height: 4),
                                Text(
                                  c.text,
                                  style: Theme.of(
                                    context,
                                  ).textTheme.bodyLarge?.copyWith(fontSize: 14),
                                ),
                              ],
                            ),
                          ),
                          Column(
                            children: [
                              Icon(
                                Icons.favorite_border_rounded,
                                size: 16,
                                color: AppColors.terracotta,
                              ),
                              const SizedBox(height: 2),
                              Text(
                                '${c.likes}',
                                style: Theme.of(context).textTheme.bodySmall,
                              ),
                            ],
                          ),
                        ],
                      );
                    },
                  ),
          ),
          SafeArea(
            top: false,
            child: Padding(
              padding: const EdgeInsets.fromLTRB(16, 10, 16, 12),
              child: Row(
                children: [
                  const AvatarPlaceholder(colorIndex: 5, size: 36),
                  const SizedBox(width: 10),
                  Expanded(
                    child: TextField(
                      controller: _inputController,
                      decoration: InputDecoration(
                        hintText: 'Add a respectful comment…',
                        filled: true,
                        fillColor: Theme.of(context).cardColor,
                        contentPadding: const EdgeInsets.symmetric(
                          horizontal: 16,
                          vertical: 12,
                        ),
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(22),
                          borderSide: BorderSide.none,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(width: 8),
                  Container(
                    decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                      gradient: LinearGradient(
                        colors: [AppColors.terracotta, AppColors.ochre],
                      ),
                    ),
                    child: IconButton(
                      onPressed: _send,
                      icon: const Icon(
                        Icons.send_rounded,
                        color: Colors.white,
                        size: 18,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
