import 'package:app_eoffice/block/base/event.dart';
import 'package:app_eoffice/block/base/state.dart';
import 'package:app_eoffice/block/vanbandenbloc.dart';
import 'package:app_eoffice/components/components.dart';
import 'package:app_eoffice/utils/Base.dart';
import 'package:app_eoffice/utils/ColorUtils.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:simple_router/simple_router.dart';
import 'package:toast/toast.dart';

TextEditingController _noidung = new TextEditingController();

class MyTraLaiVanBanDen extends StatefulWidget {
  final id;
  MyTraLaiVanBanDen({this.id});
  @override
  _MyTraLaiVanBanDen createState() => new _MyTraLaiVanBanDen();
}

class _MyTraLaiVanBanDen extends State<MyTraLaiVanBanDen> {
  @override
  void dispose() {
    print('Đóng form trả lại vb đến');
    super.dispose();
  }

  @override
  void initState() {
    _noidung.text = '';
    BlocProvider.of<BlocVanBanDenAction>(context).add(ListEvent());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
        child: BlocBuilder<BlocVanBanDenAction, ActionState>(
      buildWhen: (previousState, state) {
        if (state is DoneState) {
          Toast.show(basemessage, context,
              duration: 2, gravity: Toast.TOP, backgroundColor: Colors.green);
          BlocProvider.of<BlocVanBanDenAction>(context).add(ListEvent());
          SimpleRouter.back();
        }
        if (state is ErrorState) {
          Toast.show(basemessage, context,
              duration: 2, gravity: Toast.TOP, backgroundColor: Colors.red);
        }
        return;
      },
      builder: (context, state) {
        return SafeArea(
            child: Container(
                child: Scaffold(
          appBar: AppBar(
            iconTheme: IconThemeData(color: Colors.white),
            title: Text(
              'Trả lại ',
              style: TextStyle(color: Colors.white),
            ),
            leading: new IconButton(
                icon: Icon(Icons.arrow_back),
                onPressed: () {
                  SimpleRouter.back();
                }),
            backgroundColor: colorbartop,
            actions: <Widget>[_onLoginClick()],
          ),
          body: SingleChildScrollView(
              child: Container(
            margin: EdgeInsets.fromLTRB(15, 10, 15, 0),
            child: Column(
              children: [
                rowlabel('Nội dung'),
                TextFormField(
                  controller: _noidung,
                  decoration: InputDecoration(hintText: 'Nhập nội dung'),
                ),
              ],
            ),
          )),
        )));
      },
    ));
  }

  Widget _onLoginClick() {
    return BlocBuilder<BlocVanBanDenAction, ActionState>(
        builder: (context, state) {
      if (state is LoadingState) {
        return ButtonAction(
          backgroundColor: Colors.blue,
          labelColor: Colors.white,
          label: 'Đang xử lý ...',
          mOnPressed: () => {},
        );
      } else if (state is ErrorState) {
        return ButtonAction(
          backgroundColor: Colors.blue,
          labelColor: Colors.white,
          icons: Icons.save,
          label: 'Trả lại',
          mOnPressed: () => {_click_add()},
        );
      } else {
        return ButtonAction(
          backgroundColor: Colors.blue,
          labelColor: Colors.white,
          icons: Icons.save,
          label: 'Trả lại',
          mOnPressed: () => _click_add(),
        );
        // }
      }
    });
  }

  // ignore: non_constant_identifier_names
  void _click_add() {
    if (_noidung != null && _noidung.text.length > 0) {
      var data = {
        "VanBanID": widget.id,
        "NoiDung": _noidung.text,
      };
      RejectEvent objEvent = new RejectEvent();
      objEvent.data = data;
      BlocProvider.of<BlocVanBanDenAction>(context).add(objEvent);
    } else
      Toast.show('Bạn chưa nhập nội dung', context,
          duration: 2, gravity: Toast.TOP, backgroundColor: Colors.red);
  }
}
