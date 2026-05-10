// ignore_for_file: deprecated_member_use

import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:inas_portfolio/Screens/Projects/project_detail_page.dart';
import 'package:inas_portfolio/Widgets/project_card.dart';

// ── Category enum ─────────────────────────────────────────────────────────────

enum ProjectCategory { mobile, web }

// ── Project data model ────────────────────────────────────────────────────────

class _ProjectData {
  final String title;
  final String subtitle;
  final String role;
  final String description;
  final List<String> tags;
  final String? liveUrl;
  final String? githubUrl;
  final List<ProjectMediaItem> mediaItems;
  final List<String> myRole;
  final List<String> keyContributions;
  final List<String> skillsDemonstrated;
  final Map<String, List<String>> techStack;
  final List<String> keyFeatures;
  final ProjectCategory category;

  const _ProjectData({
    required this.title,
    required this.subtitle,
    required this.description,
    required this.category,
    this.role = '',
    this.tags = const [],
    this.liveUrl,
    this.githubUrl,
    this.mediaItems = const [],
    this.myRole = const [],
    this.keyContributions = const [],
    this.skillsDemonstrated = const [],
    this.techStack = const {},
    this.keyFeatures = const [],
  });
}

// ── Static project list ───────────────────────────────────────────────────────

const List<_ProjectData> _projects = [
  // ── Mobile ──────────────────────────────────────────────────────────────────
  _ProjectData(
    category: ProjectCategory.mobile,
    title: 'Book Now',
    subtitle: 'Hostel & Activity Booking Platform',
    role: 'Primary Flutter Developer + Backend Contributor',
    description:
        'Book Now is a full-stack travel booking platform designed for the '
        'Sri Lankan and Asia-Pacific market, enabling users to discover, book, '
        'and manage hostels and activities, along with a dedicated '
        'host/owner management system.',
    tags: ['Flutter', 'Dart', 'Node.js', 'REST API', 'Provider', 'Mobile'],
    // githubUrl: 'https://github.com/inas-nuzeer/book-now',
    mediaItems: [
      ProjectMediaItem.video(
        'assets/projects/hostel_flow.mp4',
        caption: 'Hostel Flow',
      ),
      ProjectMediaItem.video(
        'assets/projects/activity_flow.mp4',
        caption: 'Activity Flow',
      ),
    ],
    myRole: [
      'Led the Flutter mobile application development, contributing to the majority of the mobile codebase',
      'Built core features including booking flows, UI systems, state management, and API integrations',
      'Worked closely with backend services, consuming and integrating REST APIs into the mobile app',
      'Contributed to backend development by making changes to controllers and data models when required',
      'Collaborated within a team using Git workflows, including branching, pull requests, and conflict resolution',
    ],
    keyContributions: [
      'Developed scalable Flutter UI architecture with reusable components and responsive design',
      'Implemented complex booking flows (multi-room, activity booking, user interactions)',
      'Integrated APIs for real-time data handling and synchronization',
      'Managed app state using Provider across multiple modules',
      'Optimized performance and improved user experience across different devices',
      'Assisted in backend logic updates, including controller adjustments and model modifications',
    ],
    skillsDemonstrated: [
      'Advanced Flutter development (large-scale app architecture)',
      'API integration & state management',
      'Cross-functional collaboration (frontend ↔ backend)',
      'Backend awareness (Node.js controllers & models)',
      'Real-world product development in a team environment',
    ],
  ),
  _ProjectData(
    category: ProjectCategory.mobile,
    title: 'Xplorit',
    subtitle: 'Vehicle Rental Marketplace Platform',
    role: 'Full-Stack Developer',
    description:
        'Xplorit is a full-stack vehicle rental marketplace that connects '
        'renters with vehicle owners, supporting real-time bookings, '
        'location-based discovery, and direct communication between users. '
        'The platform is designed with a dual-role system, enabling both '
        'renters and lenders to manage their activities seamlessly.',
    tags: ['Flutter', 'Firebase', 'GetX', 'Google Maps', 'Firestore', 'Mobile'],
    mediaItems: [
      ProjectMediaItem.video(
        'assets/projects/xplorit/xplorit.mp4',
        caption: 'App walkthrough',
      ),
    ],
    techStack: {
      'Mobile': [
        'Flutter (Android & iOS)',
        'GetX (state management & navigation)',
        'Firebase (Auth, Firestore, Storage)',
        'Google Maps API, Geolocator, Geocoding',
        'GetStorage (local persistence)',
      ],
      'Backend / Cloud': [
        'Firebase Firestore (real-time NoSQL database)',
        'Firebase Authentication (OTP-based login)',
        'Firebase Storage (media handling)',
        'Firebase App Check (API security)',
      ],
    },
    keyFeatures: [
      'Vehicle discovery with filters and map-based location viewing',
      'Date-range booking system with duration calculation',
      'Real-time chat with vehicle owners',
      'Booking lifecycle tracking (active, completed, cancelled)',
      'Multi-payment method selection UI',
      'Ratings, reviews, and profile management',
      'Full vehicle management system for lenders (add/edit/remove listings)',
      'Flexible pricing configuration (daily, hourly, weekly)',
      'Booking and order management dashboard',
      'Earnings tracking and analytics',
    ],
    myRole: [
      'Developed the application as a full-stack Flutter + Firebase solution, handling both frontend logic and backend architecture',
      'Responsible for all core features, data flow, and system design except UI/visual design implementation',
      'Designed and implemented the app\'s architecture, database structure, and business logic',
      'Integrated multiple third-party services including Google Maps and Firebase ecosystem tools',
    ],
    keyContributions: [
      'Architected and implemented the complete booking system, including CRUD operations and lifecycle tracking',
      'Built dual-role authentication and routing using Firebase OTP-based login',
      'Developed real-time chat system using Firestore with structured message handling',
      'Integrated Google Maps with live geolocation and route visualization (polylines)',
      'Implemented repository pattern with GetX controllers for scalable state management',
      'Built real-time location tracking system storing user coordinates in Firestore',
      'Designed backend data models and structured Firestore collections for scalability',
      'Implemented multi-image upload and media handling using Firebase Storage',
    ],
    skillsDemonstrated: [
      'Full-stack mobile development (Flutter + Firebase)',
      'Scalable real-time system design (Firestore streams)',
      'Clean architecture (Repository → Controller → UI)',
      'OTP authentication and secure session handling',
      'Real-time chat system implementation',
      'Location-based services and map integrations',
      'Complex booking and marketplace logic',
    ],
  ),
  _ProjectData(
    category: ProjectCategory.mobile,
    title: 'Satisfy',
    subtitle: 'Manufacturing & Inventory Management System',
    role: 'Full-Stack Flutter Developer',
    description:
        'Satisfy is a full-stack mobile application built for a furniture '
        'manufacturing business to digitize inventory, production, and sales '
        'workflows. The system connects raw materials, Bill of Materials (BOM), '
        'production costs, and invoicing into a single real-time platform, '
        'replacing manual record-keeping with a data-driven solution.',
    tags: ['Flutter', 'Firebase', 'Firestore', 'fl_chart', 'PDF', 'Mobile'],
    mediaItems: [
      ProjectMediaItem.video(
        'assets/projects/satisfy.mp4',
        caption: 'App Walkthrough',
      ),
    ],
    techStack: {
      'Mobile': [
        'Flutter (Android & iOS)',
        'Firebase (Firestore, Storage)',
        'fl_chart (analytics dashboards)',
      ],
      'Backend / Cloud': [
        'Firebase Firestore (real-time NoSQL database with transactions)',
      ],
      'Utilities': [
        'pdf & printing (report generation)',
        'intl (formatting)',
        'Local storage & file handling',
      ],
    },
    keyFeatures: [
      'Raw material management with stock tracking and low-stock alerts',
      'Bill of Materials (BOM) system linking products to material usage',
      'Automatic cost calculation and real-time price updates',
      'Single and bulk billing system with dynamic cart',
      'Retail and wholesale pricing logic',
      'Atomic transactions for consistent invoice + stock updates',
      'Sales dashboard with revenue, profit, and trends',
      'Top-selling products and performance metrics',
      'Monthly PDF reports with structured summaries',
      'Material usage tracking based on BOM and sales data',
      'Batch-optimized queries for performance',
      'Real-time UI updates with efficient data streaming',
    ],
    myRole: [
      'Designed and developed the application as a complete full-stack Flutter + Firebase solution',
      'Responsible for UI implementation, system architecture, database design, and business logic',
      'Built all core modules including inventory, BOM, sales, analytics, and reporting',
      'Integrated third-party libraries for PDF generation, analytics visualization, and performance optimization',
    ],
    keyContributions: [
      'Architected a transaction-safe sales system using Firestore atomic operations to ensure data consistency',
      'Designed and implemented the BOM-driven inventory system, linking production costs with raw materials',
      'Built cascading price calculation logic, automatically updating product costs when material prices change',
      'Developed a multi-product billing workflow with cart-based invoice generation',
      'Implemented PDF reporting system with branding, structured data tables, and export functionality',
      'Optimized Firestore queries and data flow for performance and scalability',
      'Designed the full database schema and application architecture from scratch',
    ],
    skillsDemonstrated: [
      'Full-stack mobile development (Flutter + Firebase)',
      'Complex business logic implementation (inventory, BOM, cost systems)',
      'Transaction-safe data handling (Firestore atomic operations)',
      'Real-time data streaming and performance optimization',
      'Data visualization and analytics dashboards',
      'Scalable NoSQL data modeling',
      'End-to-end system design and architecture',
    ],
  ),
  // ── Web ──────────────────────────────────────────────────────────────────────
  _ProjectData(
    category: ProjectCategory.web,
    title: 'Portfolio App',
    subtitle: 'Personal Portfolio built with Flutter Web',
    role: 'Flutter Developer',
    description:
        'A fully responsive personal portfolio website built entirely with '
        'Flutter Web, showcasing projects, skills, work experience, and '
        'education. The app features a custom glassmorphism design system, '
        'smooth scroll-driven navigation, a typewriter splash screen, '
        'section-based layout with a floating navbar, and an inline video '
        'player for project demos. Deployed on GitHub Pages with cross-browser '
        'support and optimised for both desktop and mobile.',
    tags: ['Flutter', 'Dart', 'Flutter Web', 'GitHub Pages'],
    liveUrl: 'https://inas-nuzeer.github.io/portfolio/',
    githubUrl: 'https://github.com/inas-nuzeer/portfolio',
    mediaItems: [
      ProjectMediaItem.image(
        'assets/projects/portfolio.png',
        caption: 'Web Preview',
      ),
    ],
    techStack: {
      'Framework': ['Flutter Web (Dart)'],
      'UI & Design': [
        'Glassmorphism design system',
        'BackdropFilter blur effects',
        'Responsive layout (mobile / tablet / desktop)',
        'Custom painters & animated widgets',
      ],
      'Navigation & State': [
        'Scroll-driven section navigation',
        'ScrollController with offset tracking',
        'TabController for Skills & Projects tabs',
        'AnimatedSwitcher & FadeTransition',
        'PageRouteBuilder with custom transitions',
      ],
      // 'Features': [
      //   'Typewriter splash screen with cursor blink',
      //   'Inline HTML5 video player (dart:js_interop)',
      //   'HtmlElementView platform view integration',
      //   'CV download (web file download utility)',
      //   'url_launcher for external links',
      // ],
      'Deployment': [
        'GitHub Pages (flutter build web)',
        'Custom favicon & PWA manifest',
        'Cross-browser support',
      ],
    },
    keyFeatures: [
      'Animated splash screen with typewriter name reveal and loading dots',
      'Scroll-snapping section navigation (Home, About, Skills, Experience, Projects, Education)',
      'Floating glassmorphism navbar on desktop; bottom nav bar on mobile',
      'Skills section with tabbed layout (Flutter, Laravel, Tools) and animated cards',
      'Projects section with Mobile / Web category tabs and detail pages',
      'Project detail pages with media carousel (images + inline video)',
      'Inline HTML5 video player using dart:js_interop and HtmlElementView',
      'Fullscreen video expand mode for better viewing on mobile',
      'CV download button with loading state',
      'Fully responsive — adapts layout for mobile, tablet, and desktop',
      'Glassmorphism containers with BackdropFilter blur throughout',
      'Smooth animated transitions between sections and pages',
    ],
    myRole: [
      'Designed and developed the entire portfolio from scratch as a solo project',
      'Responsible for all UI design decisions, component architecture, and feature implementation',
      'Built the custom design system including the glassmorphism theme, typography, and color palette',
      'Implemented all sections: Home, About, Skills, Experience, Projects, and Education',
      'Integrated native web APIs (HTML5 video) using dart:js_interop for the inline video player',
      'Deployed the app to GitHub Pages using flutter build web',
    ],
    keyContributions: [
      'Built a scroll-driven navigation system that tracks active section via ScrollController offset',
      'Designed and implemented a reusable glassmorphism component system (GlassContainer, glass cards)',
      'Created an animated typewriter splash screen with cursor blink and sequential text reveal',
      'Developed a media carousel with PageView supporting both images and inline HTML5 video',
      'Implemented the HTML5 video player using dart:js_interop and ui_web.platformViewRegistry',
      'Built a tabbed Skills section with animated card layout that adapts between mobile and desktop grids',
      'Structured project data as a typed model (_ProjectData) with rich detail pages and tech stack cards',
      'Implemented CV download functionality with a web-specific utility using dart:html/js interop',
    ],
    skillsDemonstrated: [
      'Flutter Web development & deployment',
      'Custom UI design (glassmorphism, theming, typography)',
      'Responsive layout design (mobile / tablet / desktop)',
      'Scroll-driven navigation & animation',
      'Platform view integration (HtmlElementView, dart:js_interop)',
      'Component-based architecture & reusable widget design',
      'State management with StatefulWidget & controllers',
      'GitHub Pages deployment workflow',
    ],
  ),
  _ProjectData(
    category: ProjectCategory.web,
    title: 'OneAccess Tech',
    subtitle: 'Corporate Website & LMS Platform',
    role: 'Full-Stack Developer',
    liveUrl: 'https://old.oneaccess.lk/',
    mediaItems: [
      ProjectMediaItem.image(
        'assets/projects/oneaccess.png',
        caption: 'Web Preview',
      ),
    ],
    description:
        'OneAccess Technologies is a full-stack web platform developed for an '
        'IT solutions and training company. It combines a corporate website '
        'with a fully functional Learning Management System (LMS), enabling '
        'course management, student enrollment, and content delivery through '
        'a dedicated student portal and admin dashboard.',
    tags: ['PHP', 'MySQL', 'Bootstrap', 'AdminLTE', 'JavaScript', 'LMS', 'Web'],
    techStack: {
      'Frontend': [
        'PHP (server-side rendering)',
        'HTML5, CSS3, JavaScript (jQuery)',
        'Bootstrap / AdminLTE',
        'Swiper.js, AOS, Typed.js, Summernote',
      ],
      'Backend': [
        'PHP 8 (PDO, structured architecture)',
        'MySQL / MariaDB (relational database)',
        'PHPMailer (SMTP email integration)',
        'Apache (.htaccess routing & access control)',
      ],
    },
    keyFeatures: [
      'Dynamic services and blog system with search, filtering, and SEO-friendly URLs',
      'Interactive UI with animations, carousels, and responsive layouts',
      'Contact and demo request forms with email integration',
      'Student authentication with profile setup flow',
      'Course enrollment and progress tracking',
      'Lesson viewer supporting video streaming and file-based learning materials',
      'Organized study materials with topic-based navigation',
      'Full course management system (content, videos, materials)',
      'Blog management with moderation and analytics',
      'Student and enrollment management',
      'Dashboard with real-time statistics and reporting',
    ],
    myRole: [
      'Developed the platform as a complete full-stack solution, implementing both frontend and backend systems',
      'Built the entire application based on predefined UI designs, converting them into fully functional interfaces',
      'Designed system architecture, database structure, and all business logic',
      'Developed the admin panel, LMS student portal, and enrollment pipeline end-to-end',
    ],
    keyContributions: [
      'Architected and implemented the complete LMS system, including courses, enrollments, and student data models',
      'Built the student authentication and session management system with access control',
      'Developed the end-to-end enrollment pipeline, including validation and email notifications',
      'Implemented a dynamic blog system with search, pagination, and SEO-friendly routing',
      'Designed a normalized relational database schema (15+ tables) with proper constraints',
      'Integrated SMTP email workflows using PHPMailer for notifications and confirmations',
      'Built reusable admin panel components using a modular PHP architecture',
      'Implemented AJAX-based dynamic features for forms and real-time interactions',
    ],
    skillsDemonstrated: [
      'Full-stack web development (PHP + MySQL)',
      'LMS architecture and system design',
      'Relational database design and normalization',
      'Authentication, session management, and access control',
      'Email integration and backend workflows',
      'Dynamic UI with AJAX and responsive design',
      'SEO-friendly routing and content management systems',
    ],
  ),
  _ProjectData(
    category: ProjectCategory.web,
    title: 'A&R Baby Collection',
    subtitle: 'Product Showcase & Admin CMS Platform',
    role: 'Full-Stack Developer',
    liveUrl: 'https://anrbaby.lk/',
    mediaItems: [
      ProjectMediaItem.image(
        'assets/projects/anrbaby.png',
        caption: 'Web Preview',
      ),
    ],
    description:
        'A&R Baby Collection is a full-stack web platform designed for a '
        'wholesale and retail baby products business. It serves as a product '
        'showcase website for customers to explore product collections, while '
        'providing a powerful admin CMS to manage products, media, and '
        'website content.',
    tags: [
      'PHP',
      'MySQL',
      'Bootstrap 5',
      'JavaScript',
      'Google Drive API',
      'Web',
    ],
    techStack: {
      'Frontend': [
        'HTML5, CSS3, Bootstrap 5',
        'JavaScript (jQuery)',
        'Swiper.js (carousel interactions)',
        'AOS (scroll animations)',
        'Quill.js (rich text editor)',
      ],
      'Backend': [
        'PHP (controller-based architecture)',
        'MySQL (relational database)',
        'PDO (secure queries with prepared statements)',
      ],
      'Integrations': [
        'Google Drive API (cloud file storage & public media links)',
        'Firebase Admin SDK / Firestore',
      ],
    },
    keyFeatures: [
      'Full product management system (add/edit/delete with media handling)',
      'Multi-image upload with preview and file cleanup',
      'Product variants (size, color) with structured data storage',
      'Homepage carousel management',
      'Editable content sections (About Us, Production)',
      'Admin user management and dashboard analytics',
      'Interactive product showcase with detailed product views',
      'Animated homepage with carousel and scroll effects',
      'Dynamic product grid with responsive layouts',
      'Production showcase with video and image gallery',
      'Fully responsive design across mobile, tablet, and desktop',
    ],
    myRole: [
      'Designed and developed the system as a complete full-stack solution, including UI, frontend, backend, and database',
      'Built both the public-facing product showcase and the admin CMS dashboard from scratch',
      'Implemented application architecture, reusable components, and content management workflows',
      'Integrated third-party services for media storage and dynamic content handling',
    ],
    keyContributions: [
      'Built the complete product showcase and CMS system with full admin control',
      'Developed advanced media upload and management logic',
      'Designed and implemented product variant handling using structured data (JSON)',
      'Integrated Google Drive API for cloud-based media storage',
      'Implemented secure admin authentication and route protection',
      'Created a component-based UI system for consistency and scalability',
      'Designed responsive layouts and interactive animations for improved user engagement',
    ],
    skillsDemonstrated: [
      'Full-stack web development (PHP + MySQL + Bootstrap)',
      'CMS and admin dashboard development',
      'Secure database interaction using PDO',
      'Media management and file handling systems',
      'Third-party API integration (Google Drive, Firebase)',
      'Component-based architecture and reusable UI design',
      'Responsive and animated frontend development',
    ],
  ),
];

// ── Filtered lists ────────────────────────────────────────────────────────────

final List<_ProjectData> _mobileProjects = _projects
    .where((p) => p.category == ProjectCategory.mobile)
    .toList();

final List<_ProjectData> _webProjects = _projects
    .where((p) => p.category == ProjectCategory.web)
    .toList();

// ── Screen ────────────────────────────────────────────────────────────────────

class Project extends StatefulWidget {
  const Project({super.key});

  @override
  State<Project> createState() => _ProjectState();
}

class _ProjectState extends State<Project> with SingleTickerProviderStateMixin {
  late final TabController _tabController;
  int _activeTab = 0;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(length: 2, vsync: this)
      ..addListener(() {
        if (_tabController.indexIsChanging) return;
        setState(() => _activeTab = _tabController.index);
      });
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final double screenWidth = MediaQuery.of(context).size.width;
    final double screenHeight = MediaQuery.of(context).size.height;
    final bool isMobile = screenWidth < 600;

    final List<_ProjectData> current = _activeTab == 0
        ? _mobileProjects
        : _webProjects;

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: screenWidth * .1),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: screenHeight * .04),

          // ── Section title ──────────────────────────────────────────────
          FittedBox(
            fit: BoxFit.scaleDown,
            child: Text(
              'Projects',
              style: Theme.of(context).textTheme.headlineMedium,
              textAlign: TextAlign.start,
            ),
          ),

          SizedBox(height: screenHeight * .01),

          // ── Tab bar ────────────────────────────────────────────────────
          TabBar(
            controller: _tabController,
            isScrollable: isMobile,
            tabAlignment: isMobile ? TabAlignment.start : TabAlignment.fill,
            dividerColor: Colors.white.withOpacity(0.08),
            indicatorColor: const Color(0xFFfeb800),
            indicatorWeight: 2.5,
            indicatorSize: TabBarIndicatorSize.label,
            labelPadding: EdgeInsets.symmetric(
              horizontal: isMobile ? 16 : 8,
              vertical: 0,
            ),
            tabs: [
              _buildTab(
                icon: Icons.phone_android_rounded,
                label: 'Mobile Apps',
                isActive: _activeTab == 0,
              ),
              _buildTab(
                icon: Icons.web_rounded,
                label: 'Web Apps',
                isActive: _activeTab == 1,
              ),
            ],
          ),

          SizedBox(height: screenHeight * .03),

          // ── Animated tab content ───────────────────────────────────────
          AnimatedSwitcher(
            duration: const Duration(milliseconds: 350),
            switchInCurve: Curves.easeOut,
            switchOutCurve: Curves.easeIn,
            transitionBuilder: (child, animation) => FadeTransition(
              opacity: animation,
              child: SlideTransition(
                position: Tween<Offset>(
                  begin: const Offset(0.04, 0),
                  end: Offset.zero,
                ).animate(animation),
                child: child,
              ),
            ),
            child: _ProjectGrid(
              key: ValueKey(_activeTab),
              projects: current,
              isMobile: isMobile,
            ),
          ),

          SizedBox(height: isMobile ? screenHeight * .12 : screenHeight * .04),
        ],
      ),
    );
  }

  Tab _buildTab({
    required IconData icon,
    required String label,
    required bool isActive,
  }) {
    return Tab(
      height: 44,
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(
            icon,
            size: 16,
            color: isActive
                ? const Color(0xFFfeb800)
                : Colors.white.withOpacity(0.45),
          ),
          const SizedBox(width: 7),
          Text(
            label,
            style: GoogleFonts.poppins(
              fontSize: 13,
              fontWeight: isActive ? FontWeight.w600 : FontWeight.w400,
              color: isActive
                  ? const Color(0xFFfeb800)
                  : Colors.white.withOpacity(0.45),
            ),
          ),
        ],
      ),
    );
  }
}

// ── Project grid ──────────────────────────────────────────────────────────────

class _ProjectGrid extends StatelessWidget {
  final List<_ProjectData> projects;
  final bool isMobile;

  const _ProjectGrid({
    super.key,
    required this.projects,
    required this.isMobile,
  });

  @override
  Widget build(BuildContext context) {
    // if (isMobile) {
    //   return Column(
    //     children: projects
    //         .map(
    //           (p) => Padding(
    //             padding: const EdgeInsets.only(bottom: 16),
    //             child: _buildCard(p),
    //           ),
    //         )
    //         .toList(),
    //   );
    // }

    if (isMobile) {
      return CarouselSlider(
        options: CarouselOptions(
          height: 200, // Adjust based on your card height
          viewportFraction: .90, // Shows ~3 items (1/3 of screen width each)
          enableInfiniteScroll: false, // Set to true if you want looping
          enlargeCenterPage: false, // Keep all items same size
          scrollDirection: Axis.horizontal,
          initialPage: 0,
          autoPlay: true, // Set to true if you want auto-scrolling
          padEnds: true, // Adds padding at the ends
        ),
        items: projects.map((p) {
          return Container(
            margin: const EdgeInsets.symmetric(
              horizontal: 4,
            ), // Replaces spacing
            child: _buildCard(p),
          );
        }).toList(),
      );
    } else {
      return GridView.count(
        crossAxisCount: 3,
        childAspectRatio: 1.5,
        crossAxisSpacing: 20,
        mainAxisSpacing: 20,
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        children: projects.map((p) => _buildCard(p)).toList(),
      );
    }
  }

  Widget _buildCard(_ProjectData p) {
    return ProjectCard(
      title: p.title,
      subtitle: p.subtitle,
      role: p.role,
      description: p.description,
      tags: p.tags,
      liveUrl: p.liveUrl,
      githubUrl: p.githubUrl,
      mediaItems: p.mediaItems,
      myRole: p.myRole,
      keyContributions: p.keyContributions,
      skillsDemonstrated: p.skillsDemonstrated,
      techStack: p.techStack,
      keyFeatures: p.keyFeatures,
      openAsPage: true,
    );
  }
}
