import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:mitask/core/media/media_colors.dart';
import 'package:mitask/core/media/media_res.dart';
import 'package:mitask/core/media/media_text.dart';

class QuickStatsSection extends StatelessWidget {
  final int pinnedTask;
  final int totalTask;
  final int favoriteTask;
  final int archivedTask;

  const QuickStatsSection({
    super.key,
    required this.pinnedTask,
    required this.totalTask,
    required this.favoriteTask,
    required this.archivedTask,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            _buildStatCard(
              title: 'Pinned',
              value: '$pinnedTask',
              icon: MediaRes.pinned,
              color: AppColors.primaryDark,
            ),
            _buildStatCard(
              title: 'Favorite',
              value: '$totalTask',
              icon: MediaRes.favorite,
              color: AppColors.primaryDark,
            ),
          ],
        ),
        SizedBox(height: 10),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            _buildStatCard(
              title: 'Total Task',
              value: '$totalTask',
              icon: MediaRes.totalTask,
              color: AppColors.primaryDark,
            ),
            _buildStatCard(
              title: 'Archived',
              value: '$pinnedTask',
              icon: MediaRes.archived,
              color: AppColors.primaryDark,
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildStatCard({
    required String title,
    required String value,
    required String icon,
    required Color color,
  }) {
    return Expanded(
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 4),
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: AppColors.surface,
          borderRadius: BorderRadius.circular(16),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              height: 40,
              width: 40,
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: AppColors.border,
                borderRadius: BorderRadius.circular(100),
              ),
              child: SvgPicture.asset(
                icon,
                colorFilter: ColorFilter.mode(color, BlendMode.srcIn),
              ),
            ),
            const SizedBox(height: 8),
            Text(
              title,
              style: AppTextStyle.body.copyWith(fontWeight: semiBold),
            ),
            const SizedBox(height: 4),
            Text(
              '$value Task',
              style: AppTextStyle.textSecondary.copyWith(
                fontWeight: medium,
                fontSize: 15,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class RecentTask extends StatelessWidget {
  const RecentTask({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(8),
      margin: const EdgeInsets.only(bottom: 10),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(15),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Expanded(
            child: Row(
              children: [
                Container(
                  height: 30,
                  width: 30,
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: AppColors.border,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  child: SvgPicture.asset(
                    MediaRes.pinned,
                    colorFilter: ColorFilter.mode(
                      AppColors.primaryDark,
                      BlendMode.srcIn,
                    ),
                  ),
                ),
                SizedBox(width: 10),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Title Task',
                        maxLines: 1, // Batasi 1 baris
                        overflow: TextOverflow.ellipsis,
                        style: AppTextStyle.body.copyWith(fontWeight: semiBold),
                      ),
                      Text(
                        'your detail task your detail task your detail task',
                        maxLines: 1, // Batasi 1 baris
                        overflow: TextOverflow.ellipsis,
                        style: AppTextStyle.caption.copyWith(fontWeight: regular),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          SizedBox(width: 10),
          Text(
            '3 Days ago',
            style: AppTextStyle.small.copyWith(fontWeight: medium),
          ),
        ],
      ),
    );
  }
}
