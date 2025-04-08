import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart'; // Import Google Fonts

// Define custom colors
const Color hioBlue = Color(0xFF12156e);
const Color hioGreen = Color(0xFF0d9f4c);
const Color hioOrange = Color(0xFFd4560a);
const Color hioGrey = Color(0xFF999999);
const Color hioWhite = Color(0xFFFFFFFF);
const Color hioBlack = Color(0xFF000000);

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    // Define the base text theme using Google Fonts
    final textTheme = Theme.of(context).textTheme;
    final customTextTheme = GoogleFonts.robotoTextTheme(textTheme).copyWith(
      // Apply Roboto Condensed to specific styles like display/headline if needed
      // Example: Using it for headlines
      displayLarge: GoogleFonts.robotoCondensed(textStyle: textTheme.displayLarge),
      displayMedium: GoogleFonts.robotoCondensed(textStyle: textTheme.displayMedium),
      displaySmall: GoogleFonts.robotoCondensed(textStyle: textTheme.displaySmall),
      headlineLarge: GoogleFonts.robotoCondensed(textStyle: textTheme.headlineLarge),
      headlineMedium: GoogleFonts.robotoCondensed(textStyle: textTheme.headlineMedium),
      headlineSmall: GoogleFonts.robotoCondensed(textStyle: textTheme.headlineSmall),
      // Body fonts will default to Roboto
      bodyLarge: GoogleFonts.roboto(textStyle: textTheme.bodyLarge),
      bodyMedium: GoogleFonts.roboto(textStyle: textTheme.bodyMedium),
    );

    return MaterialApp(
      title: 'Real Estate KB', // Updated title
      theme: ThemeData(
        // This is the theme of your application.
        //
        // TRY THIS: Try running your application with "flutter run". You'll see
        // the application has a purple toolbar. Then, without quitting the app,
        // try changing the seedColor in the colorScheme below to Colors.green
        // and then invoke "hot reload" (save your changes or press the "hot
        // reload" button in a Flutter-supported IDE, or press "r" if you used
        // the command line to start the app).
        //
        // Notice that the counter didn't reset back to zero; the application
        // state is not lost during the reload. To reset the state, use hot
        // restart instead.
        //
        // This works for code too, not just values: Most code changes can be
        // tested with just a hot reload.
        colorScheme: ColorScheme.fromSeed(
          seedColor: hioBlue, // Use primary blue as seed
          primary: hioBlue,
          secondary: hioGreen,
          tertiary: hioOrange,
          // Define other colors if needed, or let fromSeed derive them
          background: hioWhite,
          onBackground: hioBlack,
          surface: hioWhite,
          onSurface: hioBlack,
          error: Colors.red, // Example error color
          onError: hioWhite,
          brightness: Brightness.light, // Explicitly set brightness
        ),
        // Apply the custom text theme
        textTheme: customTextTheme,
        // Ensure components use the color scheme colors
        useMaterial3: true,
        // Example AppBar theme
        appBarTheme: AppBarTheme(
          backgroundColor: hioBlue,
          foregroundColor: hioWhite,
          titleTextStyle: customTextTheme.headlineMedium?.copyWith(color: hioWhite), // Use condensed font for title
        ),
        // Example Button theme
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: hioGreen,
            foregroundColor: hioWhite,
            textStyle: customTextTheme.labelLarge, // Roboto
          ),
        ),
      ),
      home: const MyHomePage(title: 'Real Estate Home'), // Updated home page title
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      // This call to setState tells the Flutter framework that something has
      // changed in this State, which causes it to rerun the build method below
      // so that the display can reflect the updated values. If we changed
      // _counter without calling setState(), then the build method would not be
      // called again, and so nothing would appear to happen.
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return Scaffold(
      appBar: AppBar(
        // TRY THIS: Try changing the color here to a specific color (to
        // Colors.amber, perhaps?) and trigger a hot reload to see the AppBar
        // change color while the other colors stay the same.
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text(widget.title),
      ),
      body: Center(
        // Center is a layout widget. It takes a single child and positions it
        // in the middle of the parent.
        child: Column(
          // Column is also a layout widget. It takes a list of children and
          // arranges them vertically. By default, it sizes itself to fit its
          // children horizontally, and tries to be as tall as its parent.
          //
          // Column has various properties to control how it sizes itself and
          // how it positions its children. Here we use mainAxisAlignment to
          // center the children vertically; the main axis here is the vertical
          // axis because Columns are vertical (the cross axis would be
          // horizontal).
          //
          // TRY THIS: Invoke "debug painting" (choose the "Toggle Debug Paint"
          // action in the IDE, or press "p" in the console), to see the
          // wireframe for each widget.
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            // Use theme text styles
            Text(
              'You have pushed the button this many times:',
              style: Theme.of(context).textTheme.bodyMedium,
            ),
            Text(
              '$_counter',
              // Use condensed for more prominent text if desired
              style: Theme.of(context).textTheme.headlineMedium?.copyWith(fontFamily: GoogleFonts.robotoCondensed().fontFamily),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: const Icon(Icons.add),
        // Consider theming the FAB if needed
        // backgroundColor: hioOrange,
        // foregroundColor: hioWhite,
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
