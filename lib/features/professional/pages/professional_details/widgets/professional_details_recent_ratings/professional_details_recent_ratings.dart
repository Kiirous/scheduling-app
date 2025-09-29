import 'package:app_agendamento/core/theme/app_theme.dart';
import 'package:app_agendamento/core/widgets/app_outlined_button.dart';
import 'package:app_agendamento/core/widgets/app_shimmer.dart';
import 'package:app_agendamento/features/professional/pages/professional_details/widgets/professional_details_recent_ratings/professional_details_recent_ratings_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';

class ProfessionalDetailsRecentRatings extends StatefulWidget {
  const ProfessionalDetailsRecentRatings({super.key, required this.professionalId});

  final String professionalId;

  @override
  State<ProfessionalDetailsRecentRatings> createState() => _ProfessionalDetailsRecentRatingsState();
}

class _ProfessionalDetailsRecentRatingsState extends State<ProfessionalDetailsRecentRatings> {
  final ProfessionalDetailsRecentRatingsCubit cubit = ProfessionalDetailsRecentRatingsCubit();

  @override
  void initState() {
    super.initState();
    cubit.loadRatings(professionalId: widget.professionalId);
  }

  @override
  Widget build(BuildContext context) {
    final AppTheme t = context.watch();
    return BlocBuilder<ProfessionalDetailsRecentRatingsCubit, ProfessionalDetailsRecentRatingsState>(
      bloc: cubit,
      builder: (context, state) {
        return Column(
          children: [
            Row(
              children: [
                Expanded(child: Text('Avaliações', style: t.heading18Bold)),
                if (state.isSuccess) AppOutLinedButton(label: 'Ver todas', minHeight: 32 ,onPressed: () {}),
              ],
            ),
            const SizedBox(height: 12),
            switch (state.status) {
              ProfessionalDetailsRecentRatingsStatus.error => Container(),
              ProfessionalDetailsRecentRatingsStatus.loading => const AppShimmer(width: double.maxFinite, height: 100),
              ProfessionalDetailsRecentRatingsStatus.success => ListView.separated(
                padding: EdgeInsets.zero,
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: state.ratings!.length,
                separatorBuilder: (_, __) => const SizedBox(height: 18),
                itemBuilder: (_, i) {
                  final rating = state.ratings![i];
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(rating.username, style: t.body16Bold),
                      const SizedBox(height: 4),
                      Row(
                        children: [
                          for (int i = 0; i < 5; i++)
                            Padding(
                              padding: const EdgeInsets.symmetric(horizontal: 2),
                              child: SvgPicture.asset(
                                'assets/icons/star.svg',
                                colorFilter: ColorFilter.mode(i < rating.stars ? t.secondary : t.gray, BlendMode.srcIn),
                              ),
                            ),
                        ],
                      ),
                      const SizedBox(height: 10),
                      Text(rating.comments, style: t.body13),
                    ],
                  );
                },
              ),
            },
          ],
        );
      },
    );
  }
}
