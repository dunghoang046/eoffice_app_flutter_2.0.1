import 'dart:async';
import 'package:app_eoffice/models/ThongBaoItem.dart';
import 'package:app_eoffice/services/ThongBao_Api.dart';
import 'base_bloc.dart';

class ThongBaoBloc extends Blocdispose {
  int currentPageNow = 1;
  int currentPage = 1;
  int total = 0;
  var _lstobject = <ThongBaoItem>[];
  final _repository = ThongBao_Api();

  var _isLoadingMore = false;
  var _currentStoryIndex = 0;

  StreamController<List<ThongBaoItem>> _topStoriesStreamController =
      StreamController();
  Stream<List<ThongBaoItem>> get topStories =>
      _topStoriesStreamController.stream;
  var dataquery = {
    "CurrentPage": '1',
    "RowPerPage": '20',
    "SearchIn": 'MoTa',
    "Keyword": '',
    "Loai": '3',
    "LoaiListID": '0'
  };
  ThongBaoBloc(keyword, loai) {
    _loadInitTopStories(keyword, loai);
  }

  void _loadInitTopStories(keyword, loai) async {
    loadMore(keyword, loai);
  }

  void loadtop(keyword, loai) async {
    _topStoriesStreamController = new StreamController();
    _lstobject = <ThongBaoItem>[];
    currentPage = 1;
    loadMore(keyword, loai);
  }

  void loadMore(keyword, loai) async {
    if (_topStoriesStreamController.isClosed)
      _topStoriesStreamController = new StreamController();
    dataquery = {
      "CurrentPage": "" + currentPage.toString() + "",
      "RowPerPage": '20',
      "SearchIn": 'MoTa',
      "Keyword": '' + keyword + '',
      "Loai": '' + loai.toString() + '',
    };
    if (currentPage > 1) {
      if (currentPage > 1) currentPageNow = currentPage - 1;
      if (currentPage == 1) currentPage = 2;
      if ((currentPageNow * 20) < total) {
        _isLoadingMore = true;
      } else
        _isLoadingMore = false;
    }
    if (currentPage == 1) _isLoadingMore = true;
    if (_isLoadingMore == true) {
      var lst;
      lst = await _repository.getallthongbao(dataquery, currentPage);

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
