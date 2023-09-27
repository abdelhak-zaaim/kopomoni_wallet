import 'dart:async';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:six_cash/controller/profile_screen_controller.dart';
import 'package:six_cash/util/app_constants.dart';
import 'package:six_cash/view/base/animated_custom_dialog.dart';
import 'package:six_cash/view/base/custom_loader.dart';
import 'package:six_cash/view/base/my_dialog.dart';
import 'package:six_cash/view/screens/deshboard/nav_bar_screen.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';


class WebScreen extends StatefulWidget {
  final String selectedUrl;
  final bool? isPaymentUrl;
  const WebScreen({Key? key, required this.selectedUrl, this.isPaymentUrl = false}) : super(key: key);

  @override
  State<WebScreen> createState() => _WebScreenState();
}

class _WebScreenState extends State<WebScreen> {
  double value = 0.0;
  late WebViewController controllerGlobal;

  PullToRefreshController? pullToRefreshController;
  late MyInAppBrowser browser;


  @override
  void initState() {
    super.initState();
    _initData();

  }

  void _initData() async {
    browser = MyInAppBrowser(widget.isPaymentUrl!);
    if (Platform.isAndroid) {
      await AndroidInAppWebViewController.setWebContentsDebuggingEnabled(true);

      bool swAvailable = await AndroidWebViewFeature.isFeatureSupported(AndroidWebViewFeature.SERVICE_WORKER_BASIC_USAGE);
      bool swInterceptAvailable = await AndroidWebViewFeature.isFeatureSupported(AndroidWebViewFeature.SERVICE_WORKER_SHOULD_INTERCEPT_REQUEST);

      if (swAvailable && swInterceptAvailable) {
        AndroidServiceWorkerController serviceWorkerController = AndroidServiceWorkerController.instance();
        await serviceWorkerController.setServiceWorkerClient(AndroidServiceWorkerClient(
          shouldInterceptRequest: (request) async {
            return null;
          },
        ));
      }
    }

    pullToRefreshController = PullToRefreshController(
      options: PullToRefreshOptions(
        color: Colors.black,
      ),
      onRefresh: () async {
        if (Platform.isAndroid) {
          browser.webViewController?.reload();
        } else if (Platform.isIOS) {
          browser.webViewController?.loadUrl(urlRequest: URLRequest(url: await browser.webViewController?.getUrl()));
        }
      },
    );
    browser.pullToRefreshController = pullToRefreshController;

    await browser.openUrlRequest(
      urlRequest: URLRequest(url: WebUri.uri(Uri.parse(widget.selectedUrl))),
      options: InAppBrowserClassOptions(
        inAppWebViewGroupOptions: InAppWebViewGroupOptions(
          crossPlatform: InAppWebViewOptions(useShouldOverrideUrlLoading: true, useOnLoadResource: true),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () =>_exitApp(context),
      child: Scaffold(
        body: Center(
          child: Stack(
            children: [
               Center(
                child: CustomLoader(color: Theme.of(context).primaryColor),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<bool> _exitApp(BuildContext context) async {
    if (await controllerGlobal.canGoBack()) {
      controllerGlobal.goBack();
      return Future.value(false);
    } else {
      if(context.mounted) {
        Navigator.of(context).pushAndRemoveUntil(MaterialPageRoute(builder: (_) => const NavBarScreen()), (route) => false);

        showAnimatedDialog(context, MyDialog(
          icon: Icons.clear,
          title: 'payment_cancelled'.tr,
          description: 'your_payment_cancelled'.tr,
          isFailed: true,
        ), dismissible: false, isFlip: true);
      }
      return Future.value(true);
    }
  }
}


class MyInAppBrowser extends InAppBrowser {
  final bool isPaymentUrl;

  bool _canRedirect = true;

  MyInAppBrowser(this.isPaymentUrl);

  @override
  Future onBrowserCreated() async {
    debugPrint("\n\nBrowser Created!\n\n");

  }

  @override
  Future onLoadStart(url) async {
    debugPrint("\n\nStarted: $url\n\n");

    _pageRedirect(url.toString());
  }

  @override
  Future onLoadStop(url) async {
    pullToRefreshController?.endRefreshing();
    debugPrint("\n\nStopped: $url\n\n");

    _pageRedirect(url.toString());
  }

  @override
  void onLoadError(url, code, message) {
    pullToRefreshController?.endRefreshing();
    debugPrint("Can't load [$url] Error: $message");
  }

  @override
  void onProgressChanged(progress) {
    if (progress == 100) {
      pullToRefreshController?.endRefreshing();
    }

    debugPrint("Progress: $progress");

  }

  @override
  void onExit() {
    if(_canRedirect) {
      Navigator.of(Get.context!).pushAndRemoveUntil(MaterialPageRoute(builder: (_) => const NavBarScreen()), (route) => false);

    }

    debugPrint("\n\nBrowser closed!\n\n");

  }

  @override
  Future<NavigationActionPolicy> shouldOverrideUrlLoading(navigationAction) async {
    debugPrint("\n\nOverride ${navigationAction.request.url}\n\n");

    return NavigationActionPolicy.ALLOW;
  }

  @override
  void onLoadResource(resource) {
    // print("Started at: " + response.startTime.toString() + "ms ---> duration: " + response.duration.toString() + "ms " + (response.url ?? '').toString());
  }

  @override
  void onConsoleMessage(consoleMessage) {
    debugPrint("""
    console output:
      message: ${consoleMessage.message}
      messageLevel: ${consoleMessage.messageLevel.toValue()}
   """);
  }

  void _pageRedirect(String url) {
    
    
    
    
    
    if(_canRedirect && isPaymentUrl) {

      if(url.contains(AppConstants.baseUrl)) {
        bool isSuccess = url.contains('success');
        bool isFailed = url.contains('fail');


        if(isSuccess || isFailed) {
          _canRedirect = false;
          close();
        }


        if (isSuccess) {
          Get.offAll(const NavBarScreen());
          Get.find<ProfileController>().profileData(reload:true);

          showAnimatedDialog(Get.context!, MyDialog(
            icon: Icons.done,
            title: 'payment_done'.tr,
            description: 'your_payment_successfully_done'.tr,
          ), dismissible: false, isFlip: true);

        }

        } else{
        Get.offAll(const NavBarScreen());
        showAnimatedDialog(Get.context!, MyDialog(
            icon: Icons.clear,
            title: 'payment_failed'.tr,
            description: 'your_payment_failed'.tr,
            isFailed: true,
          ), dismissible: false, isFlip: true);
      }
    }
  }

}
