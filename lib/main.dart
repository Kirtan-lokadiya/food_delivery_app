import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';
import 'providers/cart_provider.dart';
import 'providers/theme_provider.dart';
import 'screens/home_screen.dart';
import 'screens/cart_screen.dart';
import 'screens/profile_screen.dart';
import 'screens/restaurant_details_screen.dart';
import 'widgets/bottom_nav_bar.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => ThemeProvider()),
        ChangeNotifierProvider(create: (context) => CartProvider()),
      ],
      child: Consumer<ThemeProvider>(
        builder: (context, themeProvider, child) {
          return MaterialApp(
            title: 'Food Delivery App',
            theme: themeProvider.isDarkMode
                ? ThemeData.dark().copyWith(
                    primaryColor: Colors.amber,
                    colorScheme: const ColorScheme.dark().copyWith(
                      primary: Colors.amber,
                      secondary: Colors.orangeAccent,
                    ),
                  )
                : ThemeData.light().copyWith(
                    primaryColor: Colors.amber,
                    colorScheme: const ColorScheme.light().copyWith(
                      primary: Colors.amber,
                      secondary: Colors.orangeAccent,
                    ),
                  ),
            home: const BottomNavBar(),
            routes: {
              '/home': (context) => const HomeScreen(),
              '/cart': (context) => const CartScreen(),
              '/profile': (context) => const ProfileScreen(),
              '/restaurant_details': (context) => const RestaurantDetailsScreen(
                    restaurantId: '',
                  ),
            },
          );
        },
      ),
    );
  }
} 