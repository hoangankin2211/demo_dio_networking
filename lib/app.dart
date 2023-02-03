import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import './widget/index_widget.dart';

class DashboardScreen extends StatelessWidget {
  const DashboardScreen({super.key});

  static const List<Widget> widgets = [
    GetWidget(),
    PostWidget(),
  ];

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => PositionBloc(const InitPositionState(0)),
      child: BlocBuilder<PositionBloc, PositionState>(
        builder: (context, state) => Scaffold(
          bottomNavigationBar: BottomNavigationBar(
            unselectedItemColor: Colors.grey,
            selectedItemColor: Colors.blue,
            elevation: 5,
            items: const [
              BottomNavigationBarItem(icon: Icon(Icons.widgets), label: "GET"),
              BottomNavigationBarItem(icon: Icon(Icons.widgets), label: "POST"),
            ],
            currentIndex: state.currentPosition,
            onTap: (value) {
              context
                  .read<PositionBloc>()
                  .add(ChangingNewPosition(newPosition: value));
            },
          ),
          body: Center(child: widgets[state.currentPosition]),
        ),
      ),
    );
  }
}

////////////////////STATE////////////////////
abstract class PositionState {
  final int currentPosition;
  const PositionState(this.currentPosition);
}

class InitPositionState extends PositionState {
  const InitPositionState(super.currentPosition);
}

class NewPoistionState extends PositionState {
  const NewPoistionState(super.currentPosition);
}

////////////////////EVENT////////////////////
abstract class PositionEvent {
  const PositionEvent();
}

class ChangingNewPosition extends PositionEvent {
  final int newPosition;

  ChangingNewPosition({required this.newPosition});
}

//////////////////////BLOC//////////////////////
class PositionBloc extends Bloc<PositionEvent, PositionState> {
  PositionBloc(InitPositionState? initialState)
      : super(initialState ?? const InitPositionState(0)) {
    on<ChangingNewPosition>(handleChangingPosition);
  }

  void handleChangingPosition(
      ChangingNewPosition event, Emitter<PositionState> emit) {
    emit(NewPoistionState(event.newPosition));
  }
}
