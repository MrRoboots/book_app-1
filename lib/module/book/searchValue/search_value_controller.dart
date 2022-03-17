import 'package:book_app/mapper/book_db_provider.dart';
import 'package:book_app/mapper/chapter_db_provider.dart';
import 'package:book_app/module/book/home/book_home_controller.dart';
import 'package:book_app/util/parse_book.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:get/get.dart';

class SearchValueController extends GetxController {
  InAppWebViewController? webViewController;
  bool showParseButton = false;
  double loadProcess = 0;
  bool showLoadProcess = false;
  int siteIndex = 0;

  List<List<String>> sites =  [
      ["神马小说", "https://quark.sm.cn/s?q=&from=smor&safe=1"],
      ["360搜索", "https://m.so.com/s?q="],
      ["必应搜索", "https://cn.bing.com/search?q="],
    ];

  pop() async{
    if (webViewController != null) {
      if (await webViewController!.canGoBack()) {
        for (int i = 0; i < sites.length; i++) {
          if (sites[i][1].contains((await webViewController!.getUrl())!.origin)) {
            Get.back();
            break;
          }
        }
        webViewController!.goBack();
      } else {
        Get.back();
      }
    } else {
      Get.back();
    }
  }

  parse() async{
    await parseBook((await webViewController!.getTitle())!, (await webViewController!.getUrl())!.toString());
  }

  @override
  void onClose() {
    super.onClose();
    BookHomeController bookHomeController = Get.find();
    bookHomeController.getBookList();
  }
}

class ValueFormat {
  String content;
  bool red;

  ValueFormat(this.content, this.red);
}
