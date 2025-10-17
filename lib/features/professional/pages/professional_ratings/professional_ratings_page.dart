import 'package:app_agendamento/core/widgets/app_base_page.dart';
import 'package:app_agendamento/features/professional/pages/professional_ratings/professional_ratings_page_cubit.dart';
import 'package:app_agendamento/features/professional/widgets/professional_rating_list_item.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

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
    return BlocBuilder<ProfessionalRatingsPageCubit, ProfessionalRatingsPageState>(
      bloc: cubit,
      builder: (context, state) {
        return AppBasePage(
          title: 'AVALIAÇÕES',
          isLoading: state.isLoading,
          body: state.ratings != null
              ? ListView.separated(
                  padding: EdgeInsets.zero,
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: state.ratings!.length,
                  separatorBuilder: (_, __) => const SizedBox(height: 18),
                  itemBuilder: (_, i) {
                    final rating = state.ratings![i];
                    return ProfessionalRatingListItem(rating: rating);
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
