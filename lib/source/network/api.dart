String baseUrl = 'http://182.253.45.29:88/api-dev04';
String baseUrlPullingPublic = "http://182.253.45.29:88/api-trial-live/";
String baseUrlPullingLocal = "http://192.168.1.84:88/api-trial-live/";

class MyApi {
  static getShift() {
    return '$baseUrlPullingPublic/get_function/shift';
  }

  static login(scan, value) {
    return '$baseUrlPullingPublic/login/scan/$scan/$value';
  }

// PULLING
  static pulling(scan, tgl_awal, tgl_akhir) {
    return '$baseUrlPullingPublic/pages/dashboard/get/$scan/$tgl_awal/$tgl_akhir';
  }

  static pullingScanInsert(scan) {
    return '$baseUrlPullingPublic/pages/pooling/scan/$scan';
  }

  static pullingSave() {
    return '$baseUrlPullingPublic/pages/pooling/save';
  }

  static pullingskipwc(shift, nik, scan) {
    return '$baseUrlPullingPublic/pages/pooling/skip/$shift/$nik/$scan';
  }

  static pullingunskipwc(shift, nik, scan) {
    return '$baseUrlPullingPublic/pages/pooling/unskip/$shift/$nik/$scan';
  }

}
