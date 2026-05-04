import 'package:flutter/material.dart';

class PrototypeJob {
  const PrototypeJob({
    required this.title,
    required this.company,
    required this.location,
    required this.salary,
    required this.score,
    required this.safeScore,
    required this.ghostRisk,
    required this.summary,
    required this.tags,
    required this.reasons,
    required this.risks,
  });

  final String title;
  final String company;
  final String location;
  final String salary;
  final int score;
  final int safeScore;
  final int ghostRisk;
  final String summary;
  final List<String> tags;
  final List<String> reasons;
  final List<String> risks;
}

class PrototypeSection {
  const PrototypeSection({
    required this.title,
    required this.subtitle,
    required this.icon,
    required this.progress,
  });

  final String title;
  final String subtitle;
  final IconData icon;
  final double progress;
}

class PrototypeMenuItem {
  const PrototypeMenuItem({
    required this.title,
    required this.subtitle,
    required this.icon,
  });

  final String title;
  final String subtitle;
  final IconData icon;
}

class ChatMessage {
  const ChatMessage({
    required this.sender,
    required this.text,
    required this.fromUser,
  });

  final String sender;
  final String text;
  final bool fromUser;
}

const prototypeJobs = [
  PrototypeJob(
    title: 'Product Manager, Amazon Now',
    company: 'Amazon',
    location: 'Bengaluru, Karnataka',
    salary: 'Salary not listed',
    score: 95,
    safeScore: 55,
    ghostRisk: 0,
    summary:
        'Strong fit for your frontend experience, product sense, and fast-moving delivery work.',
    tags: ['Product', 'Marketplace', 'On-site'],
    reasons: [
      'Your profile shows delivery ownership and customer-facing product work.',
      'The role asks for prioritisation, analytics, and technical collaboration.',
      'Bangalore fits your active job search location.',
    ],
    risks: [
      'Salary is not listed, so compensation fit is unknown.',
      'Large-company process may move slower than your preferred startup pace.',
    ],
  ),
  PrototypeJob(
    title: 'Frontend Engineer (India)',
    company: 'Onehouse',
    location: 'Bangalore, India',
    salary: 'Salary not listed',
    score: 95,
    safeScore: 72,
    ghostRisk: 4,
    summary:
        'Very strong match for your Flutter, web UI, and product prototype experience.',
    tags: ['Frontend', 'Remote', 'AI product'],
    reasons: [
      'The role maps to component architecture and high-polish interface work.',
      'Your portfolio shows shipping speed across mobile and web surfaces.',
      'Remote-friendly setup keeps Bangalore as your search base.',
    ],
    risks: [
      'The posting asks for deep React experience. Your profile should show equivalent UI depth.',
      'Company stage and hiring urgency are unclear from the listing.',
    ],
  ),
  PrototypeJob(
    title: 'MOBILE ENGINEER',
    company: 'Wipro',
    location: 'Bangalore, India',
    salary: 'Salary not listed',
    score: 94,
    safeScore: 59,
    ghostRisk: 0,
    summary:
        'A practical fit for mobile delivery, cross-platform UI, and enterprise engineering.',
    tags: ['Mobile', 'Flutter', 'Enterprise'],
    reasons: [
      'Your Flutter background maps cleanly to the mobile engineering scope.',
      'The job location matches your active search radius.',
      'Low ghost score because the company has recent applicant responses.',
    ],
    risks: [
      'Enterprise process may be less product-led than your target role.',
    ],
  ),
];

const profileSections = [
  PrototypeSection(
    title: 'Identity',
    subtitle: 'Personal details, bio, and public profile',
    icon: Icons.badge_outlined,
    progress: 0.86,
  ),
  PrototypeSection(
    title: 'Sources',
    subtitle: 'CV, LinkedIn, portfolio, and work samples',
    icon: Icons.folder_copy_outlined,
    progress: 0.72,
  ),
  PrototypeSection(
    title: 'Career',
    subtitle: 'Goals, preferences, and AI career path',
    icon: Icons.route_outlined,
    progress: 0.68,
  ),
  PrototypeSection(
    title: 'Proof',
    subtitle: 'References, cover letters, and generated CVs',
    icon: Icons.verified_outlined,
    progress: 0.54,
  ),
  PrototypeSection(
    title: 'Activity',
    subtitle: 'Applications, saved roles, and job posts',
    icon: Icons.timeline_outlined,
    progress: 0.41,
  ),
];

const aiModes = [
  PrototypeMenuItem(
    title: 'Career advice',
    subtitle: 'Plan next moves and compare role paths.',
    icon: Icons.explore_outlined,
  ),
  PrototypeMenuItem(
    title: 'Job search',
    subtitle: 'Find roles that fit your profile and filters.',
    icon: Icons.work_outline,
  ),
  PrototypeMenuItem(
    title: 'CV help',
    subtitle: 'Tighten evidence, bullets, and keywords.',
    icon: Icons.description_outlined,
  ),
  PrototypeMenuItem(
    title: 'Interview prep',
    subtitle: 'Practice answers using the job detail.',
    icon: Icons.record_voice_over_outlined,
  ),
  PrototypeMenuItem(
    title: 'Salary',
    subtitle: 'Prepare negotiation ranges and scripts.',
    icon: Icons.payments_outlined,
  ),
];

const moreItems = [
  PrototypeMenuItem(
    title: 'CVs',
    subtitle: 'Uploaded source CV and generated role versions',
    icon: Icons.description_outlined,
  ),
  PrototypeMenuItem(
    title: 'Cover letters',
    subtitle: 'Drafts tied to each job match',
    icon: Icons.mail_outline,
  ),
  PrototypeMenuItem(
    title: 'References',
    subtitle: 'Proof contacts and request status',
    icon: Icons.person_pin_outlined,
  ),
  PrototypeMenuItem(
    title: 'Settings',
    subtitle: 'Account, notifications, privacy, subscription',
    icon: Icons.settings_outlined,
  ),
  PrototypeMenuItem(
    title: 'Support',
    subtitle: 'Search help, contact us, read FAQs',
    icon: Icons.help_outline,
  ),
  PrototypeMenuItem(
    title: 'Applications',
    subtitle: 'Track saved, prepared, and submitted roles',
    icon: Icons.fact_check_outlined,
  ),
  PrototypeMenuItem(
    title: 'Post a job',
    subtitle: 'Share a role for the Matchie community',
    icon: Icons.add_business_outlined,
  ),
  PrototypeMenuItem(
    title: 'My posts',
    subtitle: 'Manage spotted jobs and company posts',
    icon: Icons.inventory_2_outlined,
  ),
  PrototypeMenuItem(
    title: 'Bench',
    subtitle: 'Subscription, trial, and student pricing',
    icon: Icons.workspace_premium_outlined,
  ),
  PrototypeMenuItem(
    title: 'Legal',
    subtitle: 'Terms, privacy, and data controls',
    icon: Icons.gavel_outlined,
  ),
  PrototypeMenuItem(
    title: 'Share Matchie',
    subtitle: 'Invite a friend to try the app',
    icon: Icons.ios_share_outlined,
  ),
  PrototypeMenuItem(
    title: 'Email feedback',
    subtitle: 'Send product notes to the Matchie team',
    icon: Icons.alternate_email_outlined,
  ),
];

const helpCategories = [
  'Getting started',
  'Profile sources',
  'Job matches',
  'Matchie on the Go',
  'Billing',
  'Privacy',
];

const chatMessages = [
  ChatMessage(
    sender: 'You',
    text: 'Which of today\'s matches should I apply for first?',
    fromUser: true,
  ),
  ChatMessage(
    sender: 'MatchieAI',
    text:
        'Start with Northstar Labs. It has the strongest evidence match, low ghost risk, and only one CV gap to fix.',
    fromUser: false,
  ),
  ChatMessage(
    sender: 'You',
    text: 'What should I change before applying?',
    fromUser: true,
  ),
  ChatMessage(
    sender: 'MatchieAI',
    text:
        'Add one bullet about shipped product work and move your research sprint above the education section.',
    fromUser: false,
  ),
];

const activityItems = [
  'Northstar Labs moved to prepared',
  'CV refreshed from portfolio source',
  'Two nearby roles spotted in Shoreditch',
  'Cover letter draft ready for review',
];
