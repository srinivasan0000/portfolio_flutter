import 'package:web/web.dart' as wasm;

class TWebUtils {
  static dynamic appContainer() {
    // return wasm.window.document.getElementById('app-container');
    return null;
  }

  static void openUrl(String url) {
    wasm.window.open(url, '_blank');
  }

  static dynamic openWindowForFooter(String url) {
    final x = wasm.window.screenLeft;
    final y = wasm.window.screenTop;
    const width = 900;
    final height = wasm.window.innerHeight;
    final options = 'top=$y,left=$x,width=$width,height=$height';
    return wasm.window.open(url, '_blank', options);
  }

  static void windowClose(dynamic web) => web.close();
}


