import 'package:app_eoffice/models/DanhMucGiaTriItem.dart';
import 'package:app_eoffice/models/UserDonViItem.dart';
import 'package:app_eoffice/models/UserItem.dart';
import 'package:app_eoffice/models/UserNhomNguoiDungItem.dart';
import 'package:app_eoffice/models/FileAttachItem.Dart';

class WorkTaskItem {
  int id;
  String code;
  String title;
  String description;
  String fullText;
  String keyword;
  int createdUserID;
  String createdUserName;
  String userPerform;
  String userFollow;
  String groupPerform;
  String groupFollow;
  String userGroupPerform;
  String userGroupFollow;
  String startDate;
  String endDate;
  String createdDate;
  int status;
  int parentID;
  String taskAllID;
  int projectID;
  int inDocumentID;
  int outDocumentID;
  int progress;
  String finishDate;
  String actuallyStartDate;
  String actuallyEndDate;
  List<DanhMucGiaTriItem> lstdanhmucgt;

  List<UserItem> ltsUserPerform;
  List<UserItem> ltsUserFollow;
  List<UserNhomNguoiDungItem> ltsUserGroupFollow;
  List<UserNhomNguoiDungItem> ltsUserGroupPerform;
  List<UserDonViItem> ltsGroupFollow;
  List<UserDonViItem> ltsGroupPerform;
  String tenNguoiTao;
  int totalRecord;
  String strTrangthai;
  List<FileAttachItem> lstfile;
  WorkTaskItem({
    this.id,
    this.code,
    this.title,
    this.description,
    this.fullText,
    this.keyword,
    this.createdUserID,
    this.createdUserName,
    this.userPerform,
    this.userFollow,
    this.groupPerform,
    this.groupFollow,
    this.userGroupPerform,
    this.userGroupFollow,
    this.startDate,
    this.endDate,
    this.createdDate,
    this.status,
    this.parentID,
    this.taskAllID,
    this.projectID,
    this.inDocumentID,
    this.outDocumentID,
    this.progress,
    this.finishDate,
    this.actuallyStartDate,
    this.actuallyEndDate,
    this.lstdanhmucgt,
    this.ltsUserPerform,
    this.ltsUserFollow,
    this.ltsUserGroupFollow,
    this.ltsUserGroupPerform,
    this.ltsGroupFollow,
    this.ltsGroupPerform,
    this.tenNguoiTao,
    this.totalRecord,
    this.strTrangthai,
    this.lstfile,
  });
  WorkTaskItem.fromMap(Map<String, dynamic> map) {
    id = map['ID'];
    code = map['Code'];
    title = map['Title'];
    description = map['Description'];
    fullText = map['FullText'];
    keyword = map['keyword'];
    createdUserID = map['CreatedUserID'];
    createdUserName = map['CreatedUserName'];
    userPerform = map['UserPerform'];
    userFollow = map['UserFollow'];
    groupPerform = map['GroupPerform'];
    groupFollow = map['GroupFollow'];
    userGroupPerform = map['UserGroupPerform'];
    userGroupFollow = map['UserGroupFollow'];
    startDate = map['StartDate'];
    endDate = map['EndDate'];
    createdDate = map['CreatedDate'];
    status = map['Status'];
    parentID = map['ParentID'];
    taskAllID = map['TaskAllID'];
    projectID = map['projectID'];
    inDocumentID = map['InDocumentID'];
    outDocumentID = map['OutDocumentID'];
    progress = map['Progress'];
    finishDate = map['FinishDate'];
    actuallyStartDate = map['ActuallyStartDate'];
    actuallyEndDate = map['ActuallyEndDate'];
    totalRecord = map['TotalRecord'];
    strTrangthai = map['strTrangthai'];
    if (map['LtsFileAttach'] != null && map['LtsFileAttach'].length > 0) {
      List<dynamic> vbData = map['LtsFileAttach'];
      lstfile = vbData.map((f) => FileAttachItem.fromMap(f)).toList();
    } else
      lstfile = <FileAttachItem>[];

    if (map['LtsUserPerform'] != null && map['LtsUserPerform'].length > 0) {
      List<dynamic> vbData = map['LtsUserPerform'];
      ltsUserPerform = vbData.map((f) => UserItem.fromMap(f)).toList();
    } else
      ltsUserPerform = <UserItem>[];

    if (map['LtsUserFollow'] != null && map['LtsUserFollow'].length > 0) {
      List<dynamic> vbData = map['LtsUserFollow'];
      ltsUserFollow = vbData.map((f) => UserItem.fromMap(f)).toList();
    } else
      ltsUserFollow = new List<UserItem>();

    if (map['LtsGroupPerform'] != null && map['LtsGroupPerform'].length > 0) {
      List<dynamic> vbData = map['LtsGroupPerform'];
      ltsGroupPerform = vbData.map((f) => UserDonViItem.fromMap(f)).toList();
    } else
      ltsGroupPerform = <UserDonViItem>[];

    if (map['LtsGroupFollow'] != null && map['LtsGroupFollow'].length > 0) {
      List<dynamic> vbData = map['LtsGroupFollow'];
      ltsGroupFollow = vbData.map((f) => UserDonViItem.fromMap(f)).toList();
    } else
      ltsGroupFollow = new List<UserDonViItem>();

    if (map['LtsUserGroupPerform'] != null &&
        map['LtsUserGroupPerform'].length > 0) {
      List<dynamic> vbData = map['LtsUserGroupPerform'];
      ltsUserGroupPerform =
          vbData.map((f) => UserNhomNguoiDungItem.fromMap(f)).toList();
    } else
      ltsUserGroupPerform = new List<UserNhomNguoiDungItem>();

    if (map['LtsUserGroupFollow'] != null &&
        map['LtsUserGroupFollow'].length > 0) {
      List<dynamic> vbData = map['LtsUserGroupFollow'];
      ltsUserGroupFollow =
          vbData.map((f) => UserNhomNguoiDungItem.fromMap(f)).toList();
    } else
      ltsUserGroupFollow = new List<UserNhomNguoiDungItem>();

    if (map['LtsDanhMucGiaTri'] != null && map['LtsDanhMucGiaTri'].length > 0) {
      List<dynamic> vbData = map['LtsDanhMucGiaTri'];
      lstdanhmucgt = vbData.map((f) => DanhMucGiaTriItem.fromMap(f)).toList();
    } else
      lstdanhmucgt = new List<DanhMucGiaTriItem>();
  }
}
