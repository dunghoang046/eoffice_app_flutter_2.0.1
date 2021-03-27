import 'dart:async';
import 'package:app_eoffice/services/Notification_Api.dart';
import 'package:app_eoffice/models/NotificationItem.dart';
import 'base_bloc.dart';

class NotificationBloc extends Blocdispose {
  int currentPageNow = 1;
  int currentPage = 1;
  int total = 0;
  var _lstobject = <NotificationItem>[];
  final _repository = Notification_Api();

  var _isLoadingMore = false;
  var _currentStoryIndex = 0;

  StreamController<List<NotificationItem>> _topStoriesStreamController =
      StreamController();
  Stream<List<NotificationItem>> get topStories =>
      _topStoriesStreamController.stream;
  var dataquery = {
    "CurrentPage": '1',
    "RowPerPage": '10',
    "SearchIn": 'NoiDung',
    "Keyword": '',
    "Loai": '3',
    "LoaiListID": '0'
  };
  NotificationBloc(keyword, loai) {
    _loadInitTopStories(keyword, loai);
  }
  void _loadInitTopStories(keyword, loai) async {
    loadMore(keyword, loai);
  }

  void loadtop(keyword, loai) async {
    _topStoriesStreamController = new StreamController();
    _lstobject = <NotificationItem>[];
    currentPage = 1;
    loadMore(keyword, loai);
  }

  void loadMore(keyword, loai) async {
    if (_topStoriesStreamController.isClosed)
      _topStoriesStreamController = new StreamController();
    dataquery = {
      "CurrentPage": "" + currentPage.toString() + "",
      "RowPerPage": '10',
      "SearchIn": 'NoiDung',
      "Keyword": '' + keyword + '',
      "Loai": '' + loai.toString() + '',
    };
    if (currentPage > 1) {
      if (currentPage > 1) currentPageNow = currentPage - 1;
      if (currentPage == 1) currentPage = 2;
      if ((currentPageNow * 10) < total) {
        _isLoadingMore = true;
      } else
        _isLoadingMore = false;
    }
    if (currentPage == 1) _isLoadingMore = true;
    if (_isLoadingMore == true) {
      var lst;
      lst = await _repository.getallnotification(dataquery, currentPage);
      if (lst.length > 0) total = lst[0].total;
      _lstobject.addAll(lst);
      _currentStoryIndex = _lstobject.length;
      if (!_topStoriesStreamController.isClosed)
        _topStoriesStreamController.sink.add(_lstobject);
      currentPage = currentPage + 1;
    }
  }

  bool hasMoreStories() => _currentStoryIndex < total;

  @override
  void dispose() {
    _topStoriesStreamController.close();
  }
}
