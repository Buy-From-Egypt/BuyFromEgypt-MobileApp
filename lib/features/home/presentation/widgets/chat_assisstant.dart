import 'package:buy_from_egypt/core/utils/app_colors.dart';
import 'package:buy_from_egypt/core/utils/styles.dart';
import 'package:buy_from_egypt/core/utils/svg_icon.dart';
import 'package:buy_from_egypt/features/home/presentation/views/ai_view.dart';
import 'package:flutter/material.dart';

class ExportAssistant extends StatelessWidget {
  const ExportAssistant({super.key});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        // Replace with your target route
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => AiView()),
        );
      },
      borderRadius: BorderRadius.circular(8),
      child: Container(
        height: 80,
        decoration: BoxDecoration(
          color: AppColors.background,
          borderRadius: BorderRadius.circular(8),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Row(
            children: [
              Image.asset(
                'assets/images/pngegg (55) 1.png',
                width: 85,
                height: 76,
                fit: BoxFit.cover,
              ),
              const SizedBox(width: 12),
              const Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Export Assistant', style: Styles.textStyle166pr),
                    SizedBox(height: 4),
                    Text(
                      'Here to assist you with your journey anytime, anywhere',
                      style: Styles.textStyle12c7,
                      overflow: TextOverflow.ellipsis,
                      maxLines: 2,
                    ),
                  ],
                ),
              ),
              const SvgIcon(
                path: 'assets/images/arrow_forrward.svg',
                width: 16,
                height: 12,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
