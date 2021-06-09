import 'dart:async';
import 'package:app_eoffice/block/base/event.dart';
import 'package:app_eoffice/block/base/state.dart';
import 'package:app_eoffice/models/VanBanDiItem.dart';
import 'package:app_eoffice/services/vanbandi_api.dart';
import 'package:app_eoffice/utils/Base.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'base_bloc.dart';

class VanBanDiBloc extends Blocdispose {
  int currentPageNow = 1;
  int currentPage = 1;
  int total = 0;
  var _lstobject = List<VanBanDiItem>();
  final _repository = Vanbandi_api();

  var _isLoadingMore = false;
  var _currentStoryIndex = 0;

  StreamController<List<VanBanDiItem>> _topStoriesStreamController =
      StreamController();
  final _actionController = StreamController<bool>();
  Stream<List<VanBanDiItem>> get topStories =>
      _topStoriesStreamController.stream;
  var dataquery = {
    "CurrentPage": '1',
    "RowPerPage": '10',
    "SearchIn": 'SoKyHieu,TrichYeu',
    "Keyword": '',
    "Loai": '3',
    "LoaiListID": '0'
  };
  VanBanDiBloc(keyword, type) {
    _loadInitTopStories(keyword, type);
  }
  void _loadInitTopStories(keyword, type) async {
    loadMore(keyword, type);
  }

  void loadtop(keyword, type) async {
    _topStoriesStreamController = new StreamController();
    _lstobject = <VanBanDiItem>[];
    currentPage = 1;
    loadMore(keyword, type);
  }

  void loadMore(keyword, type) async {
    dataquery = {
      "CurrentPage": "" + currentPage.toString() + "",
      "RowPerPage": '10',
      "SearchIn": 'SoKyHieu,TrichYeu',
      "Keyword": '' + keyword + '',
      "Type": '' + type.toString() + '',
      // "LoaiListID": '' + loaiListID.toString() + ''
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
      var lst = await _repository.getvanban(dataquery, currentPage);
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

Vanbandi_api objapi = new Vanbandi_api();

class BlocVanBanDiAction extends Bloc<ActionEvent, ActionState> {
  BlocVanBanDiAction() : super(DoneState());
  @override
  Stream<ActionState> mapEventToState(ActionEvent event) async* {
    try {
      bool isError = false;
      if (event is ChuyenVanBanEvent) {
        yield LoadingState();
        await objapi.postchuyenvanban(event.data).then((objdata) {
          if (objdata["Error"] == true) isError = true;
          basemessage = objdata["Title"];
        });
        if (isError)
          yield ErrorState();
        else
          yield ViewState();
        ;
      }
      if (event is NoEven) yield NoState();
    } catch (ex) {}
  }
}
