import 'dart:async';
import 'package:app_eoffice/models/VanBanDenItem.dart';
import 'package:app_eoffice/services/vanbanden_api.dart';

import 'base_bloc.dart';

class VanBanDenChuaChuyenBloc extends Blocdispose {
  int currentPageNow = 1;
  int currentPage = 1;
  int total = 0;
  var _lstobject = <VanBanDenItem>[];
  final _repository = Vanbanden_api();

  var _isLoadingMore = false;
  var _currentStoryIndex = 0;

  StreamController<List<VanBanDenItem>> _topStories_cxlStreamController =
      StreamController();
  Stream<List<VanBanDenItem>> get topStorieschuaxl =>
      _topStories_cxlStreamController.stream;
  var dataquery = {
    "CurrentPage": '1',
    "RowPerPage": '10',
    "SearchIn": 'SoKyHieu,TrichYeu',
    "Keyword": '',
    "Loai": '3',
    "LoaiListID": '0'
  };
  VanBanDenChuaChuyenBloc(keyword, loai, loaiListID, checkvt) {
    _loadInitTopStories(keyword, loai, loaiListID, checkvt);
  }
  void _loadInitTopStories(keyword, loai, loaiListID, checkvt) async {
    loadMore(keyword, loai, loaiListID, checkvt);
  }

  void loadtop(keyword, loai, loaiListID, checkvt) async {
    _topStories_cxlStreamController = new StreamController();
    _lstobject = new List<VanBanDenItem>();
    currentPage = 1;
    loadMore(keyword, loai, loaiListID, checkvt);
  }

  void loadMore(keyword, loai, loaiListID, checkvt) async {
    dataquery = {
      "CurrentPage": "" + currentPage.toString() + "",
      "RowPerPage": '10',
      "SearchIn": 'SoKyHieu,TrichYeu',
      "Keyword": '' + keyword + '',
      "Loai": '' + loai.toString() + '',
      "LoaiListID": '' + loaiListID.toString() + ''
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
      if (checkvt == 1)
        lst = await _repository.getvanbanden(dataquery, currentPage);
      else
        lst = await _repository.getvanbandennguoidung(dataquery, currentPage);
      if (lst.length > 0) total = lst[0].total;
      _lstobject.addAll(lst);
      _currentStoryIndex = _lstobject.length;
      if (!_topStories_cxlStreamController.isClosed)
        _topStories_cxlStreamController.sink.add(_lstobject);
      currentPage = currentPage + 1;
    }
  }

  bool hasMoreStories() => _currentStoryIndex < total;

  @override
  void dispose() {
    _topStories_cxlStreamController.close();
  }
}
