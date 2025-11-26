import 'package:app_agendamento/core/theme/app_theme.dart';
import 'package:app_agendamento/core/widgets/base/app_stateless.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class AppLogo extends AppStateless {
  const AppLogo({super.key, this.size = 48});

  final double size;

  @override
  Widget builder(BuildContext context, AppTheme theme) {
    return SvgPicture.asset('assets/brand/logo.svg', width: size, height: size);
  }
}
