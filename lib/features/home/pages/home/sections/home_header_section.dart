import 'package:app_agendamento/core/theme/app_theme.dart';
import 'package:app_agendamento/features/auth/data/session/session_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class HomeHeaderSection extends StatelessWidget {
  const HomeHeaderSection({super.key});

  @override
  Widget build(BuildContext context) {
    final AppTheme t = context.watch();
    return SafeArea(
      bottom: false,
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 20),
        child: Align(
          alignment: Alignment.centerLeft,
          child: BlocBuilder<SessionCubit, SessionState>(
            builder: (context, state) {
              return Row(
                children: [
                  IconButton(
                    onPressed: () {
                      final sessionCubit = context.read<SessionCubit>();
                      if(sessionCubit.state.loggedUser != null) {
                        sessionCubit.logout();
                      } else {
                        sessionCubit.login(email: 'binladen@teste.com', password: '12345678');
                      }
                    },
                    icon: Icon(Icons.menu, color: t.primary),
                  ),
                  Text('Olá, ${state.loggedUser?.fullname ?? 'visitante'}', style: t.heading20Bold),
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}
