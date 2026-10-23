import 'package:flutter/material.dart';
import '../theme/app_theme.dart';
import '../widgets/section_header.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Row(
          children: [
            Icon(Icons.eco, color: AppTheme.primaryGreen, size: 30),
            SizedBox(width: 8),
            Text('GreenSpace', style: TextStyle(fontWeight: FontWeight.bold)),
          ],
        ),
        actions: [
          PopupMenuButton<String>(
            tooltip: 'Garden actions',
            onSelected: (route) => Navigator.pushNamed(context, route),
            itemBuilder: (context) => const [
              PopupMenuItem(value: '/plant/add', child: Text('Add a plant')),
              PopupMenuItem(
                value: '/journal/add',
                child: Text('Add journal entry'),
              ),
              PopupMenuItem(value: '/explore', child: Text('Explore plants')),
            ],
          ),
          IconButton(
            onPressed: () {},
            tooltip: 'Notifications',
            icon: const Icon(Icons.notifications_none_rounded),
          ),
          const Padding(
            padding: EdgeInsets.only(right: 16),
            child: CircleAvatar(
              backgroundColor: AppTheme.lightGreen,
              child: Icon(Icons.person, color: AppTheme.primaryGreen),
            ),
          ),
        ],
      ),
      body: LayoutBuilder(
        builder: (context, constraints) {
          final isWide = constraints.maxWidth >= 700;

          return Center(
            child: ConstrainedBox(
              constraints: const BoxConstraints(maxWidth: 1100),
              child: ListView(
                padding: EdgeInsets.symmetric(
                  horizontal: isWide ? 32 : 20,
                  vertical: 16,
                ),
                children: [
                  const Text(
                    'Hello, Gardener! 👋',
                    style: TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                      color: AppTheme.darkGreen,
                    ),
                  ),
                  const SizedBox(height: 8),
                  const Text(
                    'Let’s make your space a little greener.',
                    style: TextStyle(fontSize: 15, color: Colors.black54),
                  ),
                  const SizedBox(height: 24),

                  // Hero banner
                  Container(
                    padding: const EdgeInsets.all(24),
                    decoration: BoxDecoration(
                      gradient: const LinearGradient(
                        colors: [AppTheme.primaryGreen, AppTheme.darkGreen],
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                      ),
                      borderRadius: BorderRadius.circular(24),
                    ),
                    child: isWide
                        ? const Row(
                            children: [
                              Expanded(child: _HeroText()),
                              SizedBox(width: 20),
                              Text('🪴', style: TextStyle(fontSize: 90)),
                            ],
                          )
                        : const Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text('🌿', style: TextStyle(fontSize: 55)),
                              SizedBox(height: 12),
                              _HeroText(),
                            ],
                          ),
                  ),

                  const SizedBox(height: 28),

                  const SectionHeader(title: 'Your Garden'),
                  const SizedBox(height: 12),

                  // Summary cards
                  LayoutBuilder(
                    builder: (context, cardConstraints) {
                      final columns = cardConstraints.maxWidth >= 600 ? 3 : 2;

                      return GridView.count(
                        crossAxisCount: columns,
                        crossAxisSpacing: 12,
                        mainAxisSpacing: 12,
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        childAspectRatio: isWide ? 1.8 : 1.25,
                        children: const [
                          _SummaryCard(
                            icon: Icons.yard_outlined,
                            title: 'My Plants',
                            value: '0 plants',
                          ),
                          _SummaryCard(
                            icon: Icons.water_drop_outlined,
                            title: 'Watering',
                            value: '0 reminders',
                          ),
                          _SummaryCard(
                            icon: Icons.favorite_border,
                            title: 'Plant Care',
                            value: 'Grow daily',
                          ),
                        ],
                      );
                    },
                  ),

                  const SizedBox(height: 28),

                  SectionHeader(
                    title: 'Popular Plants',
                    onActionTap: () => Navigator.pushNamed(context, '/explore'),
                  ),
                  const SizedBox(height: 12),

                  SizedBox(
                    height: 175,
                    child: ListView(
                      scrollDirection: Axis.horizontal,
                      children: const [
                        _PopularPlant(
                          emoji: '🌵',
                          name: 'Aloe Vera',
                          subtitle: 'Easy care',
                        ),
                        _PopularPlant(
                          emoji: '🌻',
                          name: 'Sunflower',
                          subtitle: 'Loves sunlight',
                        ),
                        _PopularPlant(
                          emoji: '🌿',
                          name: 'Tulsi',
                          subtitle: 'Aromatic herb',
                        ),
                        _PopularPlant(
                          emoji: '🌹',
                          name: 'Rose',
                          subtitle: 'Flowering plant',
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 28),

                  const SectionHeader(title: 'Gardening Tip 🌱'),
                  const SizedBox(height: 12),

                  Container(
                    padding: const EdgeInsets.all(18),
                    decoration: BoxDecoration(
                      color: AppTheme.lightGreen,
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: const Row(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Icon(
                          Icons.lightbulb_outline,
                          color: AppTheme.primaryGreen,
                          size: 30,
                        ),
                        SizedBox(width: 14),
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Every plant is different!',
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  color: AppTheme.darkGreen,
                                ),
                              ),
                              SizedBox(height: 6),
                              Text(
                                'Check the soil before watering. Too much '
                                'water can harm some plants.',
                                style: TextStyle(height: 1.5),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 20),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}

class _HeroText extends StatelessWidget {
  const _HeroText();

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'GROW A GREENER LIFE',
          style: TextStyle(
            color: Colors.white70,
            fontSize: 12,
            fontWeight: FontWeight.bold,
            letterSpacing: 1.5,
          ),
        ),
        const SizedBox(height: 10),
        const Text(
          'Your little garden,\nyour happy place.',
          style: TextStyle(
            color: Colors.white,
            fontSize: 25,
            height: 1.2,
            fontWeight: FontWeight.bold,
          ),
        ),
        const SizedBox(height: 10),
        const Text(
          'Discover plants and bring nature into your everyday life.',
          style: TextStyle(color: Colors.white70, height: 1.5),
        ),
        const SizedBox(height: 16),
        FilledButton(
          onPressed: () => Navigator.pushNamed(context, '/explore'),
          style: FilledButton.styleFrom(
            backgroundColor: Colors.white,
            foregroundColor: AppTheme.darkGreen,
          ),
          child: const Text('Explore Plants'),
        ),
      ],
    );
  }
}

class _SummaryCard extends StatelessWidget {
  final IconData icon;
  final String title;
  final String value;

  const _SummaryCard({
    required this.icon,
    required this.title,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: Colors.green.shade50),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(icon, color: AppTheme.primaryGreen, size: 27),
          const SizedBox(height: 10),
          Text(
            title,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(fontWeight: FontWeight.w600),
          ),
          const SizedBox(height: 4),
          Text(
            value,
            style: const TextStyle(color: AppTheme.primaryGreen, fontSize: 13),
          ),
        ],
      ),
    );
  }
}

class _PopularPlant extends StatelessWidget {
  final String emoji;
  final String name;
  final String subtitle;

  const _PopularPlant({
    required this.emoji,
    required this.name,
    required this.subtitle,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 145,
      margin: const EdgeInsets.only(right: 12),
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: Colors.green.shade50),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(emoji, style: const TextStyle(fontSize: 42)),
          const Spacer(),
          Text(
            name,
            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
          ),
          const SizedBox(height: 4),
          Text(
            subtitle,
            style: const TextStyle(color: Colors.black54, fontSize: 12),
          ),
        ],
      ),
    );
  }
}
