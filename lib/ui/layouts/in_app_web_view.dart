import 'dart:collection';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_inappwebview/flutter_inappwebview.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../res/colors.dart';

extension WebExt on BuildContext {
  Future<void> openInAppWebUrl(String url, {String? pageTitle}) {
    return Navigator.push(
      this,
      MaterialPageRoute(
          builder: (context) => InAppWebViewScreen(
                pageTitle: pageTitle,
                webUrl: url,
              )),
    );
  }
}

class InAppWebViewScreen extends StatefulWidget {
  const InAppWebViewScreen({
    required this.webUrl,
    this.pageTitle,
    super.key,
  });

  final String? pageTitle;
  final String webUrl;

  @override
  InAppWebViewScreenState createState() => InAppWebViewScreenState();
}

class InAppWebViewScreenState extends State<InAppWebViewScreen> {
  final GlobalKey webViewKey = GlobalKey();

  InAppWebViewController? webViewController;
  var initialSettings = InAppWebViewSettings(
    useShouldOverrideUrlLoading: true,
    mediaPlaybackRequiresUserGesture: true,
    useHybridComposition: true,
    allowsInlineMediaPlayback: true,
  );

  late PullToRefreshController pullToRefreshController;
  late ContextMenu contextMenu;
  String url = "";
  double progress = 0;
  final urlController = TextEditingController();

  @override
  void initState() {
    super.initState();

    url = widget.webUrl;
    urlController.text = widget.webUrl;

    contextMenu = ContextMenu(
        menuItems: [
          ContextMenuItem(
              androidId: 1,
              iosId: "1",
              title: "Special",
              action: () async {
                //print("Menu item Special clicked!");
                //print(await webViewController?.getSelectedText());
                await webViewController?.clearFocus();
              })
        ],
        options: ContextMenuOptions(hideDefaultSystemContextMenuItems: false),
        onCreateContextMenu: (hitTestResult) async {
          /*print("onCreateContextMenu");
          print(hitTestResult.extra);
          print(await webViewController?.getSelectedText());*/
        },
        onHideContextMenu: () {
          //print("onHideContextMenu");
        },
        onContextMenuActionItemClicked: (contextMenuItemClicked) async {
          var id = (Platform.isAndroid)
              ? contextMenuItemClicked.androidId
              : contextMenuItemClicked.iosId;
          /*print("onContextMenuActionItemClicked: " +
              id.toString() +
              " " +
              contextMenuItemClicked.title);*/
        });

    pullToRefreshController = PullToRefreshController(
      settings: PullToRefreshSettings(
        color: Colors.blue,
      ),
      onRefresh: () async {
        if (Platform.isAndroid) {
          webViewController?.reload();
        } else if (Platform.isIOS) {
          webViewController?.loadUrl(
              urlRequest: URLRequest(url: await webViewController?.getUrl()));
        }
      },
    );
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          /*leading: const Icon(
            Icons.close,
            color: Colors.white,
          ),*/
          leading: IconButton(
            icon: const Icon(
              Icons.close,
              color: Colors.white,
            ),
            onPressed: () {
              /*Navigator.pop(context);*/
              showDialog(
                  context: context,
                  builder: (_) {
                    return AlertDialog(
                      backgroundColor: Colors.white,
                      title: const Text("Are you sure?"),
                      icon: const Icon(Icons.exit_to_app),
                      content: const Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text("Do you want to exit this page? "),
                        ],
                      ),
                      actions: [
                        TextButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          child: const Text(
                            "Cancel",
                            style: TextStyle(color: Colors.black54),
                          ),
                        ),
                        TextButton(
                          onPressed: () async {
                            await Navigator.maybePop(context);
                            if(context.mounted) {
                              await Navigator.maybePop(context);
                            }
                          },
                          child: const Text("Exit"),
                        ),
                      ],
                    );
                  });
            },
          ),
          title: Text(widget.pageTitle ?? ""),
          backgroundColor: AppColors.primary,
          systemOverlayStyle: SystemUiOverlayStyle.light,
          actions: [
            IconButton(
              icon: const Icon(
                Icons.arrow_back,
                color: Colors.white,
              ),
              onPressed: () {
                webViewController?.goBack();
              },
            ),
            IconButton(
              icon: const Icon(
                Icons.arrow_forward,
                color: Colors.white,
              ),
              onPressed: () {
                webViewController?.goForward();
              },
            ),
            IconButton(
              icon: const Icon(
                Icons.refresh,
                color: Colors.white,
              ),
              onPressed: () {
                webViewController?.reload();
              },
            ),
          ],
        ),
        //drawer: myDrawer(context: context),
        body: SafeArea(
            child: Column(children: <Widget>[
          Expanded(
            child: Stack(
              children: [
                InAppWebView(
                  key: webViewKey,
                  // contextMenu: contextMenu,
                  initialUrlRequest: URLRequest(url: WebUri(widget.webUrl)),
                  // initialFile: "assets/index.html",
                  initialUserScripts: UnmodifiableListView<UserScript>([]),
                  initialSettings: initialSettings,
                  pullToRefreshController: pullToRefreshController,
                  onWebViewCreated: (controller) {
                    webViewController = controller;
                  },
                  onLoadStart: (controller, url) {
                    setState(() {
                      this.url = url.toString();
                      urlController.text = this.url;
                    });
                  },
                  androidOnPermissionRequest:
                      (controller, origin, resources) async {
                    return PermissionRequestResponse(
                        resources: resources,
                        action: PermissionRequestResponseAction.GRANT);
                  },
                  shouldOverrideUrlLoading:
                      (controller, navigationAction) async {
                    var uri = navigationAction.request.url!;
    
                    if (![
                      "http",
                      "https",
                      "file",
                      "chrome",
                      "data",
                      "javascript",
                      "about"
                    ].contains(uri.scheme)) {
                      if (await canLaunch(url)) {
                        // Launch the App
                        await launch(url);
                        // and cancel the request
                        return NavigationActionPolicy.CANCEL;
                      }
                    }
    
                    return NavigationActionPolicy.ALLOW;
                  },
                  onLoadStop: (controller, url) async {
                    pullToRefreshController.endRefreshing();
                    setState(() {
                      this.url = url.toString();
                      urlController.text = this.url;
                    });
                  },
                  onLoadError: (controller, url, code, message) {
                    pullToRefreshController.endRefreshing();
                  },
                  onProgressChanged: (controller, progress) {
                    if (progress == 100) {
                      pullToRefreshController.endRefreshing();
                    }
                    setState(() {
                      this.progress = progress / 100;
                      urlController.text = url;
                    });
                  },
                  onUpdateVisitedHistory: (controller, url, androidIsReload) {
                    setState(() {
                      this.url = url.toString();
                      urlController.text = this.url;
                    });
                  },
                  onConsoleMessage: (controller, consoleMessage) {
                    //print(consoleMessage);
                  },
                ),
                progress < 1.0
                    ? LinearProgressIndicator(value: progress)
                    : Container(),
              ],
            ),
          ),
        ])));
  }
}
