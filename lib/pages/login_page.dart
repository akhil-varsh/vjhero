import 'package:flutter/material.dart';

class LoginPage extends StatefulWidget {
  @override
  _LoginPageState createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool _isLoading = false;
  String _errorMessage = '';

  // Static credentials (hardcoded for demonstration)
  final String _validEmail = "user@example.com";
  final String _validPassword = "password123";

  Future<void> _signInWithEmailAndPassword() async {
    setState(() {
      _isLoading = true;
      _errorMessage = '';
    });

    await Future.delayed(Duration(seconds: 1)); // Simulate a delay

    if (_emailController.text.trim() == _validEmail &&
        _passwordController.text.trim() == _validPassword) {
      // Navigate to home page after successful login
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => HomePage()),
      );
    } else {
      setState(() {
        _errorMessage = 'Invalid email or password.';
      });
    }

    setState(() {
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('VJHero Login'),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Card(
            elevation: 4.0,
            child: Padding(
              padding: const EdgeInsets.all(24.0),
              child: SingleChildScrollView(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      'Welcome Back',
                      style: Theme.of(context).textTheme.headlineMedium,
                    ),
                    SizedBox(height: 30),
                    TextField(
                      controller: _emailController,
                      decoration: InputDecoration(
                        labelText: 'Email',
                        border: OutlineInputBorder(),
                        prefixIcon: Icon(Icons.email),
                      ),
                      keyboardType: TextInputType.emailAddress,
                    ),
                    SizedBox(height: 16),
                    TextField(
                      controller: _passwordController,
                      decoration: InputDecoration(
                        labelText: 'Password',
                        border: OutlineInputBorder(),
                        prefixIcon: Icon(Icons.lock),
                      ),
                      obscureText: true,
                    ),
                    if (_errorMessage.isNotEmpty) ...[
                      SizedBox(height: 16),
                      Text(
                        _errorMessage,
                        style: TextStyle(color: Colors.red),
                      ),
                    ],
                    SizedBox(height: 24),
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: _isLoading ? null : _signInWithEmailAndPassword,
                        child: _isLoading
                            ? CircularProgressIndicator()
                            : Text('Login'),
                        style: ElevatedButton.styleFrom(
                          padding: EdgeInsets.symmetric(vertical: 16),
                        ),
                      ),
                    ),
                    SizedBox(height: 16),
                    TextButton(
                      onPressed: () {
                        // Navigate to registration page
                      },
                      child: Text('Don\'t have an account? Sign up'),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

// Placeholder for the home page after login
class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('VJHero Home'),
        actions: [
          IconButton(
            icon: Icon(Icons.logout),
            onPressed: () {
              // Navigate back to login page on logout
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => LoginPage()),
              );
            },
          ),
        ],
      ),
      body: Center(
        child: Text('Welcome to VJHero App!'),
      ),
    );
  }
}
