import 'package:flutter/material.dart';
import 'package:vjhero/widgets/sidebar.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:provider/provider.dart';
import 'package:vjhero/main.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text('VJHero Home'),
        actions: [
          IconButton(
            icon: Icon(themeProvider.isDarkMode ? Icons.dark_mode : Icons.light_mode),
            onPressed: () {
              themeProvider.toggleTheme();
            },
          ),
        ],
      ),
      drawer: Sidebar(),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Welcome, User!',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
            Text('Explore your workspace below:'),
            SizedBox(height: 20),
            Expanded(
              child: GridView.count(
                crossAxisCount: 2,
                crossAxisSpacing: 10,
                mainAxisSpacing: 10,
                children: [
                  _buildFeatureCard('assets/images/vnr.png', 'Eduprime', context, WebViewPage(title: 'Eduprime', url: 'https://automation.vnrvjiet.ac.in/EduPrime3/')),
                  _buildFeatureCard('assets/images/google.png', 'Google', context, WebViewPage(title: 'Google', url: 'https://www.google.com')),
                  _buildFeatureCard('assets/images/youtube.png', 'Youtube', context, WebViewPage(title: 'Youtube', url: 'https://www.youtube.com/')),
                  _buildFeatureCard('assets/images/calender.png', 'Calendar', context, WebViewPage(title: 'Calendar', url: 'https://calendar.google.com')),
                  _buildFeatureCard('assets/images/cloud.png', 'Cloud', context, WebViewPage(title: 'Cloud', url: 'https://cloud.google.com')),
                  _buildFeatureCard('assets/images/drive.png', 'Drive', context, WebViewPage(title: 'Drive', url: 'https://drive.google.com')),
                  _buildFeatureCard('assets/images/mail.png', 'Mail', context, WebViewPage(title: 'Mail', url: 'https://mail.google.com')),
                  _buildFeatureCard('assets/images/meet.png', 'Meet', context, WebViewPage(title: 'Meet', url: 'https://meet.google.com')),
                  _buildFeatureCard('assets/images/instagram.png', 'Instagram', context, WebViewPage(title: 'Instagram', url: 'https://www.instagram.com')),
                  _buildFeatureCard('assets/images/x.png', 'X', context, WebViewPage(title: 'X', url: 'https://www.x.com')),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildFeatureCard(String imagePath, String title, BuildContext context, Widget page) {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      child: InkWell(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => page),
          );
        },
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Fixed size for all images
            Image.asset(
              imagePath,
              width: 50, // Set fixed width
              height: 50, // Set fixed height
              fit: BoxFit.contain, // Ensures image is scaled within the given size
            ),
            SizedBox(height: 10),
            Text(title, style: TextStyle(fontSize: 16)),
          ],
        ),
      ),
    );
  }
}

class WebViewPage extends StatefulWidget {
  final String title;
  final String url;

  const WebViewPage({Key? key, required this.title, required this.url}) : super(key: key);

  @override
  _WebViewPageState createState() => _WebViewPageState();
}

class _WebViewPageState extends State<WebViewPage> {
  bool isLoading = true;
  late WebViewController controller;

  @override
  void initState() {
    super.initState();

    controller = WebViewController()
      ..setJavaScriptMode(JavaScriptMode.unrestricted)
      ..setNavigationDelegate(
        NavigationDelegate(
          onPageStarted: (String url) {
            setState(() {
              isLoading = true;
            });
          },
          onPageFinished: (String url) {
            setState(() {
              isLoading = false;
            });
          },
          onWebResourceError: (WebResourceError error) {
            print('WebView Error: ${error.description}');
          },
        ),
      )
      ..loadRequest(Uri.parse(widget.url));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
        actions: [
          IconButton(
            icon: Icon(Icons.refresh),
            onPressed: () {
              controller.reload();
            },
          ),
        ],
      ),
      body: Stack(
        children: [
          WebViewWidget(controller: controller),
          if (isLoading)
            Center(child: CircularProgressIndicator()),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.arrow_back),
        onPressed: () async {
          if (await controller.canGoBack()) {
            await controller.goBack();
          } else {
            Navigator.of(context).pop();
          }
        },
      ),
    );
  }
}
