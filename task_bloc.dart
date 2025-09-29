import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

abstract class TaskEvent extends Equatable {
  @override
  List<Object?> get props => [];
}

class AddTask extends TaskEvent {
  final String task;
  AddTask(this.task);

  @override
  List<Object?> get props => [task];
}


abstract class TaskState extends Equatable {
  @override
  List<Object?> get props => [];
}

class TaskInitial extends TaskState {}

class TaskLoaded extends TaskState {
  final List<String> tasks;
  TaskLoaded(this.tasks);

  @override
  List<Object?> get props => [tasks];
}

class TaskBloc extends Bloc<TaskEvent, TaskState> {
  TaskBloc() : super(TaskInitial()) {
    on<AddTask>((event, emit) {
      final currentTasks = state is TaskLoaded ? (state as TaskLoaded).tasks : [];
      emit(TaskLoaded([...currentTasks, event.task]));
    });
  }
}
