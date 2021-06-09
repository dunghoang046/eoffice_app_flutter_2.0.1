import 'dart:async';
import 'package:app_eoffice/models/NoiDungLichItem.dart';
import 'package:app_eoffice/services/LichLamViec_Api.dart';
import 'base_bloc.dart';

class LichlamViecBloc extends Blocdispose {
  int currentPageNow = 1;
  int currentPage = 1;
  int total = 0;
  var _lstobject = <NoiDungLichItem>[];
  final _repository = LichlamViec_Api();

  var _isLoadingMore = false;
  var _currentStoryIndex = 0;

  StreamController<List<NoiDungLichItem>> _topStoriesStreamController =
      StreamController();
  Stream<List<NoiDungLichItem>> get topStories =>
      _topStoriesStreamController.stream;
  var dataquery = {
    "CurrentPage": '1',
    "RowPerPage": '20',
    "SearchIn": 'NoiDung',
    "Keyword": '',
    "Loai": '3',
    "LoaiListID": '0'
  };
  LichlamViecBloc(yearselect, weekselect, loai) {
    _loadInitTopStories(yearselect, weekselect, loai);
  }
  void _loadInitTopStories(yearselect, weekselect, loai) async {
    loadMore(yearselect, weekselect, loai);
  }

  void loadtop(yearselect, weekselect, loai) async {
    _topStoriesStreamController = new StreamController();
    _lstobject = <NoiDungLichItem>[];
    currentPage = 1;
    loadMore(yearselect, weekselect, loai);
  }

  void loadMore(yearselect, weekselect, loai) async {
    var requestdata = {'week': weekselect, 'year': yearselect, 'Loai': loai};
    if (_topStoriesStreamController.isClosed)
      _topStoriesStreamController = new StreamController();
    var lst;
    lst = await _repository.getlichlamviecbytuan(requestdata, currentPage);
    if (lst.length > 0) total = lst.length;
    _lstobject.addAll(lst);
    _currentStoryIndex = _lstobject.length;
    if (!_topStoriesStreamController.isClosed)
      _topStoriesStreamController.sink.add(_lstobject);
    currentPage = currentPage + 1;
  }

  bool hasMoreStories() => _currentStoryIndex < total;

  @override
  void dispose() {
    _topStoriesStreamController.close();
  }
}
