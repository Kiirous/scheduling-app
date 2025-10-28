part of 'professional_ratings_page_cubit.dart';

@immutable
class ProfessionalRatingsPageState extends Equatable {
  const ProfessionalRatingsPageState({
    required this.isLoading,
    this.ratings,
    this.page = 0,
    this.finishedLoading = false,
  });

  final bool isLoading;
  final List<Rating>? ratings;
  final int page;
  final bool finishedLoading;

  ProfessionalRatingsPageState copyWith({bool? isLoading, List<Rating>? ratings, int? page, bool? finishedLoading}) {
    return ProfessionalRatingsPageState(
      isLoading: isLoading ?? this.isLoading,
      ratings: ratings ?? this.ratings,
      page: page ?? this.page,
      finishedLoading: finishedLoading ?? this.finishedLoading,
    );
  }

  @override
  List<Object?> get props => [isLoading, ratings, page, finishedLoading];
}
