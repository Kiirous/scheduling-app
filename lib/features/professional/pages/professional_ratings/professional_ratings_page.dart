import 'package:app_agendamento/core/theme/app_theme.dart';
import 'package:app_agendamento/core/widgets/app_base_page.dart';
import 'package:app_agendamento/features/professional/pages/professional_ratings/professional_ratings_page_cubit.dart';
import 'package:app_agendamento/features/professional/widgets/professional_rating_list_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

class ProfessionalRatingsPage extends StatefulWidget {
  const ProfessionalRatingsPage({super.key, required this.id});

  final String id;

  @override
  State<ProfessionalRatingsPage> createState() => _ProfessionalRatingsPageState();
}

class _ProfessionalRatingsPageState extends State<ProfessionalRatingsPage> {
  late final ProfessionalRatingsPageCubit cubit = ProfessionalRatingsPageCubit(professionalId: widget.id);

  @override
  void initState() {
    super.initState();
    cubit.loadRatings();
  }

  @override
  Widget build(BuildContext context) {
    final AppTheme t = context.watch();
    return BlocBuilder<ProfessionalRatingsPageCubit, ProfessionalRatingsPageState>(
      bloc: cubit,
      builder: (context, state) {
        return AppBasePage(
          title: 'AVALIAÇÕES',
          isLoading: state.isLoading,
          type: AppBasePageType.fixed,
          body: state.ratings != null
              ? ListView.separated(
                  padding: MediaQuery.paddingOf(context).add(const EdgeInsets.fromLTRB(24, 80, 24, 24)),
                  itemCount: state.ratings!.length + (state.finishedLoading ? 0 : 1),
                  physics: const BouncingScrollPhysics(),
                  separatorBuilder: (_, __) => const SizedBox(height: 18),
                  itemBuilder: (_, i) {
                    if (i < state.ratings!.length) {
                      final rating = state.ratings![i];
                      return ProfessionalRatingListItem(rating: rating);
                    } else {
                      cubit.loadRatings();
                      return Center(child: LoadingAnimationWidget.stretchedDots(color: t.primary, size: 40));
                    }
                  },
                )
              : const SizedBox.shrink(),
        );
      },
    );
  }

  @override
  void dispose() {
    super.dispose();
    cubit.close();
  }
}
