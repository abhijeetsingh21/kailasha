import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kailasha/pages/admin_profile/cubit/admin_profile_cubit.dart';
import 'package:kailasha/pages/experiments/cubit/experiments_cubit.dart';
import 'package:kailasha/pages/schools/cubit/schools_cubit.dart';
import 'package:kailasha/repository/auth_repo.dart';
import 'package:kailasha/core/user_notifier/cubit/user_cubit.dart';
import 'package:kailasha/pages/auth/cubit/auth_cubit.dart';
import 'package:kailasha/pages/chat/cubit/chat_cubit.dart';
import 'package:kailasha/pages/dashboard/cubit/dashboard_cubit.dart';
import 'package:kailasha/pages/home/cubit/home_cubit.dart';

import '../../di/injectable.dart';

class RootBlocInjection extends StatelessWidget {
  final Widget child;

  const RootBlocInjection({super.key, required this.child});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<AuthCubit>(
          create: (_) => AuthCubit(getIt<AuthRepository>()),
        ),
        BlocProvider<UserCubit>(create: (_) => UserCubit()),
      ],

      child: Builder(
        builder: (context) {
          return MultiBlocProvider(
            providers: [
              BlocProvider<DashboardCubit>(create: (_) => DashboardCubit()),

              BlocProvider<HomeCubit>(
                create: (_) => HomeCubit(authCubit: context.read<AuthCubit>()),
              ),
              BlocProvider<SchoolsCubit>(create: (_) => SchoolsCubit()),
              BlocProvider<AdminProfileCubit>(create: (_) => AdminProfileCubit()),
              BlocProvider<ExperimentsCubit>(create: (_) => ExperimentsCubit()),
              BlocProvider<ChatCubit>(create: (_) => ChatCubit()),
            ],
            child: child,
          );
        },
      ),
    );
  }
}
