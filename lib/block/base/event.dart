abstract class ActionEvent {
  dynamic data;
  dynamic donviid;
}

class NoEven extends ActionEvent {}

class AddEvent extends ActionEvent {}

class ListEvent extends ActionEvent {}

class ViewYKienEvent extends ActionEvent {}

class EditEvent extends ActionEvent {}

class DeleteEvent extends ActionEvent {}

class FinshEvent extends ActionEvent {}

class RejectEvent extends ActionEvent {}

class HoanThanhEvent extends ActionEvent {}

class YKienEvent extends ActionEvent {}

class ChuyenVanBanEvent extends ActionEvent {}

class TrinhLDEvent extends ActionEvent {}

class PhatHanhEvent extends ActionEvent {}

class TuChoiEvent extends ActionEvent {}

class ApproverEvent extends ActionEvent {}

class UploadfileEvent extends ActionEvent {}
