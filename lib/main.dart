import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:mywallet/logic/expense/expense_cubit.dart';
import 'package:mywallet/logic/user/user_cubit.dart';
import 'package:mywallet/presentation/screens/home_screen.dart';

import 'logic/cubit/date_cubit.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (ctx) => UserCubit(),
        ),
        BlocProvider(
          create: (ctx) => ExpenseCubit(userCubit: ctx.read<UserCubit>()),
        ),
        BlocProvider(
          create: (ctx) => DateCubit(ctx.read<ExpenseCubit>()),
        ),
      ],
      child: MaterialApp(
        title: 'My wallet',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: const HomeScreen(),
      ),
    );
  }
}
