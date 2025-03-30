//Sara Daniela Rodriguez Rojas
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Mi Aplicación',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(primarySwatch: Colors.blue),
      initialRoute: '/',
      routes: {
        '/': (context) => AuthScreen(),
        '/register': (context) => RegisterScreen(),
        '/menu': (context) => MenuScreen(),
      },
    );
  }
}

class AuthScreen extends StatefulWidget {
  @override
  _AuthScreenState createState() => _AuthScreenState();
}

class _AuthScreenState extends State<AuthScreen> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  bool isRegistered = false;
  bool isLoggedIn = false;
  String? registeredEmail;
  String? registeredPassword;

  void register() async {
    final result = await Navigator.pushNamed(context, '/register');
    if (result != null && result is Map<String, String>) {
      setState(() {
        isRegistered = true;
        registeredEmail = result['email'];
        registeredPassword = result['password'];
      });
    }
  }

  void login() {
    if (isRegistered) {
      final enteredEmail = emailController.text;
      final enteredPassword = passwordController.text;
      if (enteredEmail == registeredEmail &&
          enteredPassword == registeredPassword) {
        setState(() {
          isLoggedIn = true;
        });
      } else {
        _showErrorDialog('Credenciales incorrectas.');
      }
    } else {
      _showErrorDialog('Debes registrarte primero.');
    }
  }

  void _showErrorDialog(String message) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: Color.fromRGBO(202, 210, 37, 0.2),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          title: Text(
            'Error',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
              color: Color.fromRGBO(129, 131, 132, 1),
            ),
          ),
          content: Text(
            message,
            style: TextStyle(
              fontSize: 16,
              color: Color.fromRGBO(129, 131, 132, 1),
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: Text(
                'Cerrar',
                style: TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                  color: Color.fromRGBO(129, 131, 132, 1),
                ),
              ),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    if (isLoggedIn) {
      //Entra a home
      return HelloWorldScreen();
    }
    //Pagina principal "Ingresar"
    return Scaffold(
      backgroundColor: const Color.fromRGBO(129, 131, 132, 1),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Image.asset('img/LogoUTS.png', height: 150),
            Text(
              'GymUniQR',
              style: TextStyle(
                fontSize: 50,
                fontWeight: FontWeight.bold,
                color: Color.fromRGBO(202, 210, 37, 1),
              ),
            ),
            Text(
              '\n Ingresar \n',
              style: TextStyle(
                fontSize: 38,
                color: Color.fromRGBO(202, 210, 37, 1),
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 35),
              child: Container(
                decoration: BoxDecoration(
                  color: Color.fromRGBO(202, 210, 37, 1),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: TextField(
                  controller: emailController,
                  decoration: InputDecoration(
                    labelText: 'Correo Electrónico',
                    hintText: 'user1@uts.edu.co',
                    border: OutlineInputBorder(),
                  ),
                ),
              ),
            ),
            SizedBox(height: 10),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 35),
              child: Container(
                decoration: BoxDecoration(
                  color: Color.fromRGBO(202, 210, 37, 1),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: TextField(
                  controller: passwordController,
                  decoration: InputDecoration(
                    labelText: 'Contraseña',
                    hintText: '**********',
                    border: OutlineInputBorder(),
                  ),
                  obscureText: true,
                ),
              ),
            ),
            SizedBox(height: 20),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 35),
              child: SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: login,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Color.fromRGBO(129, 131, 132, 1),
                    foregroundColor: Color.fromRGBO(202, 210, 37, 1),
                    padding: EdgeInsets.symmetric(vertical: 15),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                      side: BorderSide(
                        color: Color.fromRGBO(202, 210, 37, 1),
                        width: 2,
                      ),
                    ),
                  ),
                  child: Text('Ingresar', style: TextStyle(fontSize: 18)),
                ),
              ),
            ),

            TextButton(
              onPressed: register,
              style: TextButton.styleFrom(
                foregroundColor: Color.fromRGBO(202, 210, 37, 1),
              ),
              child: Text('Regístrate', style: TextStyle(fontSize: 18)),
            ),
          ],
        ),
      ),
    );
  }
}

//Pantalla de "Registro"
class RegisterScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    TextEditingController emailController = TextEditingController();
    TextEditingController passwordController = TextEditingController();

    return Scaffold(
      appBar: AppBar(title: Text('Registro')),
      backgroundColor: const Color.fromRGBO(129, 131, 132, 1),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            /*Padding(
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: TextField(
                controller: emailController,
                decoration: InputDecoration(
                  labelText: 'Correo Electrónico',
                  border: OutlineInputBorder(),
                ),
              ),
            ),*/
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 35),
              child: Container(
                decoration: BoxDecoration(
                  color: Color.fromRGBO(202, 210, 37, 1),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: TextField(
                  controller: emailController,
                  decoration: InputDecoration(
                    labelText: 'Correo Electrónico',
                    hintText: 'user1@uts.edu.co',
                    border: OutlineInputBorder(),
                  ),
                ),
              ),
            ),
            SizedBox(height: 10),
            /*Padding(
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: TextField(
                controller: passwordController,
                decoration: InputDecoration(
                  labelText: 'Contraseña',
                  border: OutlineInputBorder(),
                ),
                obscureText: true,
              ),
            ),*/
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 35),
              child: Container(
                decoration: BoxDecoration(
                  color: Color.fromRGBO(202, 210, 37, 1),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: TextField(
                  controller: passwordController,
                  decoration: InputDecoration(
                    labelText: 'Contraseña',
                    hintText: '**********',
                    border: OutlineInputBorder(),
                  ),
                  obscureText: true,
                ),
              ),
            ),
            SizedBox(height: 20),
            /*ElevatedButton(
              onPressed: () {
                Navigator.pop(context, {
                  'email': emailController.text,
                  'password': passwordController.text,
                });
              },
              child: Text('Registrarse'),
            ),*/
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 35),
              child: SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  //onPressed: login,
                  onPressed: () {
                    Navigator.pop(context, {
                      'email': emailController.text,
                      'password': passwordController.text,
                    });
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Color.fromRGBO(129, 131, 132, 1),
                    foregroundColor: Color.fromRGBO(202, 210, 37, 1),
                    padding: EdgeInsets.symmetric(vertical: 15),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                      side: BorderSide(
                        color: Color.fromRGBO(202, 210, 37, 1),
                        width: 2,
                      ),
                    ),
                  ),
                  child: Text('Registrarse', style: TextStyle(fontSize: 18)),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class MenuScreen extends StatelessWidget {
  Future<void> _launchURL(String url) async {
    final Uri uri = Uri.parse(url);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri, mode: LaunchMode.externalApplication);
    } else {
      throw 'No se pudo abrir: $url';
    }
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    double iconSize = screenWidth * 0.15;
    double spacing = screenHeight * 0.03;
    double buttonWidth = screenWidth * 0.5;
    double buttonHeight = screenHeight * 0.08;
    double fontSize = screenWidth * 0.04;

    return Scaffold(
      appBar: AppBar(
        title: Text("Menú"),
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: SingleChildScrollView(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(height: spacing),
              GestureDetector(
                onTap: () => _launchURL('https://www.facebook.com'),
                child: Image.asset(
                  'img/facebook.png',
                  width: iconSize,
                  height: iconSize,
                ),
              ),
              SizedBox(height: spacing),
              GestureDetector(
                onTap: () => _launchURL('https://www.instagram.com'),
                child: Image.asset(
                  'img/instagram.png',
                  width: iconSize,
                  height: iconSize,
                ),
              ),
              SizedBox(height: spacing),
              GestureDetector(
                onTap: () => _launchURL('https://www.twitch.tv'),
                child: Image.asset(
                  'img/twitch.png',
                  width: iconSize,
                  height: iconSize,
                ),
              ),
              SizedBox(height: spacing),
              GestureDetector(
                onTap: () => _launchURL('https://www.youtube.com'),
                child: Image.asset(
                  'img/youtube.png',
                  width: iconSize,
                  height: iconSize,
                ),
              ),
              SizedBox(height: spacing),
              SizedBox(
                width: buttonWidth,
                height: buttonHeight,
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  style: ElevatedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                    ),
                    padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                  ),
                  child: FittedBox(
                    child: Text(
                      "Regresar a Inicio",
                      style: TextStyle(fontSize: fontSize),
                    ),
                  ),
                ),
              ),
              SizedBox(height: 50),
            ],
          ),
        ),
      ),
    );
  }
}
class HelloWorldScreen extends StatefulWidget {
  @override
  _HelloWorldScreenState createState() => _HelloWorldScreenState(); // Implementamos createState
}

class _HelloWorldScreenState extends State<HelloWorldScreen> { // Creamos una clase para manejar el estado
  int _selectedIndex = 0;

  final List<Widget> _pages = [
    Center(child: Text('Inicio', style: TextStyle(fontSize: 24))),
    Center(child: Image.asset('img/QR.png', width: 200)),
    Center(child: Text('Perfil', style: TextStyle(fontSize: 24))),
  ];

  void _onItemTapped(int index) {
    setState(() { // Aquí puedes usar setState ya que está en la clase correcta que maneja el estado
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromRGBO(99, 98, 98, 1),
      appBar: AppBar(
        title: Image.asset('img/logoUTS.png', height: 60),
        backgroundColor: const Color.fromRGBO(99, 98, 98, 1),
        elevation: 0,
      ),
      body: _pages[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: _onItemTapped,
        backgroundColor: const Color.fromRGBO(99, 98, 98, 1),
        elevation: 0,
        selectedItemColor: Colors.lightGreen,
        unselectedItemColor: Colors.white,
        items: [
          const BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Home'),
          BottomNavigationBarItem(
            icon: Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.transparent,
              ),
              child: Icon(
                Icons.qr_code_scanner,
                color: Colors.lightGreen,
                size: 90,
              ),
            ),
            label: '',
          ),
          const BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Profile',
          ),
        ],
      ),
    );
  }
}
