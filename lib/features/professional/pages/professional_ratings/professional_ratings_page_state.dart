part of 'professional_ratings_page_cubit.dart';

class ProfessionalRatingsPageState extends Equatable {
  const ProfessionalRatingsPageState({required this.isLoading, this.ratings});

  final bool isLoading;
  final List<Rating>? ratings;

  ProfessionalRatingsPageState copyWith({
    bool? isLoading,
    List<Rating>? ratings,
  }) {
    return ProfessionalRatingsPageState(
      isLoading: isLoading ?? this.isLoading,
      ratings: ratings ?? this.ratings,
    );
  }

  @override
  List<Object?> get props => [isLoading, ratings];
}
