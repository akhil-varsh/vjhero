import 'package:flutter/material.dart';

class Sidebar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          DrawerHeader(
            decoration: BoxDecoration(
              color: Colors.blue,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CircleAvatar(
                  radius: 30,
                  backgroundColor: Colors.white,
                  child: Icon(Icons.person, size: 40, color: Colors.blue),
                ),
                SizedBox(height: 10),
                Text(
                  'User Name',
                  style: TextStyle(color: Colors.white, fontSize: 18),
                ),
                Text(
                  'user@example.com',
                  style: TextStyle(color: Colors.white70, fontSize: 14),
                ),
              ],
            ),
          ),
          _buildDrawerItem(Icons.home, 'Home', context, '/home'),
          _buildDrawerItem(Icons.folder, 'My Drive', context, '/drive'),
          _buildDrawerItem(Icons.calendar_today, 'Calendar', context, '/calendar'),
          _buildDrawerItem(Icons.chat, 'Chat', context, '/chat'),
          _buildDrawerItem(Icons.description, 'Docs', context, '/docs'),
          _buildDrawerItem(Icons.table_chart, 'Sheets', context, '/sheets'),
          Divider(),
          _buildDrawerItem(Icons.settings, 'Settings', context, '/settings'),
          _buildDrawerItem(Icons.help, 'Help & Feedback', context, '/help'),
        ],
      ),
    );
  }

  Widget _buildDrawerItem(IconData icon, String title, BuildContext context, String route) {
    return ListTile(
      leading: Icon(icon, color: Colors.blue),
      title: Text(title),
      onTap: () {
        Navigator.pop(context); // Close drawer before navigation
        Navigator.pushNamed(context, route);
      },
    );
  }
}
