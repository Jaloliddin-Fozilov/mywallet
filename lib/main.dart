import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'logic/balance/balance_bloc.dart';
import 'logic/date/date_bloc.dart';
import 'logic/expense/expense_bloc.dart';
import 'logic/user/user_bloc.dart';
import 'presentation/screens/home_screen.dart';

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
          create: (ctx) => UserBloc(),
        ),
        BlocProvider(
          create: (ctx) => DateBloc(),
        ),
        BlocProvider(
          create: (ctx) => BalanceBloc(),
        ),
        BlocProvider(
          create: (ctx) => ExpenseBloc(
            ctx.read<UserBloc>(),
            ctx.read<DateBloc>(),
          ),
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
