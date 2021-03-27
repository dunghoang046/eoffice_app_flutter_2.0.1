abstract class ActionEvent {
  dynamic data;
}

class AddEvent extends ActionEvent {}

class ListEvent extends ActionEvent {}

class EditEvent extends ActionEvent {}

class DeleteEvent extends ActionEvent {}

class FinshEvent extends ActionEvent {}
