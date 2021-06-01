import 'dart:async';
import 'package:app_eoffice/block/base/event.dart';
import 'package:app_eoffice/block/base/state.dart';
import 'package:app_eoffice/models/WorkTaskItem.dart';
import 'package:app_eoffice/services/CongViec_Api.dart';
import 'package:app_eoffice/utils/Base.dart';
import 'base_bloc.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class CongViecblock extends Blocdispose {
  int currentPageNow = 1;
  int currentPage = 1;
  int total = 0;
  int totaldelete = 0;
  bool isloadingdelete = true;
  var _lstobject = <WorkTaskItem>[];
  final _repository = CongViec_Api();

  var _isLoadingMore = false;

  var currentStoryIndex = 0;
  StreamController<List<WorkTaskItem>> topStoriesStreamController =
      StreamController();
  Stream<List<WorkTaskItem>> get topStories =>
      topStoriesStreamController.stream;
  var dataquery = {
    "CurrentPage": '1',
    "RowPerPage": '10',
    "SearchIn": 'SoKyHieu,TrichYeu',
    "Keyword": '',
  };
  CongViecblock(keyword, type) {
    _loadInitTopStories(keyword, type);
  }

  void _loadInitTopStories(keyword, type) async {
    loadMore(keyword, type);
  }

  void loadtop(keyword, type) async {
    topStoriesStreamController = new StreamController();
    _lstobject = <WorkTaskItem>[];
    currentPage = 1;
    totaldelete = 0;
    isloadingdelete = true;
    loadMore(keyword, type);
  }

  Future<Null> loadtopref(keyword, type) async {
    topStoriesStreamController = new StreamController();
    _lstobject = <WorkTaskItem>[];
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
      "RowPerPage": '10',
      "SearchIn": 'Title,Description',
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
        var lst = await _repository.getcongviec(dataquery, currentPage);
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

class BlocCongViecAction extends Bloc<ActionEvent, ActionState> {
  BlocCongViecAction() : super(DoneState());
  get initialState => DoneState();

  bool isError = false;
  CongViec_Api objapi = new CongViec_Api();
  static get loginItem => loginItem;

  @override
  Stream<ActionState> mapEventToState(ActionEvent event) async* {
    try {
      isError = false;
      yield LoadingState();
      if (event is AddEvent) {
        await objapi.postaddcongviec(event.data).then((objdata) {
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
      if (event is UploadfileEvent) {
        await objapi.postuploadfile(event.data, event.donviid).then((objdata) {
          if (objdata["Error"] == true) isError = true;
          // lstfile = objdata["Data"];
        });
      }
      if (event is FinshEvent) {
        await objapi.postfinsh(event.data).then((objdata) {
          if (objdata["Error"] == true) isError = true;
          basemessage = objdata["Title"];
        });
        yield DoneState();
      }
    } catch (ex) {}
  }
}
