import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
import 'package:vjhero/pages/login_page.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'VJHero',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
        useMaterial3: true,
      ),
      home: LoginPage(),
      debugShowCheckedModeBanner: false,
    );
  }
}


// import 'package:flutter/material.dart';
// import 'package:webview_flutter/webview_flutter.dart';
// import 'package:flutter/foundation.dart' show kIsWeb;
//
// void main() {
//   WidgetsFlutterBinding.ensureInitialized();
//
//   // Only initialize WebView platform if not running on web
//   if (!kIsWeb) {
//     late final PlatformWebViewControllerCreationParams params;
//     params = const PlatformWebViewControllerCreationParams();
//     WebViewController.fromPlatformCreationParams(params);
//   }
//
//   runApp(const MyApp());
// }
//
// class MyApp extends StatelessWidget {
//   const MyApp({Key? key}) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: 'WebView Example',
//       theme: ThemeData(
//         primarySwatch: Colors.blue,
//       ),
//       home: const WebViewExample(),
//     );
//   }
// }
//
// class WebViewExample extends StatefulWidget {
//   const WebViewExample({Key? key}) : super(key: key);
//
//   @override
//   State<WebViewExample> createState() => _WebViewExampleState();
// }
//
// class _WebViewExampleState extends State<WebViewExample> {
//   late final WebViewController _controller;
//   bool _isLoading = true;
//
//   @override
//   void initState() {
//     super.initState();
//     if (!kIsWeb) {
//       _initializeWebView();
//     }
//   }
//
//   void _initializeWebView() {
//     _controller = WebViewController()
//       ..setJavaScriptMode(JavaScriptMode.unrestricted)
//       ..setBackgroundColor(const Color(0x00000000))
//       ..setNavigationDelegate(
//         NavigationDelegate(
//           onProgress: (int progress) {
//             if (progress == 100) {
//               setState(() {
//                 _isLoading = false;
//               });
//             }
//           },
//           onPageStarted: (String url) {
//             setState(() {
//               _isLoading = true;
//             });
//           },
//           onPageFinished: (String url) {
//             setState(() {
//               _isLoading = false;
//             });
//           },
//           onWebResourceError: (WebResourceError error) {
//             debugPrint('WebView error: ${error.description}');
//           },
//           onNavigationRequest: (NavigationRequest request) {
//             if (request.url.startsWith('https://www.youtube.com/')) {
//               debugPrint('blocking navigation to ${request.url}');
//               return NavigationDecision.prevent;
//             }
//             return NavigationDecision.navigate;
//           },
//         ),
//       )
//       ..loadRequest(Uri.parse('https://automation.vnrvjiet.ac.in/eduprime3'));
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         title: const Text('Akhil\'s Eduprime'),
//       ),
//       body: kIsWeb
//           ? const Center(
//         child: Text('WebView is not supported on web platform'),
//       )
//           : Stack(
//         children: [
//           WebViewWidget(controller: _controller),
//           if (_isLoading)
//             const Center(
//               child: CircularProgressIndicator(),
//             )
//         ],
//       ),
//     );
//   }
// }