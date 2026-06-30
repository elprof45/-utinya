import 'package:egliloo/features/quiz/controllers/quiz_controller.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:egliloo/app/theme/app_colors.dart';
import 'package:egliloo/app/theme/app_theme.dart';
import 'package:egliloo/app/theme/app_typography.dart';

class QuizView extends GetView<QuizController> {
  const QuizView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.backgroundDark,
      appBar: AppBar(
        backgroundColor: AppColors.backgroundDark,
        leading: IconButton(
          icon: const Icon(
            Icons.close_rounded,
            color: AppColors.textPrimaryDark,
          ),
          onPressed: Get.back,
        ),
        title: Obx(
          () => Text(
            'Question ${controller.currentQuestion.value + 1}/${controller.quiz.value?.questions.length ?? 0}',
            style: AppTypography.titleMedium.copyWith(
              color: AppColors.textPrimaryDark,
            ),
          ),
        ),
      ),
      body: Obx(() {
        if (controller.quiz.value == null) {
          return const Center(
            child: CircularProgressIndicator(color: AppColors.primary),
          );
        }
        if (controller.isFinished.value) return _buildResult();
        final q =
            controller.quiz.value!.questions[controller.currentQuestion.value];
        return Padding(
          padding: EdgeInsets.all(AppSpacing.xl),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Progress
              ClipRRect(
                borderRadius: AppRadius.fullAll,
                child: LinearProgressIndicator(
                  value:
                      (controller.currentQuestion.value + 1) /
                      controller.quiz.value!.questions.length,
                  backgroundColor: AppColors.surfaceDark2,
                  valueColor: const AlwaysStoppedAnimation<Color>(
                    AppColors.primary,
                  ),
                  minHeight: 6,
                ),
              ),
              SizedBox(height: AppSpacing.xxl),
              Container(
                padding: EdgeInsets.all(AppSpacing.xl),
                decoration: BoxDecoration(
                  color: AppColors.surfaceDark,
                  borderRadius: AppRadius.lgAll,
                  border: Border.all(color: AppColors.borderDark, width: 0.5),
                ),
                child: Text(
                  q.question,
                  style: AppTypography.titleLarge.copyWith(
                    color: AppColors.textPrimaryDark,
                    height: 1.5,
                  ),
                ),
              ),
              SizedBox(height: AppSpacing.xl),
              ...q.options.asMap().entries.map((e) {
                return Obx(() {
                  final sel = controller.selectedAnswer.value;
                  Color color = AppColors.surfaceDark;
                  Color border = AppColors.borderDark;
                  Color text = AppColors.textPrimaryDark;
                  if (sel != -1) {
                    if (e.key == q.correctIndex) {
                      color = AppColors.successSurface;
                      border = AppColors.success;
                      text = AppColors.success;
                    } else if (e.key == sel && sel != q.correctIndex) {
                      color = AppColors.errorSurface;
                      border = AppColors.error;
                      text = AppColors.error;
                    }
                  }
                  return GestureDetector(
                    onTap: () => controller.selectAnswer(e.key),
                    child: AnimatedContainer(
                      duration: const Duration(milliseconds: 300),
                      margin: EdgeInsets.only(bottom: AppSpacing.sm),
                      padding: EdgeInsets.all(AppSpacing.base),
                      decoration: BoxDecoration(
                        color: color,
                        borderRadius: AppRadius.mdAll,
                        border: Border.all(color: border),
                      ),
                      child: Row(
                        children: [
                          Container(
                            width: 28.w,
                            height: 28.w,
                            decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              border: Border.all(color: border, width: 1.5),
                            ),
                            child: Center(
                              child: Text(
                                String.fromCharCode(65 + e.key),
                                style: AppTypography.labelSmall.copyWith(
                                  color: text,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                            ),
                          ),
                          SizedBox(width: AppSpacing.sm),
                          Expanded(
                            child: Text(
                              e.value,
                              style: AppTypography.bodyMedium.copyWith(
                                color: text,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                });
              }),
              const Spacer(),
              Obx(
                () => controller.selectedAnswer.value != -1
                    ? Column(
                        children: [
                          if (q.explanation != null)
                            Container(
                              padding: EdgeInsets.all(AppSpacing.sm),
                              decoration: BoxDecoration(
                                color: AppColors.infoSurface,
                                borderRadius: AppRadius.mdAll,
                                border: Border.all(
                                  color: AppColors.info.withValues(alpha: 0.3),
                                ),
                              ),
                              child: Row(
                                children: [
                                  Icon(
                                    Icons.info_outline_rounded,
                                    color: AppColors.info,
                                    size: 16.sp,
                                  ),
                                  SizedBox(width: AppSpacing.xs),
                                  Expanded(
                                    child: Text(
                                      q.explanation!,
                                      style: AppTypography.bodySmall.copyWith(
                                        color: AppColors.textSecondaryDark,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          SizedBox(height: AppSpacing.base),
                          ElevatedButton(
                            onPressed: controller.nextQuestion,
                            child: Text(
                              controller.currentQuestion.value <
                                      (controller.quiz.value!.questions.length -
                                          1)
                                  ? 'Question suivante'
                                  : 'Voir les résultats',
                            ),
                          ),
                        ],
                      )
                    : const SizedBox(),
              ),
            ],
          ),
        );
      }),
    );
  }

  Widget _buildResult() {
    final total = controller.quiz.value!.questions.length;
    final score = controller.score.value;
    final pct = (score / total * 100).round();
    return Center(
      child: Padding(
        padding: EdgeInsets.all(AppSpacing.xxl),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              pct >= 70
                  ? '🏆'
                  : pct >= 50
                  ? '👍'
                  : '📚',
              style: TextStyle(fontSize: 72.sp),
            ),
            SizedBox(height: AppSpacing.xl),
            Text(
              '$score / $total',
              style: AppTypography.displaySmall.copyWith(
                color: AppColors.primary,
                fontWeight: FontWeight.w700,
              ),
            ),
            SizedBox(height: AppSpacing.sm),
            Text(
              pct >= 70
                  ? 'Excellent !'
                  : pct >= 50
                  ? 'Bien joué !'
                  : 'Continuez à apprendre !',
              style: AppTypography.headlineSmall.copyWith(
                color: AppColors.textPrimaryDark,
              ),
            ),
            SizedBox(height: AppSpacing.sm),
            Text(
              '+${controller.quiz.value!.xpReward} XP gagnés',
              style: AppTypography.titleMedium.copyWith(
                color: AppColors.warning,
              ),
            ),
            SizedBox(height: AppSpacing.xxl),
            ElevatedButton(
              onPressed: Get.back,
              child: const Text('Retour au contenu'),
            ),
          ],
        ),
      ),
    );
  }
}
