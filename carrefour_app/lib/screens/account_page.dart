import 'package:flutter/material.dart';

class AccountPage extends StatelessWidget {
  const AccountPage({super.key});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: SingleChildScrollView(
        padding: const EdgeInsets.fromLTRB(20, 20, 20, 30),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'My Account',
              style: TextStyle(fontSize: 28, fontWeight: FontWeight.bold),
            ),

            const SizedBox(height: 6),

            Text(
              'Manage your Carrefour experience.',
              style: TextStyle(color: Colors.grey.shade600),
            ),

            const SizedBox(height: 22),

            // Profile card
            Container(
              padding: const EdgeInsets.all(18),
              decoration: BoxDecoration(
                color: const Color(0xFFFFF4F4),
                borderRadius: BorderRadius.circular(20),
              ),
              child: Row(
                children: [
                  Container(
                    width: 62,
                    height: 62,
                    decoration: const BoxDecoration(
                      color: Color(0xFFE30613),
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(
                      Icons.person,
                      color: Colors.white,
                      size: 32,
                    ),
                  ),

                  const SizedBox(width: 14),

                  const Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Welcome to Carrefour',
                          style: TextStyle(
                            fontSize: 17,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        SizedBox(height: 5),
                        Text(
                          'Sign in to manage your account',
                          style: TextStyle(color: Colors.grey, fontSize: 12),
                        ),
                      ],
                    ),
                  ),

                  const Icon(Icons.chevron_right, color: Colors.grey),
                ],
              ),
            ),

            const SizedBox(height: 28),

            const Text(
              'Shopping',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),

            const SizedBox(height: 10),

            _AccountOption(
              icon: Icons.receipt_long_outlined,
              title: 'My orders',
              subtitle: 'View your previous orders',
              onTap: () {
                _showComingSoon(context, 'My orders');
              },
            ),

            _AccountOption(
              icon: Icons.location_on_outlined,
              title: 'My addresses',
              subtitle: 'Manage delivery addresses',
              onTap: () {
                _showComingSoon(context, 'My addresses');
              },
            ),

            _AccountOption(
              icon: Icons.store_outlined,
              title: 'My store',
              subtitle: 'Change your preferred Carrefour store',
              onTap: () {
                _showComingSoon(context, 'Store selection');
              },
            ),

            const SizedBox(height: 24),

            const Text(
              'Preferences',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),

            const SizedBox(height: 10),

            _AccountOption(
              icon: Icons.notifications_none,
              title: 'Notifications',
              subtitle: 'Manage promotions and order alerts',
              onTap: () {
                _showComingSoon(context, 'Notifications');
              },
            ),

            _AccountOption(
              icon: Icons.language,
              title: 'Language',
              subtitle: 'English',
              onTap: () {
                _showLanguageDialog(context);
              },
            ),

            _AccountOption(
              icon: Icons.help_outline,
              title: 'Help & support',
              subtitle: 'Get help with your Carrefour experience',
              onTap: () {
                _showComingSoon(context, 'Help & support');
              },
            ),

            const SizedBox(height: 24),

            const Text(
              'About',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),

            const SizedBox(height: 10),

            _AccountOption(
              icon: Icons.info_outline,
              title: 'About the app',
              subtitle: 'Version 1.0.0',
              onTap: () {
                showAboutDialog(
                  context: context,
                  applicationName: 'Carrefour Mauritius',
                  applicationVersion: '1.0.0',
                  applicationIcon: const Icon(
                    Icons.shopping_cart,
                    color: Color(0xFFE30613),
                  ),
                  children: const [
                    Text('A Carrefour Mauritius shopping experience.'),
                  ],
                );
              },
            ),

            _AccountOption(
              icon: Icons.privacy_tip_outlined,
              title: 'Privacy',
              subtitle: 'Privacy and data settings',
              onTap: () {
                _showComingSoon(context, 'Privacy');
              },
            ),
          ],
        ),
      ),
    );
  }

  void _showComingSoon(BuildContext context, String feature) {
    ScaffoldMessenger.of(
      context,
    ).showSnackBar(SnackBar(content: Text('$feature will be available soon.')));
  }

  void _showLanguageDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('Choose language'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              _LanguageOption(
                language: 'English',
                selected: true,
                onTap: () {
                  Navigator.pop(context);
                },
              ),
              _LanguageOption(
                language: 'Français',
                selected: false,
                onTap: () {
                  Navigator.pop(context);
                  _showComingSoon(context, 'French language');
                },
              ),
            ],
          ),
        );
      },
    );
  }
}

class _AccountOption extends StatelessWidget {
  final IconData icon;
  final String title;
  final String subtitle;
  final VoidCallback onTap;

  const _AccountOption({
    required this.icon,
    required this.title,
    required this.subtitle,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      contentPadding: const EdgeInsets.symmetric(vertical: 3),
      leading: Container(
        width: 45,
        height: 45,
        decoration: BoxDecoration(
          color: Colors.grey.shade100,
          borderRadius: BorderRadius.circular(13),
        ),
        child: Icon(icon, color: const Color(0xFFE30613)),
      ),
      title: Text(title, style: const TextStyle(fontWeight: FontWeight.w600)),
      subtitle: Text(subtitle, style: const TextStyle(fontSize: 12)),
      trailing: const Icon(Icons.chevron_right, color: Colors.grey),
      onTap: onTap,
    );
  }
}

class _LanguageOption extends StatelessWidget {
  final String language;
  final bool selected;
  final VoidCallback onTap;

  const _LanguageOption({
    required this.language,
    required this.selected,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(language),
      trailing: Icon(
        selected ? Icons.radio_button_checked : Icons.radio_button_off,
        color: selected ? const Color(0xFFE30613) : Colors.grey,
      ),
      onTap: onTap,
    );
  }
}
