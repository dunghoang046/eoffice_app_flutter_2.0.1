import 'dart:async';
import 'package:app_eoffice/block/base/event.dart';
import 'package:app_eoffice/block/base/state.dart';
import 'package:app_eoffice/models/VanBanDenItem.dart';
import 'package:app_eoffice/services/Vanbanden_api.dart';
import 'package:app_eoffice/utils/Base.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'base_bloc.dart';

class VanBanDenBloc extends Blocdispose {
  int currentPageNow = 1;
  int currentPage = 1;
  int total = 0;
  var _lstobject = List<VanBanDenItem>();
  final _repository = Vanbanden_api();

  var _isLoadingMore = false;
  var _currentStoryIndex = 0;

  StreamController<List<VanBanDenItem>> _topStoriesStreamController =
      StreamController();
  Stream<List<VanBanDenItem>> get topStories =>
      _topStoriesStreamController.stream;
  var dataquery = {
    "CurrentPage": '1',
    "RowPerPage": '10',
    "SearchIn": 'SoKyHieu,TrichYeu',
    "Keyword": '',
    "Loai": '3',
    "LoaiListID": '0'
  };
  VanBanDenBloc(keyword, loai, loaiListID, checkvt) {
    _loadInitTopStories(keyword, loai, loaiListID, checkvt);
  }
  void _loadInitTopStories(keyword, loai, loaiListID, checkvt) async {
    loadMore(keyword, loai, loaiListID, checkvt);
  }

  void loadtop(keyword, loai, loaiListID, checkvt) async {
    _topStoriesStreamController = new StreamController();
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

Vanbanden_api objapi = new Vanbanden_api();

class BlocVanBanDenAction extends Bloc<ActionEvent, ActionState> {
  BlocVanBanDenAction() : super(DoneState());

  @override
  Stream<ActionState> mapEventToState(ActionEvent event) async* {
    try {
      bool isError = false;
      yield LoadingState();
      if (event is FinshEvent) {
        await objapi.postketthuc(event.data).then((objdata) {
          if (objdata["Error"] == true) isError = true;
          basemessage = objdata["Title"];
        });
        if (isError)
          yield ErrorState();
        else
          yield DoneState();
      }
      if (event is HoanThanhEvent) {
        await objapi.posthoanthanh(event.data).then((objdata) {
          if (objdata["Error"] == true) isError = true;
          basemessage = objdata["Title"];
        });
        if (isError)
          yield ErrorState();
        else
          yield DoneState();
      }
      if (event is YKienEvent) {
        await objapi.postykien(event.data).then((objdata) {
          if (objdata["Error"] == true) isError = true;
          basemessage = objdata["Title"];
        });
        if (isError)
          yield ErrorState();
        else
          yield DoneState();
      }
      if (event is RejectEvent) {
        await objapi.posttralai(event.data).then((objdata) {
          if (objdata["Error"] == true) isError = true;
          basemessage = objdata["Title"];
        });
        if (isError)
          yield ErrorState();
        else
          yield DoneState();
      }
      if (event is ListEvent) {
        yield ViewState();
      }
      if (event is ViewYKienEvent) {
        yield ViewYKienState();
      }
      if (event is NoEven) yield NoState();
    } catch (ex) {}
  }
}
