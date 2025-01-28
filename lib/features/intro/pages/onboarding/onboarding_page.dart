import 'package:flutter/material.dart';

import '../../../../core/widgets/app_elevated_button.dart';
import '../../../../core/widgets/app_text_button.dart';

class OnboardingPage extends StatefulWidget {
  const OnboardingPage({super.key});

  @override
  State<OnboardingPage> createState() => _OnboardingPageState();
}

class _OnboardingPageState extends State<OnboardingPage> {
  final PageController pageController = PageController();

  int page = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Expanded(
            child: PageView(
              controller: pageController,
              physics: const NeverScrollableScrollPhysics(),
              children: [
                Container(color: Colors.red),
                Container(color: Colors.blue),
                Container(color: Colors.green),
              ],
              onPageChanged: (p) => setState(() {
                page = p;
              }),
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(24, 0, 24, 44),
            child: Row(
              children: [
                if (page > 0) ...[
                  AppTextButton(
                    label: 'Voltar',
                    onPressed: () {
                      pageController.animateToPage(
                        page - 1,
                        duration: const Duration(milliseconds: 300),
                        curve: Curves.ease,
                      );
                    },
                  ),
                  const SizedBox(width: 16),
                ],
                Expanded(
                  child: AppElevatedButton(
                    label: 'Próximo',
                    iconPath: 'assets/icons/arrow_right.svg',
                    onPressed: () {
                      pageController.animateToPage(
                        page + 1,
                        duration: const Duration(milliseconds: 300),
                        curve: Curves.ease,
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
