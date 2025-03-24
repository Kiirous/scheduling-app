part of 'onboarding_page_cubit.dart';

class OnboardingPageState extends Equatable {
  const OnboardingPageState({
    required this.showNotificationPage,
    required this.showLocationPage,
  });

  const OnboardingPageState.initial()
      : showLocationPage = false,
        showNotificationPage = false;

  final bool showNotificationPage;
  final bool showLocationPage;

  @override
  List<Object> get props => [showNotificationPage, showLocationPage];
}
