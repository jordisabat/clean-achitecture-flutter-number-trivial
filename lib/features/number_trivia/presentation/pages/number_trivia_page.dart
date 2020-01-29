import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../injection_container.dart';
import '../bloc/bloc.dart';
import '../widgets/widgets.dart';

class NumberTriviaPage extends StatelessWidget {
  const NumberTriviaPage({Key key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Number trivia'),
      ),
      body: SingleChildScrollView(child: buildBlocProvider(context)),
    );
  }

  BlocProvider<NumberTriviaBloc> buildBlocProvider(BuildContext context) {
    return BlocProvider(
      create: (_) => sl<NumberTriviaBloc>(),
      child: Center(
        child: Padding(
          padding: const EdgeInsets.all(10),
          child: Column(
            children: <Widget>[
              SizedBox(height: 10),
              // Top half
              BlocBuilder<NumberTriviaBloc, NumberTriviaState>(
                  builder: (context, state) {
                if (state is Empty) {
                  return MessageDisplay(
                    message: 'Start searching!',
                  );
                } else if (state is Loading) {
                  return LoadingWidget();
                } else if (state is Loaded) {
                  return TriviaDisplay(
                    numberTrivia: state.trivia,
                  );
                } else if (state is Error) {
                  return MessageDisplay(
                    message: state.message,
                  );
                }
                return Container(
                  height: MediaQuery.of(context).size.height / 3,
                  child: Placeholder(),
                );
              }),
              SizedBox(height: 20),
              // Bottom half
              TriviaControls()
            ],
          ),
        ),
      ),
    );
  }
}