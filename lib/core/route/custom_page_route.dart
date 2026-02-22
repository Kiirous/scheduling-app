import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class CustomPage extends MaterialPage {
  CustomPage({required super.child, required GoRouterState state})
    : super(
        key: state.pageKey,
        name: state.fullPath,
        arguments: {...state.pathParameters, ...state.uri.queryParameters},
      );
}
