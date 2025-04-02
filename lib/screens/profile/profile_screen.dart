import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../models/user.dart';
import '../../providers/theme_provider.dart';
import '../../services/auth_service.dart';

class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Profile'),
        actions: [
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: () async {
              try {
                await AuthService.signOut();
                if (context.mounted) {
                  Navigator.of(context).pushReplacementNamed('/login');
                }
              } catch (e) {
                if (context.mounted) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text('Error: ${e.toString()}'),
                      backgroundColor: Colors.red,
                    ),
                  );
                }
              }
            },
          ),
        ],
      ),
      body: FutureBuilder<UserModel?>(
        future: AuthService.getUserData(),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return Center(
              child: Text('Error: ${snapshot.error}'),
            );
          }

          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }

          final user = snapshot.data;
          if (user == null) {
            return const Center(
              child: Text('User not found'),
            );
          }

          return SingleChildScrollView(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildProfileHeader(user),
                const SizedBox(height: 24),
                _buildProfileSection(
                  title: 'Personal Information',
                  children: [
                    _buildProfileItem(
                      icon: Icons.person,
                      title: 'Name',
                      value: user.name,
                    ),
                    _buildProfileItem(
                      icon: Icons.email,
                      title: 'Email',
                      value: user.email,
                    ),
                    _buildProfileItem(
                      icon: Icons.phone,
                      title: 'Phone',
                      value: user.phoneNumber,
                    ),
                  ],
                ),
                const SizedBox(height: 24),
                _buildProfileSection(
                  title: 'Preferences',
                  children: [
                    _buildThemeToggle(context),
                  ],
                ),
                const SizedBox(height: 24),
                _buildProfileSection(
                  title: 'Account',
                  children: [
                    _buildProfileItem(
                      icon: Icons.history,
                      title: 'Order History',
                      onTap: () {
                        Navigator.pushNamed(context, '/orders');
                      },
                    ),
                    _buildProfileItem(
                      icon: Icons.favorite,
                      title: 'Favorite Restaurants',
                      onTap: () {
                        Navigator.pushNamed(context, '/favorites');
                      },
                    ),
                    _buildProfileItem(
                      icon: Icons.location_on,
                      title: 'Delivery Addresses',
                      onTap: () {
                        Navigator.pushNamed(context, '/addresses');
                      },
                    ),
                    _buildProfileItem(
                      icon: Icons.payment,
                      title: 'Payment Methods',
                      onTap: () {
                        Navigator.pushNamed(context, '/payments');
                      },
                    ),
                    _buildProfileItem(
                      icon: Icons.notifications,
                      title: 'Notifications',
                      onTap: () {
                        Navigator.pushNamed(context, '/notifications');
                      },
                    ),
                  ],
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _buildProfileHeader(UserModel user) {
    return Center(
      child: Column(
        children: [
          CircleAvatar(
            radius: 50,
            backgroundImage: user.profileImage != null
                ? NetworkImage(user.profileImage!)
                : null,
            child: user.profileImage == null
                ? const Icon(Icons.person, size: 50)
                : null,
          ),
          const SizedBox(height: 16),
          Text(
            user.name,
            style: const TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),
          Text(
            user.email,
            style: TextStyle(
              fontSize: 16,
              color: Colors.grey[600],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildProfileSection({
    required String title,
    required List<Widget> children,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 8),
        Card(
          child: Column(
            children: children,
          ),
        ),
      ],
    );
  }

  Widget _buildProfileItem({
    required IconData icon,
    required String title,
    String? value,
    VoidCallback? onTap,
  }) {
    return ListTile(
      leading: Icon(icon),
      title: Text(title),
      subtitle: value != null ? Text(value) : null,
      trailing: onTap != null ? const Icon(Icons.chevron_right) : null,
      onTap: onTap,
    );
  }

  Widget _buildThemeToggle(BuildContext context) {
    return Consumer<ThemeProvider>(
      builder: (context, themeProvider, child) {
        return SwitchListTile(
          secondary: const Icon(Icons.dark_mode),
          title: const Text('Dark Mode'),
          value: themeProvider.isDarkMode,
          onChanged: (value) {
            themeProvider.toggleTheme();
          },
        );
      },
    );
  }
} 