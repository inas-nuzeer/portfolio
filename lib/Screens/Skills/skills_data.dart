import 'package:flutter/material.dart';

// ── Data models ────────────────────────────────────────────────────────────────

class SkillCard {
  final IconData icon;
  final Color iconColor;
  final String title;
  final List<String> bullets;
  final List<String> tags; // replaces progress

  const SkillCard({
    required this.icon,
    required this.iconColor,
    required this.title,
    required this.bullets,
    required this.tags,
  });
}

class SkillGroup {
  final String groupTitle;
  final List<SkillCard> cards;
  const SkillGroup({required this.groupTitle, required this.cards});
}

class SkillTab {
  final String label;
  final IconData icon;
  final List<SkillGroup> groups;
  const SkillTab({
    required this.label,
    required this.icon,
    required this.groups,
  });
}

// ── Flutter tab ────────────────────────────────────────────────────────────────

const _flutterTab = SkillTab(
  label: 'Flutter',
  icon: Icons.phone_android_rounded,
  groups: [
    SkillGroup(
      groupTitle: 'Architecture',
      cards: [
        SkillCard(
          icon: Icons.account_tree_rounded,
          iconColor: Color(0xFF64B5F6),
          title: 'MVVM & Clean Structure',
          bullets: [
            'MVVM-based architecture & separation of concerns',
            'Modular, scalable project structuring',
            'Reusable component design & clean code practices',
          ],
          tags: ['MVVM', 'Clean Code', 'Modular'],
        ),
      ],
    ),
    SkillGroup(
      groupTitle: 'UI & User Experience',
      cards: [
        SkillCard(
          icon: Icons.palette_rounded,
          iconColor: Color(0xFFBA68C8),
          title: 'Responsive Design',
          bullets: [
            'Adaptive UIs for multiple screen sizes',
            'Advanced layouts with Flex, Expanded & custom widgets',
            'Theming, styling & consistent design systems',
          ],
          tags: ['Responsive', 'Theming', 'Adaptive'],
        ),
        SkillCard(
          icon: Icons.widgets_rounded,
          iconColor: Color(0xFF4DB6AC),
          title: 'Custom Widgets',
          bullets: [
            'Smooth navigation & routing between screens',
            'Custom painters & animations',
            'Glassmorphism & modern UI patterns',
          ],
          tags: ['Custom Painter', 'Animations', 'Navigation'],
        ),
      ],
    ),
    SkillGroup(
      groupTitle: 'State Management',
      cards: [
        SkillCard(
          icon: Icons.sync_alt_rounded,
          iconColor: Color(0xFFFFB74D),
          title: 'Provider',
          bullets: [
            'Provider-based state management',
            'Efficient state updates & UI synchronization',
            'Scalable state handling patterns',
          ],
          tags: ['Provider', 'State', 'ChangeNotifier'],
        ),
      ],
    ),
    SkillGroup(
      groupTitle: 'API & Data',
      cards: [
        SkillCard(
          icon: Icons.cloud_rounded,
          iconColor: Color(0xFF4FC3F7),
          title: 'REST API Integration',
          bullets: [
            'REST API integration using HTTP / Dio',
            'JSON parsing & data modeling',
            'Error handling & API response management',
          ],
          tags: ['REST', 'Dio', 'JSON'],
        ),
        SkillCard(
          icon: Icons.input_rounded,
          iconColor: Color(0xFF81C784),
          title: 'Forms & Validation',
          bullets: [
            'Form validation & user input handling',
            'Dynamic form structures & validations',
          ],
          tags: ['Validation', 'Forms', 'Input'],
        ),
      ],
    ),
    SkillGroup(
      groupTitle: 'Performance',
      cards: [
        SkillCard(
          icon: Icons.speed_rounded,
          iconColor: Color(0xFFE57373),
          title: 'Optimization',
          bullets: [
            'Widget optimization & rebuild minimization',
            'Debugging UI and runtime issues',
            'Efficient asset handling & app performance tuning',
          ],
          tags: ['Optimization', 'Debugging', 'Performance'],
        ),
      ],
    ),
  ],
);

// ── Laravel tab ────────────────────────────────────────────────────────────────

const _laravelTab = SkillTab(
  label: 'Laravel',
  icon: Icons.dns_rounded,
  groups: [
    SkillGroup(
      groupTitle: 'Core Development',
      cards: [
        SkillCard(
          icon: Icons.code_rounded,
          iconColor: Color(0xFFEF5350),
          title: 'MVC & RESTful APIs',
          bullets: [
            'Building RESTful APIs using Laravel',
            'MVC architecture & clean project structuring',
            'Routing, controllers & middleware handling',
          ],
          tags: ['MVC', 'REST API', 'Middleware'],
        ),
      ],
    ),
    SkillGroup(
      groupTitle: 'Database & ORM',
      cards: [
        SkillCard(
          icon: Icons.storage_rounded,
          iconColor: Color(0xFF42A5F5),
          title: 'MySQL & Eloquent',
          bullets: [
            'MySQL database design & normalization',
            'Eloquent ORM relationships (1-1, 1-N, N-N)',
            'Query optimization & efficient data retrieval',
          ],
          tags: ['MySQL', 'Eloquent', 'ORM'],
        ),
      ],
    ),
    SkillGroup(
      groupTitle: 'Auth & Security',
      cards: [
        SkillCard(
          icon: Icons.lock_rounded,
          iconColor: Color(0xFFAB47BC),
          title: 'Authentication',
          bullets: [
            'User authentication using Laravel Breeze',
            'Session management & route protection',
            'Input validation & secure data handling',
          ],
          tags: ['Breeze', 'Sessions', 'Security'],
        ),
      ],
    ),
    SkillGroup(
      groupTitle: 'CRUD & Systems',
      cards: [
        SkillCard(
          icon: Icons.table_chart_rounded,
          iconColor: Color(0xFF26A69A),
          title: 'Admin & CRUD Systems',
          bullets: [
            'Full CRUD operations with validation',
            'Admin panel development & data management',
            'File handling & form submissions',
          ],
          tags: ['CRUD', 'Admin Panel', 'File Upload'],
        ),
      ],
    ),
    SkillGroup(
      groupTitle: 'API Integration',
      cards: [
        SkillCard(
          icon: Icons.api_rounded,
          iconColor: Color(0xFFFFCA28),
          title: 'API Development',
          bullets: [
            'Connecting mobile/frontend apps with Laravel backend',
            'JSON API responses & endpoint structuring',
            'Error handling and validation of API response formatting',
          ],
          tags: ['JSON', 'Endpoints', 'Integration'],
        ),
      ],
    ),
  ],
);

// ── Tools tab ──────────────────────────────────────────────────────────────────

const _toolsTab = SkillTab(
  label: 'Tools',
  icon: Icons.build_rounded,
  groups: [
    SkillGroup(
      groupTitle: 'Cloud & Backend Services',
      cards: [
        SkillCard(
          icon: Icons.local_fire_department_rounded,
          iconColor: Color(0xFFFFCA28),
          title: 'Firebase',
          bullets: [
            'Advanced Firebase integration for scalable mobile applications',
            'Authentication (Email/Password, Google Sign-In) with secure user flows',
            // 'Cloud Firestore data modeling, real-time updates, and query optimization',
            'Cloud Functions integration for backend logic and automation',
            'Push notifications using Firebase Cloud Messaging (FCM)',
          ],
          tags: ['Firebase', 'Firestore', 'Auth'],
        ),
      ],
    ),
    SkillGroup(
      groupTitle: 'Version Control',
      cards: [
        SkillCard(
          icon: Icons.merge_type_rounded,
          iconColor: Color(0xFFF4511E),
          title: 'Git & GitHub',
          bullets: [
            'Version control & collaboration workflows',
            'Branching, merging & pull requests',
            'Resolving merge conflicts and maintaining clean commit history',
            'Git for Flutter & Laravel projects',
          ],
          tags: ['Git', 'GitHub', 'Branching'],
        ),
      ],
    ),
    SkillGroup(
      groupTitle: 'API Testing',
      cards: [
        SkillCard(
          icon: Icons.send_rounded,
          iconColor: Color(0xFFFF7043),
          title: 'Postman',
          bullets: [
            'API endpoint testing & debugging',
            'Collection management & environment variables',
          ],
          tags: ['Postman', 'API Testing', 'Collections'],
        ),
      ],
    ),
    SkillGroup(
      groupTitle: 'IDEs & Workflow',
      cards: [
        SkillCard(
          icon: Icons.developer_mode_rounded,
          iconColor: Color(0xFF29B6F6),
          title: 'Dev Environment',
          bullets: [
            'Android Studio & VS Code',
            'Agile mindset & structured development approach',
            'cPanel hosting & deployment workflows',
          ],
          tags: ['VS Code', 'Android Studio', 'cPanel'],
        ),
      ],
    ),
    SkillGroup(
      groupTitle: 'Frontend',
      cards: [
        SkillCard(
          icon: Icons.design_services_rounded,
          iconColor: Color(0xFF38BDF8),
          title: 'Tailwind CSS',
          bullets: [
            'Utility-first CSS for rapid UI development',
            'Building modern, responsive layouts with custom design control',
            'Efficient styling with reusable classes and minimal CSS overrides',
          ],
          tags: ['Tailwind', 'CSS', 'UI Design'],
        ),
        SkillCard(
          icon: Icons.web_rounded,
          iconColor: Color(0xFF7E57C2),
          title: 'Bootstrap',
          bullets: [
            'Responsive web UI with Bootstrap grid',
            'Component-based frontend layouts',
          ],
          tags: ['Bootstrap', 'Responsive', 'CSS'],
        ),
      ],
    ),
  ],
);

// ── Exported list ──────────────────────────────────────────────────────────────

const List<SkillTab> skillTabs = [_flutterTab, _laravelTab, _toolsTab];
