import 'dart:async';
import 'package:app_eoffice/models/LichLamViecItem.dart';
import 'package:app_eoffice/models/NoiDungLichItem.dart';
import 'package:app_eoffice/models/YearWeekItem.dart';
import 'package:app_eoffice/services/LichLamViec_Api.dart';
import 'package:app_eoffice/services/Notification_Api.dart';
import 'package:app_eoffice/models/NotificationItem.dart';
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
  LichlamViecBloc(yearselect, weekselect) {
    _loadInitTopStories(yearselect, weekselect);
  }
  void _loadInitTopStories(yearselect, weekselect) async {
    loadMore(yearselect, weekselect);
  }

  void loadtop(keyword, loai) async {
    _topStoriesStreamController = new StreamController();
    _lstobject = <NoiDungLichItem>[];
    currentPage = 1;
    loadMore(keyword, loai);
  }

  void loadMore(yearselect, weekselect) async {
    var requestdata = {'week': weekselect, 'year': yearselect};
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
