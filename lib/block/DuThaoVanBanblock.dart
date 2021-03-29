import 'dart:async';
import 'package:app_eoffice/block/base/event.dart';
import 'package:app_eoffice/block/base/state.dart';
import 'package:app_eoffice/models/DuThaoVanBanItem.dart';
import 'package:app_eoffice/services/VanBanDuThao_Api.dart';
import 'package:app_eoffice/utils/Base.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'base_bloc.dart';

class DuThaoVanBanblock extends Blocdispose {
  int currentPageNow = 1;
  int currentPage = 1;
  int total = 0;
  var _lstobject = <DuThaoVanBanItem>[];
  final _repository = DuThaoVanBan_api();

  var _isLoadingMore = false;
  var _currentStoryIndex = 0;

  StreamController<List<DuThaoVanBanItem>> _topStoriesStreamController =
      StreamController();
  final _actionController = StreamController<bool>();
  Stream<List<DuThaoVanBanItem>> get topStories =>
      _topStoriesStreamController.stream;
  var dataquery = {
    "CurrentPage": '1',
    "RowPerPage": '10',
    "SearchIn": 'SoKyHieu,TrichYeu',
    "Keyword": '',
    "Loai": '0',
    "LoaiListID": '0'
  };
  DuThaoVanBanblock(keyword, type) {
    _loadInitTopStories(keyword, type);
  }
  void _loadInitTopStories(keyword, type) async {
    loadMore(keyword, type);
  }

  void loadtop(keyword, type) async {
    _topStoriesStreamController = new StreamController();
    _lstobject = <DuThaoVanBanItem>[];
    currentPage = 1;
    loadMore(keyword, type);
  }

  void loadMore(keyword, type) async {
    dataquery = {
      "CurrentPage": "" + currentPage.toString() + "",
      "RowPerPage": '10',
      "SearchIn": 'SoKyHieu,TrichYeu',
      "Keyword": '' + keyword + '',
      "Loai": '' + type.toString() + '',
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

DuThaoVanBan_api objapi = new DuThaoVanBan_api();

class BlocDuThaoVanBanAction extends Bloc<ActionEvent, ActionState> {
  BlocDuThaoVanBanAction() : super(DoneState());

  @override
  Stream<ActionState> mapEventToState(ActionEvent event) async* {
    try {
      bool isError = false;
      if (event is TrinhLDEvent) {
        yield LoadingState();
        await objapi.posttrinhky(event.data).then((objdata) {
          if (objdata["Error"] == true) isError = true;
          basemessage = objdata["Title"];
        });
        if (isError)
          yield ErrorState();
        else
          yield DoneState();
      }
      if (event is YKienEvent) {
        yield LoadingState();
        await objapi.postykien(event.data).then((objdata) {
          if (objdata["Error"] == true) isError = true;
          basemessage = objdata["Title"];
        });
        if (isError)
          yield ErrorState();
        else
          yield DoneState();
      }
      if (event is NoEven) yield NoState();
      if (event is ViewYKienEvent) yield ViewYKienState();
    } catch (ex) {}
  }
}
