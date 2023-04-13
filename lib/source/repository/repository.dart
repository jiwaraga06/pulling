import 'package:pulling/source/network/network.dart';

class MyRepository {
  final MyNetwork? myNetwork;

  MyRepository({required this.myNetwork});

  Future getShift() async {
    var json = await myNetwork!.getShift();
    return json;
  }

  Future login(scan, value) async {
    var json = await myNetwork!.login(scan, value);
    return json;
  }

  Future getPulling(scan, tgl_awal, tgl_akhir) async {
    var json = await myNetwork!.getPulling(scan, tgl_awal, tgl_akhir);
    return json;
  }

  Future pullingScanInsert(scan) async {
    var json = await myNetwork!.pullingScanInsert(scan);
    return json;
  }

  Future pullingSave(body) async {
    var json = await myNetwork!.pullingSave(body);
    return json;
  }

  Future pullingskipwc(shift, nik, scan) async {
    var json = await myNetwork!.pullingskipwc(shift, nik, scan);
    return json;
  }

  Future pullingunskipwc(shift, nik, scan) async {
    var json = await myNetwork!.pullingunskipwc(shift, nik, scan);
    return json;
  }

}
