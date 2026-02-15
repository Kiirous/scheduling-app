import 'dart:ui';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'alert_area_state.dart';

class AlertAreaCubit extends Cubit<AlertAreaState> {
  AlertAreaCubit() : super(AlertAreaState());

  void showAlert(Alert alert) {
    emit(AlertAreaState(alerts: [alert, ...state.alerts]));
  }

  void removeAlert(Alert alert) => emit(AlertAreaState(alerts: state.alerts.where((e) => e != alert).toList()));
}

class Alert extends Equatable {
  const Alert.success({required this.title, this.duration = const Duration(seconds: 2), this.onTap, this.subtitle})
    : type = AlertType.success;

  const Alert.error({required this.title, this.duration = const Duration(seconds: 2), this.onTap, this.subtitle})
    : type = AlertType.error;

  const Alert.notification({required this.title, this.duration = const Duration(seconds: 4), this.onTap, this.subtitle})
    : type = AlertType.notification;

  final String title;
  final String? subtitle;
  final AlertType type;
  final Duration duration;
  final VoidCallback? onTap;

  @override
  List<Object?> get props => [title, type, duration];
}

enum AlertType { success, error, notification }
