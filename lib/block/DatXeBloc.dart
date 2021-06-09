import 'dart:async';
import 'package:app_eoffice/block/base/event.dart';
import 'package:app_eoffice/block/base/state.dart';
import 'package:app_eoffice/models/ThongTinDatXeItem.dart';
import 'package:app_eoffice/services/DatXe_Api.dart';
import 'package:app_eoffice/utils/Base.dart';
import 'base_bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class DatXeblock extends Blocdispose {
  int currentPageNow = 1;
  int currentPage = 1;
  int total = 0;
  int totaldelete = 0;
  bool isloadingdelete = true;
  var _lstobject = <ThongTinDatXeItem>[];
  final _repository = DatXe_Api();

  var _isLoadingMore = false;

  var currentStoryIndex = 0;
  StreamController<List<ThongTinDatXeItem>> topStoriesStreamController =
      StreamController();
  Stream<List<ThongTinDatXeItem>> get topStories =>
      topStoriesStreamController.stream;
  var dataquery = {
    "CurrentPage": '1',
    "RowPerPage": '10',
    "SearchIn": 'SoKyHieu,TrichYeu',
    "Keyword": '',
  };
  DatXeblock(keyword, type) {
    _loadInitTopStories(keyword, type);
  }

  void _loadInitTopStories(keyword, type) async {
    loadMore(keyword, type);
  }

  void loadtop(keyword, type) async {
    topStoriesStreamController = new StreamController();
    _lstobject = <ThongTinDatXeItem>[];
    currentPage = 1;
    totaldelete = 0;
    isloadingdelete = true;
    loadMore(keyword, type);
  }

  Future<Null> loadtopref(keyword, type) async {
    topStoriesStreamController = new StreamController();
    _lstobject = <ThongTinDatXeItem>[];
    currentPage = 1;
    loadMore(keyword, type);
  }

  bool inter = true;
  checkinter() async {
    inter = await checkinternet();
  }

  void loadMore(keyword, type) async {
    inter = await checkinternet();
    dataquery = {
      "CurrentPage": "" + currentPage.toString() + "",
      "RowPerPage": '15',
      "SearchIn": 'MoTa',
      "Keyword": '' + keyword + '',
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
      try {
        var lst = await _repository.getdatxe(dataquery, currentPage);
        if (lst.length > 0) total = lst[0].totalRecord;
        _lstobject.addAll(lst);
        currentStoryIndex = totaldelete + _lstobject.length;
        if (!topStoriesStreamController.isClosed)
          topStoriesStreamController.sink.add(_lstobject);
        currentPage = currentPage + 1;
      } catch (e) {
        throw Exception('Lỗi lấy dữ liệu: ' + e.toString());
      }
    }
  }

  bool hasMoreStories() => currentStoryIndex < total;
  bool checkinternetNo() => checkinternet();
  @override
  void dispose() {
    topStoriesStreamController.close();
  }
}

class BlocDatXeAction extends Bloc<ActionEvent, ActionState> {
  BlocDatXeAction() : super(DoneState());
  get initialState => DoneState();

  bool isError = false;
  DatXe_Api objapi = new DatXe_Api();
  static get loginItem => loginItem;

  @override
  Stream<ActionState> mapEventToState(ActionEvent event) async* {
    try {
      isError = false;
      yield LoadingState();
      if (event is SendEvent) {
        await objapi.postsenddatxe(event.data).then((objdata) {
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
      if (event is ApproverEvent) {
        await objapi.postapproveddatxe(event.data).then((objdata) {
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
      if (event is RejectEvent) {
        await objapi.postReject(event.data).then((objdata) {
          if (objdata["Error"] == true) isError = true;
          basemessage = objdata["Title"];
        });
        yield DoneState();
      }
    } catch (ex) {
      yield ErrorState();
    }
  }
}
