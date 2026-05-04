import 'dart:ui';

import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'prototype_data.dart';
import 'prototype_theme.dart';

typedef TabSelected = void Function(int index);

class MatchieMenuScope extends InheritedWidget {
  const MatchieMenuScope({
    super.key,
    required this.onTabSelected,
    required super.child,
  });

  final TabSelected onTabSelected;

  static MatchieMenuScope? maybeOf(BuildContext context) {
    return context.dependOnInheritedWidgetOfExactType<MatchieMenuScope>();
  }

  @override
  bool updateShouldNotify(MatchieMenuScope oldWidget) {
    return onTabSelected != oldWidget.onTabSelected;
  }
}

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({
    super.key,
    required this.onCreateAccount,
    required this.onSignIn,
  });

  final VoidCallback onCreateAccount;
  final VoidCallback onSignIn;

  @override
  Widget build(BuildContext context) {
    return PrototypePage(
      showHeader: false,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 34),
          const GradientWordmark(fontSize: 46),
          const SizedBox(height: 14),
          const Text(
            'AI career matching that helps you choose the right role, prepare faster, and avoid dead-end applications.',
            style: _PrototypeText.lead,
          ),
          const SizedBox(height: 26),
          const _GlowPanel(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _MetricRow(
                  label: 'Today',
                  value: '18 roles scanned',
                  icon: Icons.radar_outlined,
                ),
                _MetricRow(
                  label: 'Best match',
                  value: '94 percent fit',
                  icon: Icons.auto_graph_outlined,
                ),
                _MetricRow(
                  label: 'Trial',
                  value: '7 days free',
                  icon: Icons.workspace_premium_outlined,
                ),
              ],
            ),
          ),
          const SizedBox(height: 34),
          GradientButton(
            label: 'Create account',
            icon: Icons.arrow_forward,
            onPressed: onCreateAccount,
          ),
          const SizedBox(height: 12),
          OutlineActionButton(
            label: 'Sign in',
            icon: Icons.login,
            onPressed: onSignIn,
          ),
        ],
      ),
    );
  }
}

class OnboardingStartScreen extends StatelessWidget {
  const OnboardingStartScreen({super.key, required this.onFinish});

  final VoidCallback onFinish;

  @override
  Widget build(BuildContext context) {
    return PrototypePage(
      showHeader: false,
      title: 'Start with your story',
      subtitle:
          'Matchie works better when it understands your evidence, goals, and preferences.',
      child: Column(
        children: [
          const _StepCard(
            number: '01',
            title: 'Import your evidence',
            body:
                'Add a CV, LinkedIn, portfolio, or work sample so the matcher has real signal.',
            icon: Icons.folder_copy_outlined,
          ),
          const SizedBox(height: 12),
          const _StepCard(
            number: '02',
            title: 'Choose your role scope',
            body:
                'Tell Matchie the roles, locations, salary bands, and industries you want.',
            icon: Icons.tune_outlined,
          ),
          const SizedBox(height: 12),
          const _StepCard(
            number: '03',
            title: 'Apply with context',
            body:
                'Use match reasons, risk checks, CV edits, and interview prep before you apply.',
            icon: Icons.bolt_outlined,
          ),
          const SizedBox(height: 24),
          GradientButton(
            label: 'Enter prototype',
            icon: Icons.auto_awesome,
            onPressed: onFinish,
          ),
        ],
      ),
    );
  }
}

class HomeDashboardScreen extends StatelessWidget {
  const HomeDashboardScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return PrototypePage(
      bottomPadding: 28,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: const [_AiEngineGraphicCard()],
      ),
    );
  }
}

class ProfileChecklistScreen extends StatelessWidget {
  const ProfileChecklistScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return PrototypePage(
      title: 'Profile checklist',
      subtitle: 'Four focused steps replace the scattered profile tabs.',
      showBack: true,
      child: Column(
        children: [
          const _CompletionPanel(value: 0.72),
          const SizedBox(height: 16),
          _ChecklistItem(
            title: 'Personal details',
            subtitle: 'Name, location, work rights, links',
            complete: true,
            onTap: () => _push(context, const EditPersonalDetailsScreen()),
          ),
          _ChecklistItem(
            title: 'Sources',
            subtitle: 'CV added. Portfolio still needs one project.',
            complete: true,
            onTap: () => _push(context, const SourcesHubScreen()),
          ),
          _ChecklistItem(
            title: 'Career goals',
            subtitle: 'Add salary target and preferred industries.',
            complete: false,
            onTap: () => _push(context, const CareerGoalsScreen()),
          ),
          _ChecklistItem(
            title: 'Proof',
            subtitle: 'References and cover letters are ready to finish.',
            complete: false,
            onTap: () => _push(context, const ReferencesScreen()),
          ),
        ],
      ),
    );
  }
}

class ProfileHubScreen extends StatelessWidget {
  const ProfileHubScreen({super.key, required this.onTabSelected});

  final TabSelected onTabSelected;

  @override
  Widget build(BuildContext context) {
    return PrototypePage(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _ProfileSummaryCard(
            onChecklist: () => _push(context, const ProfileChecklistScreen()),
          ),
          const SizedBox(height: 14),
          _ProfileTabs(onOpen: (title) => _openProfileSection(context, title)),
          const SizedBox(height: 14),
          _ProfileStrengthCard(
            onOpen: (title) => _openProfileSection(context, title),
          ),
          const SizedBox(height: 16),
          _ProfileGridCards(
            onOpen: (title) => _openProfileSection(context, title),
          ),
          const SizedBox(height: 16),
          GradientButton(
            label: 'Open job matches',
            icon: Icons.work_outline,
            onPressed: () => onTabSelected(2),
          ),
        ],
      ),
    );
  }

  void _openProfileSection(BuildContext context, String title) {
    switch (title) {
      case 'Identity':
        _push(context, const EditPersonalDetailsScreen());
      case 'Sources':
        _push(context, const SourcesHubScreen());
      case 'Career':
        _push(context, const CareerGoalsScreen());
      case 'Proof':
        _push(context, const ReferencesScreen());
      case 'Activity':
        _push(context, const CoverLettersScreen());
    }
  }
}

class EditPersonalDetailsScreen extends StatelessWidget {
  const EditPersonalDetailsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return PrototypePage(
      title: 'Personal details',
      subtitle: 'Keep the form short and focused on matching signal.',
      showBack: true,
      child: Column(
        children: [
          const TextField(
            decoration: InputDecoration(
              labelText: 'Name',
              prefixIcon: Icon(Icons.person_outline),
            ),
            controller: null,
          ),
          SizedBox(height: 12),
          _StaticField(label: 'Preferred name', value: 'Chetan'),
          SizedBox(height: 12),
          _StaticField(label: 'Location', value: 'Bangalore, India'),
          SizedBox(height: 12),
          _StaticField(label: 'Work rights', value: 'India'),
          SizedBox(height: 12),
          _StaticField(label: 'LinkedIn', value: 'linkedin.com/in/chetan-jain'),
          SizedBox(height: 18),
          OutlineActionButton(
            label: 'Edit bio',
            icon: Icons.edit_note_outlined,
            onPressed: () => _push(context, const BioEditorScreen()),
          ),
          SizedBox(height: 12),
          _InfoPanel(
            title: 'What Matchie uses here',
            body:
                'Location, work rights, and links help filter roles before the AI explains fit.',
            icon: Icons.lock_outline,
          ),
        ],
      ),
    );
  }
}

class SourcesHubScreen extends StatelessWidget {
  const SourcesHubScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return PrototypePage(
      title: 'Sources',
      subtitle: 'Bring evidence into one place so matches are explainable.',
      showBack: true,
      child: Column(
        children: [
          _SourceTile(
            title: 'CV',
            subtitle: 'Chetan_Frontend_CV.pdf synced 2 hours ago',
            icon: Icons.description_outlined,
            action: 'Replace',
            onTap: () => _push(context, const UploadCvScreen()),
          ),
          _SourceTile(
            title: 'LinkedIn',
            subtitle: 'Connected and used for role history',
            icon: Icons.hub_outlined,
            action: 'View',
            onTap: () => _showPrototypeSheet(
              context,
              title: 'LinkedIn connected',
              body:
                  'Matchie uses role history, skills, education, and public profile text as matching signal.',
            ),
          ),
          _SourceTile(
            title: 'Portfolio',
            subtitle: 'Two projects connected. One needs a result metric.',
            icon: Icons.workspaces_outline,
            action: 'Open',
            onTap: () => _push(context, const PortfolioScreen()),
          ),
          _SourceTile(
            title: 'Generated CVs',
            subtitle: 'Three role-specific versions ready',
            icon: Icons.auto_fix_high_outlined,
            action: 'Open',
            onTap: () => _push(context, const GeneratedCvsScreen()),
          ),
        ],
      ),
    );
  }
}

class UploadCvScreen extends StatelessWidget {
  const UploadCvScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return PrototypePage(
      title: 'Upload CV',
      subtitle:
          'A focused upload screen with clear privacy and parsing status.',
      showBack: true,
      child: Column(
        children: [
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(26),
            decoration: MatchieStyle.panel(active: true),
            child: const Column(
              children: [
                _GradientIcon(icon: Icons.cloud_upload_outlined, size: 56),
                SizedBox(height: 16),
                Text(
                  'Drop a CV or choose a file',
                  style: _PrototypeText.title,
                  textAlign: TextAlign.center,
                ),
                SizedBox(height: 8),
                Text(
                  'PDF, DOCX, or plain text. Your current CV stays active until you confirm the replacement.',
                  style: _PrototypeText.body,
                  textAlign: TextAlign.center,
                ),
              ],
            ),
          ),
          const SizedBox(height: 16),
          const _InfoPanel(
            title: 'Parsed signal',
            body:
                'Experience, tools, outcomes, education, and gaps are extracted for job matching.',
            icon: Icons.schema_outlined,
          ),
          const SizedBox(height: 16),
          GradientButton(
            label: 'Preview parsed CV',
            icon: Icons.visibility_outlined,
            onPressed: () => _push(context, const CvPreviewEditScreen()),
          ),
        ],
      ),
    );
  }
}

class GeneratedCvsScreen extends StatelessWidget {
  const GeneratedCvsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return PrototypePage(
      title: 'Generated CVs',
      subtitle:
          'Role-specific CVs are grouped by outcome rather than scattered across profile tabs.',
      showBack: true,
      child: Column(
        children: [
          _GeneratedCvTile(
            title: 'Product Manager CV',
            subtitle: 'Optimized for Amazon',
            score: '95%',
            onTap: () => _push(context, const CvPreviewEditScreen()),
          ),
          _GeneratedCvTile(
            title: 'Frontend Engineer CV',
            subtitle: 'Optimized for Onehouse',
            score: '95%',
            onTap: () => _push(context, const CvPreviewEditScreen()),
          ),
          _GeneratedCvTile(
            title: 'Mobile Engineer CV',
            subtitle: 'Optimized for Wipro',
            score: '94%',
            onTap: () => _push(context, const CvPreviewEditScreen()),
          ),
          const SizedBox(height: 10),
          OutlineActionButton(
            label: 'Create from a job',
            icon: Icons.add,
            onPressed: () =>
                _push(context, JobDetailScreen(job: prototypeJobs.first)),
          ),
        ],
      ),
    );
  }
}

class CvPreviewEditScreen extends StatelessWidget {
  const CvPreviewEditScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return PrototypePage(
      title: 'CV preview',
      subtitle:
          'Edit the evidence that changes the match, not the whole document chrome.',
      showBack: true,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const _PaperPreview(),
          const SizedBox(height: 16),
          const _SectionHeader(title: 'Suggested edits', action: '3'),
          const SizedBox(height: 10),
          const _SuggestionCard(
            title: 'Move product research higher',
            body:
                'Northstar values discovery work. Put the sprint summary above education.',
          ),
          const _SuggestionCard(
            title: 'Add one shipped outcome',
            body:
                'Use the portfolio project with the 18 percent activation lift.',
          ),
          const _SuggestionCard(
            title: 'Tighten tool list',
            body:
                'Keep Figma, Maze, Notion, and analytics. Remove older class tools.',
          ),
        ],
      ),
    );
  }
}

class BioEditorScreen extends StatelessWidget {
  const BioEditorScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return PrototypePage(
      title: 'Bio editor',
      subtitle:
          'Short, reusable career positioning for jobs, CVs, and MatchieAI.',
      showBack: true,
      child: Column(
        children: const [
          _TextAreaCard(
            title: 'Current bio',
            body:
                'Product-minded graduate with hands-on research, analytics, and service design experience. I like early teams where I can turn customer evidence into clear product decisions.',
          ),
          SizedBox(height: 14),
          _InfoPanel(
            title: 'Tone',
            body:
                'Clear, specific, and early-career confident. No inflated claims.',
            icon: Icons.edit_note_outlined,
          ),
          SizedBox(height: 14),
          _SuggestionCard(
            title: 'AI suggestion',
            body:
                'Mention one measurable result so hiring teams can see proof faster.',
          ),
        ],
      ),
    );
  }
}

class PortfolioScreen extends StatelessWidget {
  const PortfolioScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return PrototypePage(
      title: 'Portfolio',
      subtitle: 'A compact proof surface for project work and outcomes.',
      showBack: true,
      child: Column(
        children: const [
          _ProjectCard(
            title: 'Subscription onboarding redesign',
            subtitle:
                'Reduced setup drop-off by 18 percent in a student SaaS prototype.',
            tags: ['Research', 'Figma', 'Activation'],
          ),
          _ProjectCard(
            title: 'Health app growth sprint',
            subtitle:
                'Built creator research and campaign reporting for a health-tech team.',
            tags: ['Growth', 'Analytics', 'Content'],
          ),
          _ProjectCard(
            title: 'Support workflow audit',
            subtitle:
                'Mapped repeat tickets and wrote onboarding copy for faster first replies.',
            tags: ['Ops', 'Writing', 'B2B'],
          ),
        ],
      ),
    );
  }
}

class CareerGoalsScreen extends StatelessWidget {
  const CareerGoalsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return PrototypePage(
      title: 'Career goals',
      subtitle: 'Preferences are short, scannable, and easy to adjust.',
      showBack: true,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const _PreferenceGroup(
            title: 'Target roles',
            values: ['Frontend Engineer', 'Product Manager', 'Mobile Engineer'],
          ),
          const SizedBox(height: 14),
          const _PreferenceGroup(
            title: 'Work style',
            values: ['Hybrid', 'Remote', 'Bangalore radius'],
          ),
          const SizedBox(height: 14),
          const _PreferenceGroup(
            title: 'Salary',
            values: ['Market salary', 'Student plan active'],
          ),
          const SizedBox(height: 18),
          GradientButton(
            label: 'View AI career path',
            icon: Icons.route_outlined,
            onPressed: () => _push(context, const AiCareerPathScreen()),
          ),
        ],
      ),
    );
  }
}

class AiCareerPathScreen extends StatelessWidget {
  const AiCareerPathScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return PrototypePage(
      title: 'AI career path',
      subtitle: 'A practical route from current evidence to stronger matches.',
      showBack: true,
      child: Column(
        children: const [
          _PathStep(
            period: 'Now',
            title: 'Apply to product-adjacent roles',
            body:
                'Use design, growth, and customer evidence to widen the first search.',
          ),
          _PathStep(
            period: '30 days',
            title: 'Add one shipped product proof point',
            body: 'Turn the strongest project into a measurable case study.',
          ),
          _PathStep(
            period: '90 days',
            title: 'Narrow to product design or growth',
            body:
                'Use interview response and match data to choose the lane with better signal.',
          ),
        ],
      ),
    );
  }
}

class ReferencesScreen extends StatelessWidget {
  const ReferencesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return PrototypePage(
      title: 'References',
      subtitle:
          'Proof contacts stay simple and private until you choose to share them.',
      showBack: true,
      child: Column(
        children: const [
          _ReferenceCard(
            name: 'Anika Shah',
            role: 'Product mentor, Studio North',
            status: 'Ready',
          ),
          _ReferenceCard(
            name: 'Tom Ellis',
            role: 'Campaign lead, Milo Health project',
            status: 'Needs email',
          ),
          _ReferenceCard(
            name: 'Priya Nair',
            role: 'University supervisor',
            status: 'Ready',
          ),
        ],
      ),
    );
  }
}

class CoverLettersScreen extends StatelessWidget {
  const CoverLettersScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return PrototypePage(
      title: 'Cover letters',
      subtitle: 'Drafts are tied to job evidence, not generic templates.',
      showBack: true,
      child: Column(
        children: [
          _CoverLetterTile(
            title: 'Northstar Labs',
            subtitle: 'Focus: discovery, Figma systems, shipped outcome',
            status: 'Ready to polish',
            onTap: () => _push(
              context,
              PrepareApplicationScreen(job: prototypeJobs.first),
            ),
          ),
          _CoverLetterTile(
            title: 'Milo Health',
            subtitle: 'Focus: campaign analytics and creator research',
            status: 'Draft',
            onTap: () =>
                _push(context, PrepareApplicationScreen(job: prototypeJobs[1])),
          ),
          _CoverLetterTile(
            title: 'BrightDesk',
            subtitle: 'Focus: customer onboarding and reporting',
            status: 'Needs review',
            onTap: () =>
                _push(context, PrepareApplicationScreen(job: prototypeJobs[2])),
          ),
        ],
      ),
    );
  }
}

class JobMatchesScreen extends StatelessWidget {
  const JobMatchesScreen({super.key, required this.onTabSelected});

  final TabSelected onTabSelected;

  @override
  Widget build(BuildContext context) {
    return PrototypePage(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _JobsHeaderControls(
            onFilters: () => _push(context, const JobFiltersScreen()),
            onMap: () => _push(context, const JobMapScreen()),
          ),
          const SizedBox(height: 12),
          _JobSummaryBand(
            onRatingKey: () => _showPrototypeSheet(
              context,
              title: 'Rating key',
              body:
                  'Match is fit against your profile. AI Safe estimates automation exposure. Ghost flags roles that may not be actively hiring.',
            ),
          ),
          const SizedBox(height: 12),
          const _JobFilterStrip(),
          const SizedBox(height: 16),
          const _SectionHeader(title: 'Today', action: '20 jobs'),
          const SizedBox(height: 8),
          const Row(
            children: [
              Icon(
                Icons.location_on_outlined,
                color: MatchiePalette.purple,
                size: 16,
              ),
              SizedBox(width: 6),
              Text('Bangalore, India', style: _PrototypeText.body),
            ],
          ),
          const SizedBox(height: 10),
          for (final job in prototypeJobs) ...[
            _JobMatchCard(
              job: job,
              onTap: () => _push(context, JobDetailScreen(job: job)),
            ),
            const SizedBox(height: 10),
          ],
          const SizedBox(height: 8),
          _InfoPanel(
            title: 'Want more context?',
            body:
                'Ask MatchieAI to compare these roles or rewrite your CV for the strongest match.',
            icon: Icons.auto_awesome_outlined,
            onTap: () => onTabSelected(3),
          ),
        ],
      ),
    );
  }
}

class JobFiltersScreen extends StatelessWidget {
  const JobFiltersScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return PrototypePage(
      title: 'Filters',
      subtitle:
          'Preferences are grouped by the decisions candidates make most often.',
      showBack: true,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: const [
          _PreferenceGroup(
            title: 'Role scope',
            values: ['Frontend Engineer', 'Product Manager', 'Mobile Engineer'],
          ),
          SizedBox(height: 14),
          _PreferenceGroup(
            title: 'Location',
            values: ['Bangalore', 'Remote India', 'Hybrid'],
          ),
          SizedBox(height: 14),
          _FilterSlider(label: 'Minimum match score', value: 82),
          SizedBox(height: 14),
          _FilterSlider(label: 'Maximum ghost risk', value: 24),
          SizedBox(height: 14),
          _PreferenceGroup(
            title: 'Company stage',
            values: ['Seed', 'Series A', 'Small team'],
          ),
        ],
      ),
    );
  }
}

class JobDetailScreen extends StatelessWidget {
  const JobDetailScreen({super.key, required this.job});

  final PrototypeJob job;

  @override
  Widget build(BuildContext context) {
    return PrototypePage(
      title: job.title,
      subtitle: '${job.company} · ${job.location}',
      showBack: true,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _JobDetailHero(job: job),
          const SizedBox(height: 18),
          _SectionHeader(title: 'Why this matches', action: '${job.score}%'),
          const SizedBox(height: 10),
          for (final reason in job.reasons) ...[
            _BulletPanel(text: reason, icon: Icons.check_circle_outline),
            const SizedBox(height: 8),
          ],
          const SizedBox(height: 12),
          const _SectionHeader(
            title: 'Risks to check',
            action: 'Before applying',
          ),
          const SizedBox(height: 10),
          for (final risk in job.risks) ...[
            _BulletPanel(
              text: risk,
              icon: Icons.warning_amber_outlined,
              warning: true,
            ),
            const SizedBox(height: 8),
          ],
          const SizedBox(height: 18),
          Row(
            children: [
              Expanded(
                child: GradientButton(
                  label: 'Prepare',
                  icon: Icons.assignment_outlined,
                  onPressed: () =>
                      _push(context, PrepareApplicationScreen(job: job)),
                ),
              ),
              const SizedBox(width: 10),
              _IconActionButton(
                label: 'Deep Dive',
                icon: Icons.travel_explore_outlined,
                onTap: () => _push(context, DeepDiveScreen(job: job)),
              ),
              const SizedBox(width: 10),
              _IconActionButton(
                label: 'Chat',
                icon: Icons.chat_bubble_outline,
                onTap: () => _push(context, const MatchieAiChatScreen()),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class DeepDiveScreen extends StatelessWidget {
  const DeepDiveScreen({super.key, required this.job});

  final PrototypeJob job;

  @override
  Widget build(BuildContext context) {
    return PrototypePage(
      title: 'Deep Dive',
      subtitle:
          '${job.company} signals, role risks, and how to position yourself.',
      showBack: true,
      child: Column(
        children: [
          _DeepDivePanel(
            title: 'Company insight',
            body:
                '${job.company} is hiring for a small team role. Recent hiring language suggests broad ownership and fast handoffs.',
            icon: Icons.business_outlined,
          ),
          _DeepDivePanel(
            title: 'Interview angle',
            body:
                'Lead with a project where you moved from customer evidence to a product decision.',
            icon: Icons.record_voice_over_outlined,
          ),
          _DeepDivePanel(
            title: 'Application risk',
            body:
                'The main gap is shipped product evidence. Fix it in the CV before submitting.',
            icon: Icons.health_and_safety_outlined,
          ),
          const SizedBox(height: 10),
          GradientButton(
            label: 'Prepare application',
            icon: Icons.arrow_forward,
            onPressed: () => _push(context, PrepareApplicationScreen(job: job)),
          ),
        ],
      ),
    );
  }
}

class PrepareApplicationScreen extends StatelessWidget {
  const PrepareApplicationScreen({super.key, required this.job});

  final PrototypeJob job;

  @override
  Widget build(BuildContext context) {
    return PrototypePage(
      title: 'Prepare application',
      subtitle: '${job.company} · make the strongest version before applying.',
      showBack: true,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _PreparationCard(job: job),
          const SizedBox(height: 16),
          const _SectionHeader(title: 'Prep checklist', action: '4 steps'),
          const SizedBox(height: 10),
          const _PrepItem(
            title: 'CV tailored',
            body: 'Move research and shipped outcomes higher.',
            done: true,
          ),
          const _PrepItem(
            title: 'Cover letter draft',
            body: 'Mention one relevant product decision.',
            done: true,
          ),
          const _PrepItem(
            title: 'Interview prompts',
            body: 'Practice discovery, tradeoff, and impact stories.',
            done: false,
          ),
          const _PrepItem(
            title: 'Apply link',
            body: 'Open the company site when ready.',
            done: false,
          ),
        ],
      ),
    );
  }
}

class JobMapScreen extends StatelessWidget {
  const JobMapScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return PrototypePage(
      title: 'Job map',
      subtitle: 'A calmer map view for location-led browsing.',
      showBack: true,
      child: Column(
        children: [
          Container(
            height: 310,
            width: double.infinity,
            decoration: MatchieStyle.panel(active: true),
            child: Stack(
              children: const [
                Positioned.fill(child: _MapGrid()),
                Positioned(left: 64, top: 72, child: _MapPin(score: '94')),
                Positioned(right: 74, top: 122, child: _MapPin(score: '82')),
                Positioned(left: 118, bottom: 70, child: _MapPin(score: '88')),
              ],
            ),
          ),
          const SizedBox(height: 16),
          _ActionTile(
            title: 'Amazon',
            subtitle: 'Bangalore · 95 percent match',
            icon: Icons.location_on_outlined,
            action: 'Open',
            onTap: () =>
                _push(context, JobDetailScreen(job: prototypeJobs.first)),
          ),
        ],
      ),
    );
  }
}

class MatchieAiHomeScreen extends StatelessWidget {
  const MatchieAiHomeScreen({super.key, required this.onTabSelected});

  final TabSelected onTabSelected;

  @override
  Widget build(BuildContext context) {
    return PrototypePage(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Center(
            child: Text(
              'Let\'s talk about your career',
              style: _PrototypeText.title,
              textAlign: TextAlign.center,
            ),
          ),
          const SizedBox(height: 10),
          const Center(
            child: Text(
              'CV tips, interview prep, job searching, or thinking through your next move.',
              style: _PrototypeText.body,
              textAlign: TextAlign.center,
            ),
          ),
          const SizedBox(height: 18),
          _LargePromptCard(
            onSend: () => _push(context, const MatchieAiChatScreen()),
          ),
          const SizedBox(height: 14),
          _UpgradeStrip(
            onTap: () => _showPrototypeSheet(
              context,
              title: 'Upgrade',
              body:
                  'Start with the 7-day trial, then choose the standard or student plan when this becomes a real flow.',
            ),
          ),
          const SizedBox(height: 16),
          _ChatAboutJobCard(onTap: () => onTabSelected(2)),
          const SizedBox(height: 18),
          Center(
            child: Wrap(
              alignment: WrapAlignment.center,
              spacing: 8,
              runSpacing: 8,
              children: [
                for (final mode in aiModes.take(4))
                  _TagChip(
                    label: mode.title,
                    onTap: () => _push(context, const MatchieAiChatScreen()),
                  ),
              ],
            ),
          ),
          const SizedBox(height: 22),
          const Text('Profile', style: _PrototypeText.body),
          const SizedBox(height: 10),
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: [
              _TagChip(
                label: 'Write Bio',
                onTap: () => _push(context, const BioEditorScreen()),
              ),
              _TagChip(
                label: 'Dream Job',
                onTap: () => _push(context, const CareerGoalsScreen()),
              ),
              _TagChip(
                label: 'Target Roles',
                active: true,
                onTap: () => _push(context, const CareerGoalsScreen()),
              ),
              _TagChip(
                label: 'Skills Audit',
                onTap: () => _push(context, const AiCareerPathScreen()),
              ),
            ],
          ),
          const SizedBox(height: 18),
          const Text('Documents', style: _PrototypeText.body),
          const SizedBox(height: 10),
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: [
              _TagChip(
                label: 'CV Help',
                onTap: () => _push(context, const GeneratedCvsScreen()),
              ),
              _TagChip(
                label: 'Cover Letter',
                onTap: () => _push(context, const CoverLettersScreen()),
              ),
              _TagChip(
                label: 'Interview Tips',
                onTap: () => _push(
                  context,
                  PrepareApplicationScreen(job: prototypeJobs.first),
                ),
              ),
            ],
          ),
          const SizedBox(height: 18),
          for (final mode in aiModes) ...[
            _ModeTile(
              mode: mode,
              onTap: () => _push(context, const MatchieAiChatScreen()),
            ),
            const SizedBox(height: 10),
          ],
          const SizedBox(height: 8),
          OutlineActionButton(
            label: 'Compare job matches',
            icon: Icons.compare_arrows,
            onPressed: () => onTabSelected(2),
          ),
        ],
      ),
    );
  }
}

class MatchieAiChatScreen extends StatelessWidget {
  const MatchieAiChatScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return PrototypePage(
      title: 'Career advice chat',
      subtitle: 'Mode: Job search. Context: today\'s matches and current CV.',
      showBack: true,
      bottomPadding: 96,
      child: Column(
        children: [
          for (final message in chatMessages) ...[
            _ChatBubble(message: message),
            const SizedBox(height: 10),
          ],
          const SizedBox(height: 12),
          const _PromptBar(),
        ],
      ),
    );
  }
}

class MatchieOnTheGoOverviewScreen extends StatelessWidget {
  const MatchieOnTheGoOverviewScreen({super.key, this.onTabSelected});

  final TabSelected? onTabSelected;

  @override
  Widget build(BuildContext context) {
    return PrototypePage(
      title: 'Matchie on the Go',
      subtitle:
          'A focused nearby-job flow for alerts, spotted roles, and posts.',
      showBack: onTabSelected == null,
      child: Column(
        children: [
          const _StatusPanel(),
          const SizedBox(height: 16),
          _ActionTile(
            title: 'Location and radius',
            subtitle: 'Bangalore · 8 mile radius · weekdays',
            icon: Icons.my_location_outlined,
            action: 'Edit',
            onTap: () => _push(context, const MatchieOnTheGoSettingsScreen()),
          ),
          const SizedBox(height: 10),
          _ActionTile(
            title: 'Post a spotted job',
            subtitle: 'Share a real-world role with the community.',
            icon: Icons.add_location_alt_outlined,
            action: 'Post',
            onTap: () => _push(context, const PostSpottedJobScreen()),
          ),
          const SizedBox(height: 10),
          _ActionTile(
            title: 'Nearby matches',
            subtitle: '3 roles close to your saved commute pattern.',
            icon: Icons.radar_outlined,
            action: 'View',
            onTap: () => _push(context, const JobMapScreen()),
          ),
          const SizedBox(height: 16),
          const _SectionHeader(title: 'Role scope', action: 'Active'),
          const SizedBox(height: 10),
          const _PreferenceGroup(
            title: 'Looking nearby for',
            values: ['Frontend Engineer', 'Product Manager', 'Mobile roles'],
          ),
        ],
      ),
    );
  }
}

class MatchieOnTheGoSettingsScreen extends StatelessWidget {
  const MatchieOnTheGoSettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return PrototypePage(
      title: 'On the Go settings',
      subtitle: 'Keep the controls practical and close to the live status.',
      showBack: true,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: const [
          _TogglePanel(
            title: 'Nearby alerts',
            body: 'Notify me when a strong match appears nearby.',
            enabled: true,
          ),
          SizedBox(height: 12),
          _TogglePanel(
            title: 'Spotted job reminders',
            body: 'Ask me to post a role after I save a location.',
            enabled: true,
          ),
          SizedBox(height: 12),
          _FilterSlider(label: 'Radius in miles', value: 8),
          SizedBox(height: 14),
          _PreferenceGroup(
            title: 'Active days',
            values: ['Mon', 'Tue', 'Wed', 'Thu', 'Fri'],
          ),
          SizedBox(height: 14),
          _PreferenceGroup(
            title: 'Role scope',
            values: ['Product design', 'Growth', 'Customer success'],
          ),
        ],
      ),
    );
  }
}

class PostSpottedJobScreen extends StatelessWidget {
  const PostSpottedJobScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return PrototypePage(
      title: 'Post spotted job',
      subtitle: 'A short form for sharing a real-world opportunity.',
      showBack: true,
      child: Column(
        children: const [
          _StaticField(label: 'Company', value: 'Northstar Labs'),
          SizedBox(height: 12),
          _StaticField(label: 'Role title', value: 'Frontend Engineer'),
          SizedBox(height: 12),
          _StaticField(label: 'Location', value: 'Bangalore, India'),
          SizedBox(height: 12),
          _StaticField(
            label: 'Link or note',
            value: 'Hiring poster seen near Indiranagar metro',
          ),
          SizedBox(height: 18),
          _InfoPanel(
            title: 'Before it goes live',
            body:
                'Matchie checks duplicates, company signal, and safety before showing this to nearby candidates.',
            icon: Icons.verified_user_outlined,
          ),
        ],
      ),
    );
  }
}

class MoreHubScreen extends StatelessWidget {
  const MoreHubScreen({super.key, required this.onTabSelected});

  final TabSelected onTabSelected;

  @override
  Widget build(BuildContext context) {
    return PrototypePage(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text('Chetan Jain', style: MatchieStyle.screenTitle),
          const SizedBox(height: 22),
          _MorePrimaryRow(
            title: 'You',
            icon: Icons.person_outline,
            onTap: () => onTabSelected(1),
          ),
          _MorePrimaryRow(
            title: 'Jobs',
            icon: Icons.work_outline,
            onTap: () => onTabSelected(2),
          ),
          _MorePrimaryRow(
            title: 'MatchieAI',
            icon: Icons.chat_bubble_outline,
            onTap: () => onTabSelected(3),
          ),
          _MorePrimaryRow(
            title: 'Matchie on the Go',
            icon: Icons.location_on_outlined,
            onTap: () => onTabSelected(4),
          ),
          const Divider(color: MatchiePalette.outline, height: 28),
          for (final item in moreItems) ...[
            _MoreTile(
              item: item,
              onTap: () => _openMoreItem(context, item.title),
            ),
          ],
          const Divider(color: MatchiePalette.outline, height: 28),
          _MorePrimaryRow(
            title: 'Settings',
            icon: Icons.settings_outlined,
            onTap: () => _push(context, const SettingsScreen()),
          ),
          _MorePrimaryRow(
            title: 'FAQs',
            icon: Icons.help_outline,
            onTap: () => _push(context, const SupportScreen()),
          ),
          const SizedBox(height: 18),
          _DangerActionButton(
            label: 'Log Out',
            icon: Icons.logout,
            onTap: () => _showPrototypeSheet(
              context,
              title: 'Log out',
              body:
                  'This prototype keeps the session active, but the button is wired to this confirmation.',
            ),
          ),
        ],
      ),
    );
  }

  void _openMoreItem(BuildContext context, String title) {
    switch (title) {
      case 'Applications':
        _push(context, const CoverLettersScreen());
      case 'CVs':
        _push(context, const GeneratedCvsScreen());
      case 'Cover letters':
        _push(context, const CoverLettersScreen());
      case 'References':
        _push(context, const ReferencesScreen());
      case 'Settings':
        _push(context, const SettingsScreen());
      case 'Support':
        _push(context, const SupportScreen());
      case 'Post a job':
        _push(context, const PostSpottedJobScreen());
      case 'My posts':
        _push(context, const MatchieOnTheGoOverviewScreen());
      case 'Bench':
        _showPrototypeSheet(
          context,
          title: 'Bench',
          body:
              '7-day free trial, then GBP 8.99 per month. Student and recent graduate pricing is GBP 5.99 per month.',
        );
      case 'Legal':
        _showPrototypeSheet(
          context,
          title: 'Legal',
          body:
              'Terms, privacy, data export, and delete account controls sit behind this entry in the full product.',
        );
      case 'Share Matchie':
        _showPrototypeSheet(
          context,
          title: 'Share and feedback',
          body:
              'Share link, email feedback, and invite flows are grouped here for the pitch prototype.',
        );
      case 'Email feedback':
        _showPrototypeSheet(
          context,
          title: 'Email feedback',
          body:
              'The full product opens a prefilled feedback email. This prototype keeps it as a placement preview.',
        );
      default:
        _showPrototypeSheet(
          context,
          title: title,
          body:
              'This pitch prototype keeps the full detail page as a later expansion while showing where the feature lives.',
        );
    }
  }
}

class MatchieMenuScreen extends StatelessWidget {
  const MatchieMenuScreen({super.key, this.onTabSelected});

  final TabSelected? onTabSelected;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: Stack(
        children: [
          Positioned.fill(
            child: GestureDetector(
              onTap: () => Navigator.of(context).pop(),
              child: Container(color: Colors.black.withValues(alpha: 0.24)),
            ),
          ),
          SafeArea(
            child: Align(
              alignment: Alignment.centerLeft,
              child: ClipRRect(
                borderRadius: const BorderRadius.horizontal(
                  right: Radius.circular(28),
                ),
                child: BackdropFilter(
                  filter: MatchieStyle.glassBlur(active: true),
                  child: Container(
                    width: MediaQuery.sizeOf(context).width * 0.84,
                    constraints: const BoxConstraints(maxWidth: 390),
                    height: double.infinity,
                    padding: const EdgeInsets.fromLTRB(24, 18, 22, 18),
                    decoration: BoxDecoration(
                      gradient: MatchieStyle.glassGradient(active: true),
                      border: Border(
                        right: BorderSide(
                          color: MatchieStyle.glassBorder(active: true),
                        ),
                      ),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.black.withValues(alpha: 0.46),
                          blurRadius: 32,
                          offset: const Offset(16, 0),
                        ),
                      ],
                    ),
                    child: SingleChildScrollView(
                      padding: const EdgeInsets.only(bottom: 28),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              const GradientWordmark(fontSize: 26),
                              const Spacer(),
                              _HeaderIconButton(
                                icon: Icons.close,
                                tooltip: 'Close',
                                onPressed: () => Navigator.of(context).pop(),
                              ),
                            ],
                          ),
                          const SizedBox(height: 26),
                          _MenuProfileCard(
                            onTap: () => _replaceFromMenu(
                              context,
                              1,
                              ProfileHubScreen(onTabSelected: (_) {}),
                            ),
                          ),
                          const SizedBox(height: 28),
                          const _MenuSectionLabel('Your shortcuts'),
                          const SizedBox(height: 12),
                          GridView.count(
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            crossAxisCount: 2,
                            mainAxisSpacing: 12,
                            crossAxisSpacing: 12,
                            childAspectRatio: 1.72,
                            children: [
                              _ShortcutTile(
                                title: 'Find jobs',
                                icon: Icons.work_outline,
                                color: MatchiePalette.purple,
                                onTap: () => _replaceFromMenu(
                                  context,
                                  2,
                                  JobMatchesScreen(onTabSelected: (_) {}),
                                ),
                              ),
                              _ShortcutTile(
                                title: 'Update CV',
                                icon: Icons.description_outlined,
                                color: MatchiePalette.blue,
                                onTap: () => _replaceFromMenu(
                                  context,
                                  null,
                                  const UploadCvScreen(),
                                ),
                              ),
                              _ShortcutTile(
                                title: 'Ask MatchieAI',
                                icon: Icons.chat_bubble_outline,
                                color: MatchiePalette.green,
                                onTap: () => _replaceFromMenu(
                                  context,
                                  3,
                                  MatchieAiHomeScreen(onTabSelected: (_) {}),
                                ),
                              ),
                              _ShortcutTile(
                                title: 'On the Go',
                                icon: Icons.location_on_outlined,
                                color: MatchiePalette.cyan,
                                onTap: () => _replaceFromMenu(
                                  context,
                                  4,
                                  const MatchieOnTheGoOverviewScreen(),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 26),
                          const _MenuSectionLabel('Browse'),
                          _MenuRow(
                            title: 'You',
                            icon: Icons.person_outline,
                            onTap: () => _replaceFromMenu(
                              context,
                              1,
                              ProfileHubScreen(onTabSelected: (_) {}),
                            ),
                          ),
                          _MenuRow(
                            title: 'Jobs',
                            icon: Icons.work_outline,
                            onTap: () => _replaceFromMenu(
                              context,
                              2,
                              JobMatchesScreen(onTabSelected: (_) {}),
                            ),
                          ),
                          _MenuRow(
                            title: 'MatchieAI',
                            icon: Icons.chat_bubble_outline,
                            onTap: () => _replaceFromMenu(
                              context,
                              3,
                              MatchieAiHomeScreen(onTabSelected: (_) {}),
                            ),
                          ),
                          _MenuRow(
                            title: 'Matchie on the Go',
                            icon: Icons.location_on_outlined,
                            onTap: () => _replaceFromMenu(
                              context,
                              4,
                              const MatchieOnTheGoOverviewScreen(),
                            ),
                          ),
                          _MenuRow(
                            title: 'Post a job',
                            icon: Icons.campaign_outlined,
                            onTap: () => _replaceFromMenu(
                              context,
                              null,
                              const PostSpottedJobScreen(),
                            ),
                          ),
                          _MenuRow(
                            title: 'My posts',
                            icon: Icons.inventory_2_outlined,
                            onTap: () => _replaceFromMenu(
                              context,
                              4,
                              const MatchieOnTheGoOverviewScreen(),
                            ),
                          ),
                          const SizedBox(height: 18),
                          const _MenuSectionLabel('Library'),
                          _MenuRow(
                            title: 'CVs',
                            icon: Icons.description_outlined,
                            onTap: () => _replaceFromMenu(
                              context,
                              null,
                              const GeneratedCvsScreen(),
                            ),
                          ),
                          _MenuRow(
                            title: 'Cover Letters',
                            icon: Icons.mail_outline,
                            onTap: () => _replaceFromMenu(
                              context,
                              null,
                              const CoverLettersScreen(),
                            ),
                          ),
                          _MenuRow(
                            title: 'Portfolio',
                            icon: Icons.folder_outlined,
                            onTap: () => _replaceFromMenu(
                              context,
                              null,
                              const PortfolioScreen(),
                            ),
                          ),
                          _MenuRow(
                            title: 'References',
                            icon: Icons.group_outlined,
                            onTap: () => _replaceFromMenu(
                              context,
                              null,
                              const ReferencesScreen(),
                            ),
                          ),
                          const SizedBox(height: 18),
                          const _MenuSectionLabel('Activity'),
                          _MenuRow(
                            title: 'Applications',
                            icon: Icons.fact_check_outlined,
                            onTap: () => _replaceFromMenu(
                              context,
                              null,
                              const CoverLettersScreen(),
                            ),
                          ),
                          _MenuRow(
                            title: 'My Matchie Application',
                            icon: Icons.near_me_outlined,
                            active: true,
                            onTap: () => _replaceFromMenu(
                              context,
                              4,
                              const MatchieOnTheGoOverviewScreen(),
                            ),
                          ),
                          _MenuRow(
                            title: 'Email Feedback',
                            icon: Icons.alternate_email_outlined,
                            onTap: () => _showPrototypeSheet(
                              context,
                              title: 'Email feedback',
                              body:
                                  'The full product opens a prefilled feedback email.',
                            ),
                          ),
                          const SizedBox(height: 18),
                          const _MenuSectionLabel('Help & support'),
                          _MenuRow(
                            title: 'Settings',
                            icon: Icons.settings_outlined,
                            highlighted: true,
                            onTap: () => _replaceFromMenu(
                              context,
                              6,
                              const SettingsScreen(),
                            ),
                          ),
                          _MenuRow(
                            title: 'FAQs',
                            icon: Icons.help_outline,
                            onTap: () => _replaceFromMenu(
                              context,
                              5,
                              const SupportScreen(),
                            ),
                          ),
                          _MenuRow(
                            title: 'Terms & Conditions',
                            icon: Icons.article_outlined,
                            onTap: () => _showPrototypeSheet(
                              context,
                              title: 'Legal',
                              body:
                                  'Terms, privacy, cookies, and data controls live here in the full product.',
                            ),
                          ),
                          _MenuRow(
                            title: 'Share Matchie',
                            icon: Icons.ios_share_outlined,
                            onTap: () => _showPrototypeSheet(
                              context,
                              title: 'Share Matchie',
                              body:
                                  'Invite and sharing flows are kept as placement previews in this prototype.',
                            ),
                          ),
                          const SizedBox(height: 22),
                          _DangerActionButton(
                            label: 'Log Out',
                            icon: Icons.logout,
                            compact: true,
                            onTap: () => _showPrototypeSheet(
                              context,
                              title: 'Log out',
                              body:
                                  'This prototype keeps the session active, but the button is wired to this confirmation.',
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key, this.onTabSelected});

  final TabSelected? onTabSelected;

  @override
  Widget build(BuildContext context) {
    return PrototypePage(
      title: 'Settings',
      showBack: onTabSelected == null,
      child: Column(
        children: [
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(18),
            decoration: MatchieStyle.panel(),
            child: Row(
              children: [
                const _GradientIcon(icon: Icons.dark_mode_outlined),
                const SizedBox(width: 14),
                const Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('Appearance', style: _PrototypeText.title),
                      SizedBox(height: 3),
                      Text('Dark mode', style: _PrototypeText.body),
                    ],
                  ),
                ),
                const _PrototypeSwitch(initialValue: true),
              ],
            ),
          ),
          const SizedBox(height: 14),
          _SettingsGroup(
            rows: [
              _SettingsRowData(
                title: 'Account',
                subtitle: 'Email, password, personal details',
                icon: Icons.person_outline,
                onTap: () => _push(context, const EditPersonalDetailsScreen()),
              ),
              _SettingsRowData(
                title: 'Notifications',
                subtitle: 'Push notifications, email alerts',
                icon: Icons.notifications_none_outlined,
                onTap: () => _showPrototypeSheet(
                  context,
                  title: 'Notifications',
                  body:
                      'Push, email, and nearby-job alerts live here in the full app.',
                ),
              ),
              _SettingsRowData(
                title: 'Subscription',
                subtitle: 'Free trial, student plan, billing',
                icon: Icons.workspace_premium_outlined,
                onTap: () => _showPrototypeSheet(
                  context,
                  title: 'Subscription',
                  body:
                      'Trial status, billing, and student pricing are grouped here.',
                ),
              ),
            ],
          ),
          const SizedBox(height: 14),
          _SettingsGroup(
            rows: [
              _SettingsRowData(
                title: 'Terms of Service',
                subtitle: 'Plain-language legal entry',
                icon: Icons.description_outlined,
                onTap: () => _showPrototypeSheet(
                  context,
                  title: 'Terms of Service',
                  body:
                      'This prototype shows the entry point. The full app opens the terms page.',
                ),
              ),
              _SettingsRowData(
                title: 'Privacy Policy',
                subtitle: 'Data use and profile sources',
                icon: Icons.shield_outlined,
                onTap: () => _showPrototypeSheet(
                  context,
                  title: 'Privacy Policy',
                  body:
                      'Profile sources, data export, and delete-account controls are covered here.',
                ),
              ),
              _SettingsRowData(
                title: 'Help & Support',
                subtitle: 'Search help and contact Matchie',
                icon: Icons.help_outline,
                onTap: () => _push(context, const SupportScreen()),
              ),
            ],
          ),
          const SizedBox(height: 14),
          _SettingsGroup(
            rows: [
              _SettingsRowData(
                title: 'Go to the Bench',
                subtitle: 'Pause job delivery but stay visible',
                icon: Icons.event_seat_outlined,
                onTap: () => _showPrototypeSheet(
                  context,
                  title: 'Go to the Bench',
                  body:
                      'Bench mode pauses active delivery while keeping your profile ready.',
                ),
              ),
            ],
          ),
          const SizedBox(height: 14),
          _DangerActionButton(
            label: 'Delete Account',
            icon: Icons.delete_outline,
            alignLeft: true,
            onTap: () => _showPrototypeSheet(
              context,
              title: 'Delete account',
              body:
                  'This prototype does not delete data. The real control would ask you to confirm before deleting the account.',
            ),
          ),
        ],
      ),
    );
  }
}

class SupportScreen extends StatelessWidget {
  const SupportScreen({super.key, this.onTabSelected});

  final TabSelected? onTabSelected;

  @override
  Widget build(BuildContext context) {
    const groups = [
      (
        Icons.auto_awesome_outlined,
        'About Matchie',
        [
          'What is Matchie?',
          'How will it help me?',
          'How much does it cost?',
          'Free trial details',
          'What makes it different?',
        ],
      ),
      (
        Icons.account_circle_outlined,
        'Account & Profile',
        [
          'Create account',
          'Reset password',
          'Change email',
          'Edit profile',
          'Set location',
          'Profile photo',
        ],
      ),
      (
        Icons.work_outline,
        'Job Matching',
        [
          'How matching works',
          'Set preferences',
          'No matches showing',
          'Apply for a job',
          'Save jobs',
          'Match score',
        ],
      ),
      (
        Icons.description_outlined,
        'CV & Resume',
        [
          'Upload CV',
          'File formats',
          'AI CV generation',
          'Edit generated CV',
          'Find my CVs',
        ],
      ),
      (
        Icons.group_outlined,
        'Network & Contacts',
        [
          'Warm introductions',
          'Add contacts',
          'References in apps',
          'Portfolio in apps',
        ],
      ),
    ];

    return PrototypePage(
      title: 'Support',
      showBack: onTabSelected == null,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Material(
            color: Colors.transparent,
            child: InkWell(
              onTap: () => _showPrototypeSheet(
                context,
                title: 'Search help',
                body:
                    'The full app opens search results here. This prototype confirms the search surface is tappable.',
              ),
              borderRadius: BorderRadius.circular(MatchieStyle.compactRadius),
              child: Ink(
                width: double.infinity,
                padding: const EdgeInsets.symmetric(
                  horizontal: 18,
                  vertical: 16,
                ),
                decoration: MatchieStyle.compactPanel(),
                child: const Row(
                  children: [
                    Icon(Icons.search, color: MatchiePalette.muted, size: 30),
                    SizedBox(width: 14),
                    Expanded(
                      child: Text(
                        'Search for help...',
                        style: _PrototypeText.lead,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          const SizedBox(height: 24),
          for (final group in groups) ...[
            _HelpCategorySection(
              icon: group.$1,
              title: group.$2,
              items: group.$3,
            ),
            const SizedBox(height: 26),
          ],
        ],
      ),
    );
  }
}

class PrototypePage extends StatelessWidget {
  const PrototypePage({
    super.key,
    required this.child,
    this.title,
    this.subtitle,
    this.showBack = false,
    this.scrollable = true,
    this.bottomPadding = 24,
    this.showHeader = true,
    this.serifTitle = false,
  });

  final Widget child;
  final String? title;
  final String? subtitle;
  final bool showBack;
  final bool scrollable;
  final double bottomPadding;
  final bool showHeader;
  final bool serifTitle;

  @override
  Widget build(BuildContext context) {
    final topInset = MediaQuery.paddingOf(context).top;
    final content = Center(
      child: ConstrainedBox(
        constraints: const BoxConstraints(
          maxWidth: MatchieStyle.maxContentWidth,
        ),
        child: Padding(
          padding: EdgeInsets.fromLTRB(
            MatchieStyle.pagePadding,
            showHeader ? 4 : 12,
            MatchieStyle.pagePadding,
            bottomPadding + 108,
          ),
          child: _pageColumn(context),
        ),
      ),
    );

    return Material(
      color: MatchiePalette.ink,
      child: Container(
        decoration: const BoxDecoration(gradient: MatchieGradients.warmPage),
        child: Stack(
          children: [
            const Positioned(
              top: -90,
              right: -110,
              child: _GlassBackdropLight(size: 240, color: MatchiePalette.cyan),
            ),
            const Positioned(
              top: 210,
              left: -130,
              child: _GlassBackdropLight(
                size: 280,
                color: MatchiePalette.purple,
              ),
            ),
            const Positioned(
              bottom: -120,
              right: -95,
              child: _GlassBackdropLight(size: 260, color: MatchiePalette.pink),
            ),
            Positioned.fill(
              child: Padding(
                padding: EdgeInsets.only(top: topInset),
                child: scrollable
                    ? SingleChildScrollView(child: content)
                    : content,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _pageColumn(BuildContext context) {
    final hasHeading = title != null || subtitle != null || showBack;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (showHeader) ...[
          MatchieHeader(
            showBack: showBack,
            onBack: () => Navigator.of(context).maybePop(),
          ),
          SizedBox(height: hasHeading ? 14 : 6),
        ] else if (showBack)
          IconButton(
            icon: const Icon(Icons.arrow_back),
            color: MatchiePalette.text,
            tooltip: 'Back',
            onPressed: () => Navigator.of(context).maybePop(),
          ),
        if (title != null) ...[
          Text(
            title!,
            style: serifTitle
                ? MatchieStyle.brandHeading
                : MatchieStyle.screenTitle,
          ),
          const SizedBox(height: 6),
        ],
        if (subtitle != null) ...[
          Text(subtitle!, style: _PrototypeText.body),
          const SizedBox(height: 14),
        ],
        if (!hasHeading && !showHeader) const SizedBox(height: 8),
        child,
      ],
    );
  }
}

class MatchieHeader extends StatelessWidget {
  const MatchieHeader({super.key, this.showBack = false, this.onBack});

  final bool showBack;
  final VoidCallback? onBack;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        if (showBack) ...[
          _HeaderIconButton(
            icon: Icons.arrow_back,
            tooltip: 'Back',
            onPressed: onBack,
          ),
          const SizedBox(width: 6),
        ] else
          _HeaderIconButton(
            icon: Icons.menu_rounded,
            tooltip: 'Menu',
            onPressed: () => _showMatchieMenu(context),
          ),
        const Expanded(child: Center(child: GradientWordmark(fontSize: 25))),
        const SizedBox(width: 38),
      ],
    );
  }
}

class _GlassBackdropLight extends StatelessWidget {
  const _GlassBackdropLight({required this.size, required this.color});

  final double size;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return IgnorePointer(
      child: ImageFiltered(
        imageFilter: ImageFilter.blur(sigmaX: 46, sigmaY: 46),
        child: Container(
          width: size,
          height: size,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            gradient: RadialGradient(
              colors: [
                color.withValues(alpha: 0.10),
                color.withValues(alpha: 0.04),
                Colors.transparent,
              ],
              stops: const [0, 0.52, 1],
            ),
          ),
        ),
      ),
    );
  }
}

class _HeaderIconButton extends StatelessWidget {
  const _HeaderIconButton({
    required this.icon,
    required this.tooltip,
    required this.onPressed,
  });

  final IconData icon;
  final String tooltip;
  final VoidCallback? onPressed;

  @override
  Widget build(BuildContext context) {
    return Tooltip(
      message: tooltip,
      child: InkWell(
        onTap: onPressed,
        borderRadius: BorderRadius.circular(14),
        child: MatchieGlassSurface(
          compact: true,
          radius: 14,
          width: 38,
          height: 38,
          blur: false,
          child: Icon(icon, size: 24, color: MatchiePalette.text),
        ),
      ),
    );
  }
}

class GradientWordmark extends StatelessWidget {
  const GradientWordmark({super.key, this.fontSize = 32});

  final double fontSize;

  @override
  Widget build(BuildContext context) {
    return ShaderMask(
      shaderCallback: (bounds) => MatchieGradients.brand.createShader(bounds),
      child: Text(
        'Matchie',
        style: TextStyle(
          fontFamily: 'Space Grotesk',
          color: Colors.white,
          fontSize: fontSize,
          fontWeight: FontWeight.w700,
          height: 1,
          letterSpacing: 0,
          decoration: TextDecoration.none,
        ),
      ),
    );
  }
}

class GradientButton extends StatelessWidget {
  const GradientButton({
    super.key,
    required this.label,
    required this.icon,
    required this.onPressed,
  });

  final String label;
  final IconData icon;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onPressed,
        borderRadius: BorderRadius.circular(18),
        child: MatchieGlassSurface(
          active: true,
          radius: 18,
          width: double.infinity,
          child: DecoratedBox(
            decoration: BoxDecoration(
              gradient: MatchieGradients.brand,
              borderRadius: BorderRadius.circular(18),
              border: Border.all(color: Colors.white.withValues(alpha: 0.26)),
            ),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 13),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Flexible(
                    child: Text(
                      label,
                      style: _PrototypeText.button,
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  const SizedBox(width: 8),
                  Icon(icon, color: MatchiePalette.text, size: 18),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class OutlineActionButton extends StatelessWidget {
  const OutlineActionButton({
    super.key,
    required this.label,
    required this.icon,
    required this.onPressed,
  });

  final String label;
  final IconData icon;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onPressed,
        borderRadius: BorderRadius.circular(18),
        child: MatchieGlassSurface(
          compact: true,
          radius: 18,
          width: double.infinity,
          padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 13),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(icon, size: 19, color: MatchiePalette.muted),
              const SizedBox(width: 8),
              Flexible(
                child: Text(
                  label,
                  style: _PrototypeText.button.copyWith(
                    color: MatchiePalette.muted,
                  ),
                  overflow: TextOverflow.ellipsis,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _PrototypeText {
  const _PrototypeText._();

  static const TextStyle lead = TextStyle(
    fontFamily: 'Inter',
    color: MatchiePalette.muted,
    fontSize: 14,
    height: 1.34,
    letterSpacing: 0,
    decoration: TextDecoration.none,
  );

  static const TextStyle title = TextStyle(
    fontFamily: 'Space Grotesk',
    color: MatchiePalette.text,
    fontSize: 15,
    fontWeight: FontWeight.w600,
    height: 1.24,
    letterSpacing: 0,
    decoration: TextDecoration.none,
  );

  static const TextStyle body = TextStyle(
    fontFamily: 'Inter',
    color: MatchiePalette.muted,
    fontSize: 12.5,
    height: 1.34,
    letterSpacing: 0,
    decoration: TextDecoration.none,
  );

  static const TextStyle small = TextStyle(
    fontFamily: 'Inter',
    color: MatchiePalette.faint,
    fontSize: 10.5,
    height: 1.28,
    letterSpacing: 0,
    decoration: TextDecoration.none,
  );

  static const TextStyle button = TextStyle(
    fontFamily: 'Space Grotesk',
    color: MatchiePalette.text,
    fontSize: 13.5,
    fontWeight: FontWeight.w600,
    letterSpacing: 0,
    decoration: TextDecoration.none,
  );
}

class _GlowPanel extends StatelessWidget {
  const _GlowPanel({required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return MatchieGlassSurface(
      active: true,
      width: double.infinity,
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 12),
      child: child,
    );
  }
}

class _MetricRow extends StatelessWidget {
  const _MetricRow({
    required this.label,
    required this.value,
    required this.icon,
  });

  final String label;
  final String value;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        children: [
          Icon(icon, color: MatchiePalette.blue),
          const SizedBox(width: 12),
          Expanded(child: Text(label, style: _PrototypeText.body)),
          Flexible(
            child: Text(
              value,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              textAlign: TextAlign.end,
              style: const TextStyle(
                color: MatchiePalette.text,
                fontSize: 15,
                fontWeight: FontWeight.w800,
                letterSpacing: 0,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _StepCard extends StatelessWidget {
  const _StepCard({
    required this.number,
    required this.title,
    required this.body,
    required this.icon,
  });

  final String number;
  final String title;
  final String body;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: MatchieStyle.panel(),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _GradientIcon(icon: icon),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(number, style: _PrototypeText.small),
                const SizedBox(height: 4),
                Text(title, style: _PrototypeText.title),
                const SizedBox(height: 6),
                Text(body, style: _PrototypeText.body),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _AiEngineGraphicCard extends StatelessWidget {
  const _AiEngineGraphicCard();

  @override
  Widget build(BuildContext context) {
    return MatchieGlassSurface(
      active: true,
      width: double.infinity,
      padding: const EdgeInsets.all(6),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(MatchieStyle.radius - 6),
        child: const AspectRatio(
          aspectRatio: 779 / 1292,
          child: Image(
            image: AssetImage('assets/images/matchie_home_art.jpeg'),
            fit: BoxFit.contain,
            alignment: Alignment.center,
          ),
        ),
      ),
    );
  }
}

class _GlassChipBody extends StatelessWidget {
  const _GlassChipBody({required this.label, required this.active});

  final String label;
  final bool active;

  @override
  Widget build(BuildContext context) {
    return Text(
      label,
      maxLines: 1,
      overflow: TextOverflow.ellipsis,
      textAlign: TextAlign.center,
      style: TextStyle(
        color: active ? MatchiePalette.text : MatchiePalette.muted,
        fontSize: 12,
        fontWeight: active ? FontWeight.w700 : FontWeight.w500,
        letterSpacing: 0,
        decoration: TextDecoration.none,
      ),
    );
  }
}

class _GlassChipFrame extends StatelessWidget {
  const _GlassChipFrame({
    required this.label,
    required this.active,
    required this.tappable,
  });

  final String label;
  final bool active;
  final bool tappable;

  @override
  Widget build(BuildContext context) {
    return ConstrainedBox(
      constraints: const BoxConstraints(maxWidth: 170),
      child: IntrinsicWidth(
        child: MatchieGlassSurface(
          compact: true,
          active: active,
          radius: 99,
          height: 34,
          padding: EdgeInsets.symmetric(
            horizontal: tappable ? 13 : 11,
            vertical: 0,
          ),
          child: _GlassChipBody(label: label, active: active),
        ),
      ),
    );
  }
}

class _SectionHeader extends StatelessWidget {
  const _SectionHeader({required this.title, required this.action});

  final String title;
  final String action;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(child: Text(title, style: _PrototypeText.title)),
        Text(action, style: _PrototypeText.small),
      ],
    );
  }
}

class _ActionTile extends StatelessWidget {
  const _ActionTile({
    required this.title,
    required this.subtitle,
    required this.icon,
    required this.action,
    required this.onTap,
  });

  final String title;
  final String subtitle;
  final IconData icon;
  final String action;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(MatchieStyle.compactRadius),
        child: Ink(
          padding: const EdgeInsets.all(14),
          decoration: MatchieStyle.compactPanel(),
          child: Row(
            children: [
              _IconBubble(icon: icon),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(title, style: _PrototypeText.title),
                    const SizedBox(height: 4),
                    Text(subtitle, style: _PrototypeText.body),
                  ],
                ),
              ),
              const SizedBox(width: 8),
              _ActionPill(label: action),
              const SizedBox(width: 8),
              const Icon(Icons.chevron_right, color: MatchiePalette.faint),
            ],
          ),
        ),
      ),
    );
  }
}

class _ActionPill extends StatelessWidget {
  const _ActionPill({required this.label});

  final String label;

  @override
  Widget build(BuildContext context) {
    return MatchieGlassSurface(
      compact: true,
      radius: 99,
      constraints: const BoxConstraints(maxWidth: 92),
      padding: const EdgeInsets.symmetric(horizontal: 9, vertical: 6),
      child: Text(
        label,
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
        textAlign: TextAlign.center,
        style: _PrototypeText.small,
      ),
    );
  }
}

class _CompletionPanel extends StatelessWidget {
  const _CompletionPanel({required this.value});

  final double value;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(18),
      decoration: MatchieStyle.panel(active: true),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const Expanded(
                child: Text('Profile strength', style: _PrototypeText.title),
              ),
              Text('${(value * 100).round()}%', style: _PrototypeText.title),
            ],
          ),
          const SizedBox(height: 12),
          ClipRRect(
            borderRadius: BorderRadius.circular(99),
            child: LinearProgressIndicator(
              value: value,
              minHeight: 10,
              backgroundColor: MatchiePalette.outline,
              valueColor: const AlwaysStoppedAnimation<Color>(
                MatchiePalette.purple,
              ),
            ),
          ),
          const SizedBox(height: 12),
          const Text(
            'Two high-signal tasks remain before Matchie can explain most roles with confidence.',
            style: _PrototypeText.body,
          ),
        ],
      ),
    );
  }
}

class _ChecklistItem extends StatelessWidget {
  const _ChecklistItem({
    required this.title,
    required this.subtitle,
    required this.complete,
    required this.onTap,
  });

  final String title;
  final String subtitle;
  final bool complete;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: _ActionTile(
        title: title,
        subtitle: subtitle,
        icon: complete ? Icons.check_circle : Icons.radio_button_unchecked,
        action: complete ? 'Done' : 'Open',
        onTap: onTap,
      ),
    );
  }
}

class _ProfileSummaryCard extends StatelessWidget {
  const _ProfileSummaryCard({required this.onChecklist});

  final VoidCallback onChecklist;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onChecklist,
        borderRadius: BorderRadius.circular(MatchieStyle.radius),
        child: Ink(
          padding: const EdgeInsets.all(14),
          decoration: MatchieStyle.compactPanel(),
          child: Row(
            children: [
              Container(
                width: 58,
                height: 58,
                decoration: BoxDecoration(
                  color: MatchiePalette.purple.withValues(alpha: 0.20),
                  shape: BoxShape.circle,
                ),
                child: const Center(
                  child: Text(
                    'CJ',
                    style: TextStyle(
                      fontFamily: 'Playfair Display',
                      color: MatchiePalette.purple,
                      fontWeight: FontWeight.w900,
                      fontSize: 22,
                      letterSpacing: 0,
                      decoration: TextDecoration.none,
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 14),
              const Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Chetan Jain', style: _PrototypeText.title),
                    SizedBox(height: 4),
                    Text(
                      'chetanjain2921@gmail.com',
                      style: _PrototypeText.body,
                    ),
                  ],
                ),
              ),
              const Icon(Icons.settings_outlined, color: MatchiePalette.muted),
            ],
          ),
        ),
      ),
    );
  }
}

class _ProfileTabs extends StatelessWidget {
  const _ProfileTabs({required this.onOpen});

  final ValueChanged<String> onOpen;

  @override
  Widget build(BuildContext context) {
    final tabs = [
      ('Overview', Icons.grid_view_rounded, 'Identity'),
      ('Details', Icons.account_circle_outlined, 'Identity'),
      ('Sources', Icons.share_outlined, 'Sources'),
      ('Career', Icons.rocket_launch_outlined, 'Career'),
      ('Activity', Icons.inbox_outlined, 'Activity'),
    ];

    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: [
          for (final tab in tabs) ...[
            _ProfileTabChip(
              label: tab.$1,
              icon: tab.$2,
              active: tab.$1 == 'Overview',
              onTap: () => onOpen(tab.$3),
            ),
            const SizedBox(width: 10),
          ],
        ],
      ),
    );
  }
}

class _ProfileTabChip extends StatelessWidget {
  const _ProfileTabChip({
    required this.label,
    required this.icon,
    required this.active,
    required this.onTap,
  });

  final String label;
  final IconData icon;
  final bool active;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(14),
      child: Container(
        padding: const EdgeInsets.fromLTRB(4, 0, 4, 10),
        decoration: BoxDecoration(
          border: Border(
            bottom: BorderSide(
              color: active ? MatchiePalette.purple : Colors.transparent,
              width: 4,
            ),
          ),
        ),
        child: Row(
          children: [
            Icon(
              icon,
              color: active ? MatchiePalette.purple : MatchiePalette.muted,
              size: 20,
            ),
            const SizedBox(width: 7),
            Text(
              label,
              style: TextStyle(
                color: active ? MatchiePalette.purple : MatchiePalette.muted,
                fontWeight: FontWeight.w700,
                fontSize: 14,
                decoration: TextDecoration.none,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _ProfileStrengthCard extends StatelessWidget {
  const _ProfileStrengthCard({required this.onOpen});

  final ValueChanged<String> onOpen;

  @override
  Widget build(BuildContext context) {
    final rows = [
      ('Upload CV', Icons.upload_file_outlined, 'Sources', false),
      ('Write Bio', Icons.edit_outlined, 'Identity', false),
      ('Set Location', Icons.check_circle_outline, 'Identity', true),
      ('Connect LinkedIn', Icons.check_circle_outline, 'Sources', true),
      ('Set Dream Job', Icons.star_border, 'Career', false),
      ('Add References', Icons.workspace_premium_outlined, 'Proof', false),
      ('Upload Portfolio', Icons.image_outlined, 'Sources', false),
    ];

    return Container(
      padding: const EdgeInsets.all(18),
      decoration: MatchieStyle.panel(),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              const Icon(Icons.track_changes, color: MatchiePalette.purple),
              const SizedBox(width: 10),
              const Expanded(
                child: Text('Profile Strength', style: _PrototypeText.title),
              ),
              _TagChip(
                label: '3/8',
                active: true,
                onTap: () => _showPrototypeSheet(
                  context,
                  title: 'Profile strength',
                  body:
                      'Three profile items are complete. Open the unfinished rows below to improve the score.',
                ),
              ),
            ],
          ),
          const SizedBox(height: 14),
          ClipRRect(
            borderRadius: BorderRadius.circular(99),
            child: const LinearProgressIndicator(
              value: 0.38,
              minHeight: 7,
              backgroundColor: MatchiePalette.outline,
              valueColor: AlwaysStoppedAnimation<Color>(MatchiePalette.purple),
            ),
          ),
          const SizedBox(height: 16),
          for (final row in rows)
            _ProfileChecklistRow(
              title: row.$1,
              icon: row.$2,
              target: row.$3,
              done: row.$4,
              onOpen: onOpen,
            ),
        ],
      ),
    );
  }
}

class _ProfileChecklistRow extends StatelessWidget {
  const _ProfileChecklistRow({
    required this.title,
    required this.icon,
    required this.target,
    required this.done,
    required this.onOpen,
  });

  final String title;
  final IconData icon;
  final String target;
  final bool done;
  final ValueChanged<String> onOpen;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => onOpen(target),
      borderRadius: BorderRadius.circular(14),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8),
        child: Row(
          children: [
            Icon(
              icon,
              color: done ? MatchiePalette.green : MatchiePalette.muted,
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Text(
                title,
                style: TextStyle(
                  color: done ? MatchiePalette.green : MatchiePalette.text,
                  fontSize: 15,
                  fontWeight: FontWeight.w600,
                  decoration: TextDecoration.none,
                ),
              ),
            ),
            if (!done)
              const Icon(Icons.chevron_right, color: MatchiePalette.faint),
          ],
        ),
      ),
    );
  }
}

class _ProfileGridCards extends StatelessWidget {
  const _ProfileGridCards({required this.onOpen});

  final ValueChanged<String> onOpen;

  @override
  Widget build(BuildContext context) {
    final cards = [
      (
        'Bio',
        'Missing',
        Icons.error_outline,
        'Identity',
        MatchiePalette.yellow,
      ),
      (
        'Socials',
        '1 connected',
        Icons.check_circle_outline,
        'Sources',
        MatchiePalette.green,
      ),
      (
        'CVs',
        '3 generated',
        Icons.description_outlined,
        'Sources',
        MatchiePalette.purple,
      ),
      (
        'Career Path',
        'Draft ready',
        Icons.route_outlined,
        'Career',
        MatchiePalette.purple,
      ),
      (
        'References',
        '0 submitted',
        Icons.radio_button_unchecked,
        'Proof',
        MatchiePalette.muted,
      ),
      (
        'Portfolio',
        '2 files',
        Icons.image_outlined,
        'Sources',
        MatchiePalette.cyan,
      ),
    ];

    return GridView.count(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      crossAxisCount: 2,
      mainAxisSpacing: 12,
      crossAxisSpacing: 12,
      childAspectRatio: 1.38,
      children: [
        for (final card in cards)
          _ProfileMiniCard(
            title: card.$1,
            subtitle: card.$2,
            icon: card.$3,
            target: card.$4,
            color: card.$5,
            onOpen: onOpen,
          ),
      ],
    );
  }
}

class _ProfileMiniCard extends StatelessWidget {
  const _ProfileMiniCard({
    required this.title,
    required this.subtitle,
    required this.icon,
    required this.target,
    required this.color,
    required this.onOpen,
  });

  final String title;
  final String subtitle;
  final IconData icon;
  final String target;
  final Color color;
  final ValueChanged<String> onOpen;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => onOpen(target),
      borderRadius: BorderRadius.circular(MatchieStyle.compactRadius),
      child: Container(
        padding: const EdgeInsets.all(11),
        decoration: MatchieStyle.compactPanel(),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                Icon(icon, color: color, size: 22),
                const Spacer(),
                const Icon(
                  Icons.chevron_right,
                  color: MatchiePalette.faint,
                  size: 20,
                ),
              ],
            ),
            const SizedBox(height: 10),
            Text(title, maxLines: 1, style: _PrototypeText.title),
            const SizedBox(height: 3),
            Text(
              subtitle,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
              style: _PrototypeText.body,
            ),
          ],
        ),
      ),
    );
  }
}

class _StaticField extends StatelessWidget {
  const _StaticField({required this.label, required this.value});

  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      initialValue: value,
      style: const TextStyle(color: MatchiePalette.text),
      decoration: InputDecoration(labelText: label),
    );
  }
}

class _InfoPanel extends StatelessWidget {
  const _InfoPanel({
    required this.title,
    required this.body,
    required this.icon,
    this.onTap,
  });

  final String title;
  final String body;
  final IconData icon;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(MatchieStyle.compactRadius),
        child: Ink(
          width: double.infinity,
          padding: const EdgeInsets.all(14),
          decoration: MatchieStyle.compactPanel(active: onTap != null),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _IconBubble(icon: icon),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(title, style: _PrototypeText.title),
                    const SizedBox(height: 4),
                    Text(body, style: _PrototypeText.body),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _SourceTile extends StatelessWidget {
  const _SourceTile({
    required this.title,
    required this.subtitle,
    required this.icon,
    required this.action,
    required this.onTap,
  });

  final String title;
  final String subtitle;
  final IconData icon;
  final String action;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: _ActionTile(
        title: title,
        subtitle: subtitle,
        icon: icon,
        action: action,
        onTap: onTap,
      ),
    );
  }
}

class _GeneratedCvTile extends StatelessWidget {
  const _GeneratedCvTile({
    required this.title,
    required this.subtitle,
    required this.score,
    required this.onTap,
  });

  final String title;
  final String subtitle;
  final String score;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          onTap: onTap,
          borderRadius: BorderRadius.circular(MatchieStyle.compactRadius),
          child: Ink(
            padding: const EdgeInsets.all(14),
            decoration: MatchieStyle.compactPanel(),
            child: Row(
              children: [
                _CvScorePill(score: score),
                const SizedBox(width: 12),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(title, style: _PrototypeText.title),
                      const SizedBox(height: 4),
                      Text(subtitle, style: _PrototypeText.body),
                    ],
                  ),
                ),
                const Icon(Icons.chevron_right, color: MatchiePalette.faint),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _PaperPreview extends StatelessWidget {
  const _PaperPreview();

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(18),
      decoration: MatchieStyle.panel(),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: const [
          Text('Chetan Jain', style: MatchieStyle.brandHeading),
          SizedBox(height: 8),
          Text(
            'Product-minded graduate with research, analytics, and service design experience.',
            style: _PrototypeText.body,
          ),
          SizedBox(height: 16),
          _ResumeLine(width: 0.96),
          _ResumeLine(width: 0.82),
          _ResumeLine(width: 0.72),
          SizedBox(height: 12),
          _ResumeLine(width: 0.88),
          _ResumeLine(width: 0.64),
        ],
      ),
    );
  }
}

class _ResumeLine extends StatelessWidget {
  const _ResumeLine({required this.width});

  final double width;

  @override
  Widget build(BuildContext context) {
    return FractionallySizedBox(
      widthFactor: width,
      child: Container(
        height: 8,
        margin: const EdgeInsets.only(bottom: 8),
        decoration: BoxDecoration(
          color: MatchiePalette.outline.withValues(alpha: 0.82),
          borderRadius: BorderRadius.circular(99),
        ),
      ),
    );
  }
}

class _SuggestionCard extends StatelessWidget {
  const _SuggestionCard({required this.title, required this.body});

  final String title;
  final String body;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: _InfoPanel(
        title: title,
        body: body,
        icon: Icons.tips_and_updates_outlined,
      ),
    );
  }
}

class _TextAreaCard extends StatelessWidget {
  const _TextAreaCard({required this.title, required this.body});

  final String title;
  final String body;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: () => _showPrototypeSheet(
          context,
          title: title,
          body:
              'The full app opens an editor here. This prototype keeps the current copy visible.',
        ),
        borderRadius: BorderRadius.circular(MatchieStyle.radius),
        child: Ink(
          width: double.infinity,
          padding: const EdgeInsets.all(16),
          decoration: MatchieStyle.panel(),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(title, style: _PrototypeText.title),
              const SizedBox(height: 10),
              Text(body, style: _PrototypeText.body),
              const SizedBox(height: 14),
              const Align(
                alignment: Alignment.centerRight,
                child: Icon(Icons.edit_outlined, color: MatchiePalette.faint),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _ProjectCard extends StatelessWidget {
  const _ProjectCard({
    required this.title,
    required this.subtitle,
    required this.tags,
  });

  final String title;
  final String subtitle;
  final List<String> tags;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(16),
      decoration: MatchieStyle.panel(),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title, style: _PrototypeText.title),
          const SizedBox(height: 8),
          Text(subtitle, style: _PrototypeText.body),
          const SizedBox(height: 12),
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: [
              for (final tag in tags)
                _TagChip(
                  label: tag,
                  onTap: () => _showPrototypeSheet(
                    context,
                    title: tag,
                    body:
                        'This portfolio tag filters related proof in the full app.',
                  ),
                ),
            ],
          ),
        ],
      ),
    );
  }
}

class _PreferenceGroup extends StatelessWidget {
  const _PreferenceGroup({required this.title, required this.values});

  final String title;
  final List<String> values;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: MatchieStyle.panel(),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(title, style: _PrototypeText.title),
          const SizedBox(height: 12),
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: [
              for (final value in values)
                _TagChip(
                  label: value,
                  active: true,
                  onTap: () => _showPrototypeSheet(
                    context,
                    title: value,
                    body:
                        'This preference is selected. The full app lets you edit it from here.',
                  ),
                ),
            ],
          ),
        ],
      ),
    );
  }
}

class _PathStep extends StatelessWidget {
  const _PathStep({
    required this.period,
    required this.title,
    required this.body,
  });

  final String period;
  final String title;
  final String body;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(16),
      decoration: MatchieStyle.panel(),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 66,
            padding: const EdgeInsets.symmetric(vertical: 10),
            decoration: BoxDecoration(
              color: Colors.white.withValues(alpha: 0.12),
              borderRadius: BorderRadius.circular(14),
              border: Border.all(
                color: MatchiePalette.purple.withValues(alpha: 0.34),
              ),
            ),
            child: Text(
              period,
              textAlign: TextAlign.center,
              style: const TextStyle(
                color: MatchiePalette.text,
                fontWeight: FontWeight.w800,
                letterSpacing: 0,
              ),
            ),
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title, style: _PrototypeText.title),
                const SizedBox(height: 6),
                Text(body, style: _PrototypeText.body),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _ReferenceCard extends StatelessWidget {
  const _ReferenceCard({
    required this.name,
    required this.role,
    required this.status,
  });

  final String name;
  final String role;
  final String status;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.only(bottom: 10),
      padding: const EdgeInsets.all(14),
      decoration: MatchieStyle.compactPanel(),
      child: Row(
        children: [
          _IconBubble(icon: Icons.person_pin_outlined),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(name, style: _PrototypeText.title),
                const SizedBox(height: 4),
                Text(role, style: _PrototypeText.body),
              ],
            ),
          ),
          _TagChip(
            label: status,
            active: status == 'Ready',
            onTap: () => _showPrototypeSheet(
              context,
              title: status,
              body: 'Reference status opens from here in the full app.',
            ),
          ),
        ],
      ),
    );
  }
}

class _CoverLetterTile extends StatelessWidget {
  const _CoverLetterTile({
    required this.title,
    required this.subtitle,
    required this.status,
    required this.onTap,
  });

  final String title;
  final String subtitle;
  final String status;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10),
      child: _ActionTile(
        title: title,
        subtitle: subtitle,
        icon: Icons.mail_outline,
        action: status,
        onTap: onTap,
      ),
    );
  }
}

class _JobMatchCard extends StatelessWidget {
  const _JobMatchCard({required this.job, required this.onTap});

  final PrototypeJob job;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(MatchieStyle.radius),
        child: Ink(
          padding: const EdgeInsets.all(14),
          decoration: MatchieStyle.panel(),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(job.title, style: _PrototypeText.title),
                        const SizedBox(height: 4),
                        Text(
                          '${job.company} · ${job.location}',
                          style: _PrototypeText.body,
                        ),
                        const SizedBox(height: 5),
                        Text(job.salary, style: _PrototypeText.small),
                      ],
                    ),
                  ),
                  const SizedBox(width: 8),
                  _MatchBadge(score: job.score),
                ],
              ),
              const SizedBox(height: 10),
              Wrap(
                spacing: 7,
                runSpacing: 7,
                children: [
                  _MetricBadge(
                    label: '${job.safeScore}% AI Safe',
                    icon: Icons.shield_outlined,
                    color: MatchiePalette.yellow,
                  ),
                  _MetricBadge(
                    label: '${job.ghostRisk}% Ghost',
                    icon: Icons.visibility_off_outlined,
                    color: MatchiePalette.green,
                  ),
                  for (final tag in job.tags.take(2))
                    _TagChip(
                      label: tag,
                      onTap: () => _showPrototypeSheet(
                        context,
                        title: tag,
                        body:
                            'This job tag filters similar matches in the full app.',
                      ),
                    ),
                ],
              ),
              const SizedBox(height: 12),
              GradientButton(
                label: 'View match',
                icon: Icons.arrow_forward_rounded,
                onPressed: onTap,
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _MatchBadge extends StatelessWidget {
  const _MatchBadge({required this.score});

  final int score;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 11, vertical: 7),
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.12),
        borderRadius: BorderRadius.circular(18),
        border: Border.all(
          color: MatchiePalette.purple.withValues(alpha: 0.42),
        ),
      ),
      child: Text(
        '$score% Strong',
        style: const TextStyle(
          color: MatchiePalette.text,
          fontSize: 12,
          fontWeight: FontWeight.w600,
          decoration: TextDecoration.none,
        ),
      ),
    );
  }
}

class _MetricBadge extends StatelessWidget {
  const _MetricBadge({
    required this.label,
    required this.icon,
    required this.color,
  });

  final String label;
  final IconData icon;
  final Color color;

  @override
  Widget build(BuildContext context) {
    final badgeColor = color == MatchiePalette.green
        ? MatchiePalette.purple
        : color == MatchiePalette.yellow
        ? MatchiePalette.pink
        : color;
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 9, vertical: 6),
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.10),
        borderRadius: BorderRadius.circular(99),
        border: Border.all(color: badgeColor.withValues(alpha: 0.42)),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, color: badgeColor, size: 14),
          const SizedBox(width: 5),
          Text(
            label,
            style: TextStyle(
              color: badgeColor,
              fontSize: 11,
              fontWeight: FontWeight.w600,
              decoration: TextDecoration.none,
            ),
          ),
        ],
      ),
    );
  }
}

class _JobsHeaderControls extends StatelessWidget {
  const _JobsHeaderControls({required this.onFilters, required this.onMap});

  final VoidCallback onFilters;
  final VoidCallback onMap;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            const _FaIconBubble(icon: FontAwesomeIcons.briefcase),
            const SizedBox(width: 10),
            const Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Job Matches', style: MatchieStyle.screenTitle),
                  SizedBox(height: 3),
                  Text('Bangalore scan', style: _PrototypeText.small),
                ],
              ),
            ),
            _CompactActionButton(
              label: 'Filters',
              icon: Icons.tune_rounded,
              onTap: onFilters,
            ),
          ],
        ),
        const SizedBox(height: 12),
        Container(
          padding: const EdgeInsets.all(5),
          decoration: BoxDecoration(
            color: MatchiePalette.glassSoft,
            borderRadius: BorderRadius.circular(18),
            border: Border.all(color: MatchieStyle.glassBorder()),
          ),
          child: Row(
            children: [
              Expanded(
                child: _SegmentButton(
                  label: 'List',
                  icon: Icons.view_list_rounded,
                  active: true,
                  onTap: () => _showPrototypeSheet(
                    context,
                    title: 'List view',
                    body:
                        'You are already viewing the scan-first job list. Use Map to switch into location browsing.',
                  ),
                ),
              ),
              Expanded(
                child: _SegmentButton(
                  label: 'Map',
                  icon: Icons.map_outlined,
                  active: false,
                  onTap: onMap,
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 12),
        const Row(
          children: [
            Expanded(
              child: _JobStatTile(label: 'Found', value: '20'),
            ),
            SizedBox(width: 8),
            Expanded(
              child: _JobStatTile(label: 'Strong', value: '17'),
            ),
            SizedBox(width: 8),
            Expanded(
              child: _JobStatTile(label: 'Ghost risk', value: 'Low'),
            ),
          ],
        ),
      ],
    );
  }
}

class _CompactActionButton extends StatelessWidget {
  const _CompactActionButton({
    required this.label,
    required this.icon,
    required this.onTap,
  });

  final String label;
  final IconData icon;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(18),
        child: Ink(
          padding: const EdgeInsets.symmetric(horizontal: 13, vertical: 12),
          decoration: BoxDecoration(
            color: MatchiePalette.glassSoft,
            borderRadius: BorderRadius.circular(18),
            border: Border.all(color: MatchieStyle.glassBorder(active: true)),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(icon, color: MatchiePalette.purple, size: 18),
              const SizedBox(width: 7),
              Text(
                label,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(
                  color: MatchiePalette.text,
                  fontSize: 12.5,
                  fontWeight: FontWeight.w600,
                  decoration: TextDecoration.none,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _JobStatTile extends StatelessWidget {
  const _JobStatTile({required this.label, required this.value});

  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 11, vertical: 10),
      decoration: MatchieStyle.compactPanel(),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(label, style: _PrototypeText.small),
          const SizedBox(height: 4),
          Text(
            value,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: GoogleFonts.spaceGrotesk(
              color: MatchiePalette.text,
              fontSize: 16,
              fontWeight: FontWeight.w700,
              decoration: TextDecoration.none,
            ),
          ),
        ],
      ),
    );
  }
}

class _SegmentButton extends StatelessWidget {
  const _SegmentButton({
    required this.label,
    required this.icon,
    required this.active,
    required this.onTap,
  });

  final String label;
  final IconData icon;
  final bool active;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(15),
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 9),
        decoration: BoxDecoration(
          color: active
              ? Colors.white.withValues(alpha: 0.16)
              : Colors.transparent,
          borderRadius: BorderRadius.circular(15),
          border: active
              ? Border.all(color: Colors.white.withValues(alpha: 0.20))
              : null,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              icon,
              size: 18,
              color: active ? MatchiePalette.purple : MatchiePalette.muted,
            ),
            const SizedBox(width: 5),
            Text(
              label,
              style: TextStyle(
                color: active ? MatchiePalette.purple : MatchiePalette.muted,
                fontWeight: FontWeight.w700,
                decoration: TextDecoration.none,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _JobFilterStrip extends StatelessWidget {
  const _JobFilterStrip();

  @override
  Widget build(BuildContext context) {
    return Wrap(
      spacing: 8,
      runSpacing: 8,
      children: const [
        _StatusChip(
          label: 'Strong (17)',
          color: MatchiePalette.green,
          active: true,
        ),
        _StatusChip(
          label: 'Good (3)',
          color: MatchiePalette.yellow,
          active: false,
        ),
        _StatusChip(
          label: 'Remote',
          color: MatchiePalette.purple,
          active: false,
        ),
        _StatusChip(
          label: 'All sources',
          color: MatchiePalette.purple,
          active: true,
        ),
      ],
    );
  }
}

class _JobSummaryBand extends StatelessWidget {
  const _JobSummaryBand({required this.onRatingKey});

  final VoidCallback onRatingKey;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(12),
      decoration: MatchieStyle.compactPanel(active: true),
      child: Row(
        children: [
          const _GradientIcon(icon: Icons.auto_awesome_outlined, size: 38),
          const SizedBox(width: 10),
          const Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Profile scan complete', style: _PrototypeText.title),
                SizedBox(height: 4),
                Text(
                  'Matched using your skills, goals, sources, and location.',
                  style: _PrototypeText.body,
                ),
              ],
            ),
          ),
          IconButton(
            tooltip: 'Rating key',
            onPressed: onRatingKey,
            icon: const Icon(Icons.key_outlined, size: 22),
            color: MatchiePalette.muted,
          ),
        ],
      ),
    );
  }
}

class _StatusChip extends StatelessWidget {
  const _StatusChip({
    required this.label,
    required this.color,
    required this.active,
  });

  final String label;
  final Color color;
  final bool active;

  @override
  Widget build(BuildContext context) {
    final chipColor = active ? MatchiePalette.purple : color;
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
      decoration: BoxDecoration(
        color: active
            ? Colors.white.withValues(alpha: 0.14)
            : MatchiePalette.glassSoft,
        borderRadius: BorderRadius.circular(14),
        border: Border.all(color: chipColor.withValues(alpha: 0.46)),
      ),
      child: Row(
        children: [
          Icon(
            active ? Icons.check_circle_rounded : Icons.circle_outlined,
            size: 18,
            color: chipColor,
          ),
          const SizedBox(width: 7),
          Text(
            label,
            style: TextStyle(
              color: active ? MatchiePalette.text : MatchiePalette.muted,
              fontSize: 12.5,
              fontWeight: FontWeight.w600,
              decoration: TextDecoration.none,
            ),
          ),
        ],
      ),
    );
  }
}

class _JobDetailHero extends StatelessWidget {
  const _JobDetailHero({required this.job});

  final PrototypeJob job;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(18),
      decoration: MatchieStyle.panel(active: true),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              _ScoreRing(score: job.score, large: true),
              const SizedBox(width: 16),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(job.company, style: _PrototypeText.title),
                    const SizedBox(height: 6),
                    Text(job.salary, style: _PrototypeText.body),
                    const SizedBox(height: 6),
                    Text(
                      'AI safe ${job.safeScore}% · Ghost ${job.ghostRisk}%',
                      style: _PrototypeText.small,
                    ),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 14),
          Text(job.summary, style: _PrototypeText.body),
          const SizedBox(height: 12),
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: [
              for (final tag in job.tags)
                _TagChip(
                  label: tag,
                  active: true,
                  onTap: () => _showPrototypeSheet(
                    context,
                    title: tag,
                    body:
                        'This job tag filters similar matches in the full app.',
                  ),
                ),
            ],
          ),
        ],
      ),
    );
  }
}

class _BulletPanel extends StatelessWidget {
  const _BulletPanel({
    required this.text,
    required this.icon,
    this.warning = false,
  });

  final String text;
  final IconData icon;
  final bool warning;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(12),
      decoration: MatchieStyle.compactPanel(),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(
            icon,
            color: warning ? MatchiePalette.yellow : MatchiePalette.green,
          ),
          const SizedBox(width: 10),
          Expanded(child: Text(text, style: _PrototypeText.body)),
        ],
      ),
    );
  }
}

class _IconActionButton extends StatelessWidget {
  const _IconActionButton({
    required this.label,
    required this.icon,
    required this.onTap,
  });

  final String label;
  final IconData icon;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Tooltip(
      message: label,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(16),
        child: Container(
          width: 54,
          height: 54,
          decoration: MatchieStyle.compactPanel(),
          child: Icon(icon, color: MatchiePalette.text),
        ),
      ),
    );
  }
}

class _DeepDivePanel extends StatelessWidget {
  const _DeepDivePanel({
    required this.title,
    required this.body,
    required this.icon,
  });

  final String title;
  final String body;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(16),
      decoration: MatchieStyle.panel(),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _IconBubble(icon: icon),
          const SizedBox(height: 12),
          Text(title, style: _PrototypeText.title),
          const SizedBox(height: 6),
          Text(body, style: _PrototypeText.body),
        ],
      ),
    );
  }
}

class _PreparationCard extends StatelessWidget {
  const _PreparationCard({required this.job});

  final PrototypeJob job;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(18),
      decoration: MatchieStyle.panel(active: true),
      child: Row(
        children: [
          _ScoreRing(score: job.score),
          const SizedBox(width: 14),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(job.title, style: _PrototypeText.title),
                const SizedBox(height: 4),
                Text(job.company, style: _PrototypeText.body),
                const SizedBox(height: 8),
                Text(
                  'Primary action: prepare before applying.',
                  style: _PrototypeText.small,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _PrepItem extends StatelessWidget {
  const _PrepItem({
    required this.title,
    required this.body,
    required this.done,
  });

  final String title;
  final String body;
  final bool done;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      padding: const EdgeInsets.all(14),
      decoration: MatchieStyle.compactPanel(active: done),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Icon(
            done ? Icons.check_circle : Icons.radio_button_unchecked,
            color: done ? MatchiePalette.green : MatchiePalette.faint,
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title, style: _PrototypeText.title),
                const SizedBox(height: 4),
                Text(body, style: _PrototypeText.body),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _MapGrid extends StatelessWidget {
  const _MapGrid();

  @override
  Widget build(BuildContext context) {
    return CustomPaint(painter: _MapGridPainter());
  }
}

class _MapGridPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = MatchiePalette.outline.withValues(alpha: 0.44)
      ..strokeWidth = 1;
    const gap = 42.0;

    for (double x = gap; x < size.width; x += gap) {
      canvas.drawLine(Offset(x, 0), Offset(x, size.height), paint);
    }
    for (double y = gap; y < size.height; y += gap) {
      canvas.drawLine(Offset(0, y), Offset(size.width, y), paint);
    }

    final centerPaint = Paint()
      ..color = MatchiePalette.purple.withValues(alpha: 0.18)
      ..style = PaintingStyle.fill;
    canvas.drawCircle(size.center(Offset.zero), 96, centerPaint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}

class _MapPin extends StatelessWidget {
  const _MapPin({required this.score});

  final String score;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 58,
      height: 58,
      decoration: BoxDecoration(
        gradient: MatchieGradients.brand,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: MatchiePalette.purple.withValues(alpha: 0.28),
            blurRadius: 18,
            offset: const Offset(0, 10),
          ),
        ],
      ),
      child: Center(
        child: Text(
          score,
          style: const TextStyle(
            color: MatchiePalette.text,
            fontWeight: FontWeight.w900,
            letterSpacing: 0,
          ),
        ),
      ),
    );
  }
}

class _LargePromptCard extends StatelessWidget {
  const _LargePromptCard({required this.onSend});

  final VoidCallback onSend;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onSend,
        borderRadius: BorderRadius.circular(MatchieStyle.radius),
        child: Ink(
          width: double.infinity,
          padding: const EdgeInsets.all(14),
          decoration: MatchieStyle.panel(),
          child: Container(
            height: 84,
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
            decoration: BoxDecoration(
              color: MatchiePalette.glassSoft,
              borderRadius: BorderRadius.circular(22),
              border: Border.all(color: MatchieStyle.glassBorder()),
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: const [
                Expanded(
                  child: Text(
                    'Hello Chetan...',
                    style: TextStyle(
                      color: MatchiePalette.faint,
                      fontSize: 20,
                      decoration: TextDecoration.none,
                    ),
                  ),
                ),
                _SendPromptButton(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _SendPromptButton extends StatelessWidget {
  const _SendPromptButton();

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 44,
      height: 44,
      decoration: BoxDecoration(
        color: Colors.white.withValues(alpha: 0.12),
        shape: BoxShape.circle,
        border: Border.all(color: MatchieStyle.glassBorder()),
      ),
      child: const Icon(Icons.arrow_upward, color: MatchiePalette.muted),
    );
  }
}

class _UpgradeStrip extends StatelessWidget {
  const _UpgradeStrip({required this.onTap});

  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(MatchieStyle.compactRadius),
      child: Container(
        padding: const EdgeInsets.fromLTRB(14, 11, 12, 11),
        decoration: MatchieStyle.compactPanel(),
        child: Row(
          children: [
            const Icon(
              Icons.auto_awesome,
              color: MatchiePalette.purple,
              size: 18,
            ),
            const SizedBox(width: 8),
            const Expanded(
              child: Text(
                'Free, 20 messages/month',
                style: _PrototypeText.body,
              ),
            ),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
              decoration: BoxDecoration(
                gradient: MatchieGradients.brand,
                borderRadius: BorderRadius.circular(13),
              ),
              child: const Text('Upgrade', style: _PrototypeText.small),
            ),
          ],
        ),
      ),
    );
  }
}

class _ChatAboutJobCard extends StatelessWidget {
  const _ChatAboutJobCard({required this.onTap});

  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(MatchieStyle.radius),
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.all(16),
        decoration: MatchieStyle.panel(active: true),
        child: const Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.work_outline_rounded, color: MatchiePalette.purple),
            SizedBox(width: 10),
            Text('Chat about a job', style: _PrototypeText.title),
            SizedBox(width: 8),
            Icon(Icons.arrow_forward, color: MatchiePalette.purple),
          ],
        ),
      ),
    );
  }
}

class _ModeTile extends StatelessWidget {
  const _ModeTile({required this.mode, required this.onTap});

  final PrototypeMenuItem mode;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return _ActionTile(
      title: mode.title,
      subtitle: mode.subtitle,
      icon: mode.icon,
      action: 'Chat',
      onTap: onTap,
    );
  }
}

class _ChatBubble extends StatelessWidget {
  const _ChatBubble({required this.message});

  final ChatMessage message;

  @override
  Widget build(BuildContext context) {
    final alignment = message.fromUser
        ? Alignment.centerRight
        : Alignment.centerLeft;

    return Align(
      alignment: alignment,
      child: ConstrainedBox(
        constraints: const BoxConstraints(maxWidth: 390),
        child: Container(
          padding: const EdgeInsets.all(14),
          decoration: BoxDecoration(
            gradient: MatchieStyle.glassGradient(active: message.fromUser),
            borderRadius: BorderRadius.circular(18),
            border: Border.all(
              color: message.fromUser
                  ? MatchiePalette.purple.withValues(alpha: 0.40)
                  : MatchieStyle.glassBorder(),
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(message.sender, style: _PrototypeText.small),
              const SizedBox(height: 6),
              Text(message.text, style: _PrototypeText.body),
            ],
          ),
        ),
      ),
    );
  }
}

class _PromptBar extends StatelessWidget {
  const _PromptBar();

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: () => _showPrototypeSheet(
          context,
          title: 'Message sent',
          body:
              'This prototype shows the chat input placement. The full app would send your prompt here.',
        ),
        borderRadius: BorderRadius.circular(MatchieStyle.compactRadius),
        child: Ink(
          padding: const EdgeInsets.all(12),
          decoration: MatchieStyle.compactPanel(active: true),
          child: Row(
            children: const [
              Expanded(
                child: Text(
                  'Ask about jobs, CV edits, interviews, or salary...',
                  style: _PrototypeText.body,
                ),
              ),
              SizedBox(width: 8),
              Icon(Icons.send_outlined, color: MatchiePalette.text),
            ],
          ),
        ),
      ),
    );
  }
}

class _StatusPanel extends StatelessWidget {
  const _StatusPanel();

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(18),
      decoration: MatchieStyle.panel(active: true),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: const [
          Row(
            children: [
              _GradientIcon(icon: Icons.near_me_outlined, size: 48),
              SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('On the Go is active', style: _PrototypeText.title),
                    SizedBox(height: 4),
                    Text(
                      'Scanning nearby roles around Bangalore.',
                      style: _PrototypeText.body,
                    ),
                  ],
                ),
              ),
            ],
          ),
          SizedBox(height: 16),
          _MetricRow(
            label: 'Radius',
            value: '8 miles',
            icon: Icons.radar_outlined,
          ),
          _MetricRow(
            label: 'Nearby matches',
            value: '3 found',
            icon: Icons.location_on_outlined,
          ),
          _MetricRow(
            label: 'My posts',
            value: '2 live',
            icon: Icons.inventory_2_outlined,
          ),
        ],
      ),
    );
  }
}

class _TogglePanel extends StatelessWidget {
  const _TogglePanel({
    required this.title,
    required this.body,
    required this.enabled,
  });

  final String title;
  final String body;
  final bool enabled;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(14),
      decoration: MatchieStyle.compactPanel(active: enabled),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(title, style: _PrototypeText.title),
                const SizedBox(height: 4),
                Text(body, style: _PrototypeText.body),
              ],
            ),
          ),
          _PrototypeSwitch(initialValue: enabled),
        ],
      ),
    );
  }
}

class _PrototypeSwitch extends StatefulWidget {
  const _PrototypeSwitch({required this.initialValue});

  final bool initialValue;

  @override
  State<_PrototypeSwitch> createState() => _PrototypeSwitchState();
}

class _PrototypeSwitchState extends State<_PrototypeSwitch> {
  late bool value = widget.initialValue;

  @override
  Widget build(BuildContext context) {
    return Switch(
      value: value,
      onChanged: (nextValue) {
        setState(() {
          value = nextValue;
        });
      },
      activeThumbColor: MatchiePalette.text,
      activeTrackColor: MatchiePalette.purple,
      inactiveThumbColor: MatchiePalette.muted,
      inactiveTrackColor: MatchiePalette.outline,
    );
  }
}

class _FilterSlider extends StatefulWidget {
  const _FilterSlider({required this.label, required this.value});

  final String label;
  final double value;

  @override
  State<_FilterSlider> createState() => _FilterSliderState();
}

class _FilterSliderState extends State<_FilterSlider> {
  late double value = widget.value;

  @override
  Widget build(BuildContext context) {
    final max = widget.label.contains('Radius') ? 20.0 : 100.0;
    final suffix = widget.label.contains('Radius') ? 'mi' : '%';

    return Container(
      width: double.infinity,
      padding: const EdgeInsets.all(16),
      decoration: MatchieStyle.panel(),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Expanded(child: Text(widget.label, style: _PrototypeText.title)),
              Text('${value.round()}$suffix', style: _PrototypeText.body),
            ],
          ),
          Slider(
            value: value,
            min: 0,
            max: max,
            onChanged: (nextValue) {
              setState(() {
                value = nextValue;
              });
            },
          ),
        ],
      ),
    );
  }
}

class _MoreTile extends StatelessWidget {
  const _MoreTile({required this.item, required this.onTap});

  final PrototypeMenuItem item;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return _MorePrimaryRow(title: item.title, icon: item.icon, onTap: onTap);
  }
}

class _MorePrimaryRow extends StatelessWidget {
  const _MorePrimaryRow({
    required this.title,
    required this.icon,
    required this.onTap,
  });

  final String title;
  final IconData icon;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 14),
        decoration: const BoxDecoration(color: Colors.transparent),
        child: Row(
          children: [
            Icon(icon, color: MatchiePalette.muted, size: 25),
            const SizedBox(width: 18),
            Expanded(
              child: Text(
                title,
                style: const TextStyle(
                  color: MatchiePalette.text,
                  fontSize: 21,
                  fontWeight: FontWeight.w600,
                  decoration: TextDecoration.none,
                ),
              ),
            ),
            const Icon(Icons.chevron_right, color: MatchiePalette.faint),
          ],
        ),
      ),
    );
  }
}

class _DangerActionButton extends StatelessWidget {
  const _DangerActionButton({
    required this.label,
    required this.icon,
    required this.onTap,
    this.compact = false,
    this.alignLeft = false,
  });

  final String label;
  final IconData icon;
  final VoidCallback onTap;
  final bool compact;
  final bool alignLeft;

  @override
  Widget build(BuildContext context) {
    final text = Text(
      label,
      overflow: TextOverflow.ellipsis,
      style: TextStyle(
        color: MatchiePalette.red,
        fontSize: compact ? 17 : 18,
        fontWeight: FontWeight.w800,
        decoration: TextDecoration.none,
      ),
    );

    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(compact ? 16 : 18),
        child: Ink(
          width: double.infinity,
          padding: EdgeInsets.symmetric(
            horizontal: alignLeft ? 18 : 12,
            vertical: compact ? 15 : 16,
          ),
          decoration: BoxDecoration(
            color: MatchiePalette.red.withValues(alpha: 0.12),
            borderRadius: BorderRadius.circular(compact ? 16 : 18),
            border: Border.all(
              color: MatchiePalette.red.withValues(alpha: 0.24),
            ),
          ),
          child: Row(
            mainAxisAlignment: alignLeft
                ? MainAxisAlignment.start
                : MainAxisAlignment.center,
            children: [
              Icon(icon, color: MatchiePalette.red),
              SizedBox(width: alignLeft ? 14 : 10),
              if (alignLeft) Expanded(child: text) else text,
              if (alignLeft)
                Icon(
                  Icons.chevron_right,
                  color: MatchiePalette.red.withValues(alpha: 0.68),
                ),
            ],
          ),
        ),
      ),
    );
  }
}

class _MenuProfileCard extends StatelessWidget {
  const _MenuProfileCard({required this.onTap});

  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(20),
      child: Container(
        width: double.infinity,
        padding: const EdgeInsets.all(16),
        decoration: MatchieStyle.compactPanel(),
        child: Row(
          children: [
            Container(
              width: 70,
              height: 70,
              decoration: BoxDecoration(
                color: MatchiePalette.purple.withValues(alpha: 0.20),
                shape: BoxShape.circle,
              ),
              child: const Center(
                child: Text(
                  'CJ',
                  style: TextStyle(
                    fontFamily: 'Playfair Display',
                    color: MatchiePalette.purple,
                    fontSize: 26,
                    fontWeight: FontWeight.w700,
                    decoration: TextDecoration.none,
                  ),
                ),
              ),
            ),
            const SizedBox(width: 14),
            const Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Chetan Jain', style: _PrototypeText.title),
                  SizedBox(height: 4),
                  Text('Frontend Engineer', style: _PrototypeText.body),
                  SizedBox(height: 8),
                  Text(
                    'View profile ->',
                    style: TextStyle(
                      color: MatchiePalette.purple,
                      fontSize: 15,
                      fontWeight: FontWeight.w700,
                      decoration: TextDecoration.none,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _ShortcutTile extends StatelessWidget {
  const _ShortcutTile({
    required this.title,
    required this.icon,
    required this.color,
    required this.onTap,
  });

  final String title;
  final IconData icon;
  final Color color;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(16),
      child: Container(
        padding: const EdgeInsets.all(12),
        decoration: MatchieStyle.compactPanel(),
        child: Row(
          children: [
            _TinyIconTile(icon: icon, color: color),
            const SizedBox(width: 10),
            Expanded(
              child: Text(
                title,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(
                  color: MatchiePalette.text,
                  fontSize: 14,
                  fontWeight: FontWeight.w800,
                  height: 1.08,
                  decoration: TextDecoration.none,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _TinyIconTile extends StatelessWidget {
  const _TinyIconTile({required this.icon, required this.color});

  final IconData icon;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 40,
      height: 40,
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.16),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Icon(icon, color: color, size: 23),
    );
  }
}

class _MenuSectionLabel extends StatelessWidget {
  const _MenuSectionLabel(this.label);

  final String label;

  @override
  Widget build(BuildContext context) {
    return Text(
      label,
      style: const TextStyle(
        color: MatchiePalette.muted,
        fontSize: 14,
        fontWeight: FontWeight.w800,
        letterSpacing: 2.2,
        decoration: TextDecoration.none,
      ),
    );
  }
}

class _MenuRow extends StatelessWidget {
  const _MenuRow({
    required this.title,
    required this.icon,
    required this.onTap,
    this.active = false,
    this.highlighted = false,
  });

  final String title;
  final IconData icon;
  final VoidCallback onTap;
  final bool active;
  final bool highlighted;

  @override
  Widget build(BuildContext context) {
    final color = active
        ? MatchiePalette.green
        : highlighted
        ? MatchiePalette.purple
        : MatchiePalette.text;

    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(16),
      child: Container(
        margin: const EdgeInsets.only(top: 6),
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
        decoration: BoxDecoration(
          color: active
              ? MatchiePalette.green.withValues(alpha: 0.12)
              : highlighted
              ? MatchiePalette.purple.withValues(alpha: 0.12)
              : Colors.transparent,
          borderRadius: BorderRadius.circular(16),
        ),
        child: Row(
          children: [
            Icon(icon, color: color.withValues(alpha: 0.86), size: 27),
            const SizedBox(width: 18),
            Expanded(
              child: Text(
                title,
                style: TextStyle(
                  color: color,
                  fontSize: 20,
                  fontWeight: FontWeight.w500,
                  decoration: TextDecoration.none,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _SettingsRowData {
  const _SettingsRowData({
    required this.title,
    required this.subtitle,
    required this.icon,
    required this.onTap,
  });

  final String title;
  final String subtitle;
  final IconData icon;
  final VoidCallback onTap;
}

class _SettingsGroup extends StatelessWidget {
  const _SettingsGroup({required this.rows});

  final List<_SettingsRowData> rows;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      padding: EdgeInsets.zero,
      decoration: MatchieStyle.panel(),
      child: Column(
        children: [
          for (var i = 0; i < rows.length; i++) ...[
            _SettingsRow(row: rows[i]),
            if (i != rows.length - 1)
              Divider(
                height: 1,
                indent: 68,
                color: MatchiePalette.outline.withValues(alpha: 0.48),
              ),
          ],
        ],
      ),
    );
  }
}

class _SettingsRow extends StatelessWidget {
  const _SettingsRow({required this.row});

  final _SettingsRowData row;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: row.onTap,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 18),
        child: Row(
          children: [
            Icon(row.icon, color: MatchiePalette.muted, size: 30),
            const SizedBox(width: 18),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(row.title, style: _PrototypeText.title),
                  const SizedBox(height: 4),
                  Text(row.subtitle, style: _PrototypeText.body),
                ],
              ),
            ),
            const Icon(Icons.chevron_right, color: MatchiePalette.faint),
          ],
        ),
      ),
    );
  }
}

class _HelpCategorySection extends StatelessWidget {
  const _HelpCategorySection({
    required this.icon,
    required this.title,
    required this.items,
  });

  final IconData icon;
  final String title;
  final List<String> items;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Icon(icon, color: MatchiePalette.purple),
            const SizedBox(width: 12),
            Expanded(
              child: Text(
                title,
                style: MatchieStyle.screenTitle,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ],
        ),
        const SizedBox(height: 14),
        Wrap(
          spacing: 10,
          runSpacing: 10,
          children: [
            for (final item in items)
              _TagChip(
                label: item,
                onTap: () => _showPrototypeSheet(
                  context,
                  title: item,
                  body:
                      'This help topic opens from here in the full app. The prototype confirms the entry is tappable.',
                ),
              ),
          ],
        ),
      ],
    );
  }
}

class _GradientIcon extends StatelessWidget {
  const _GradientIcon({required this.icon, this.size = 42});

  final IconData icon;
  final double size;

  @override
  Widget build(BuildContext context) {
    return MatchieGlassSurface(
      compact: true,
      active: true,
      radius: size * 0.32,
      width: size,
      height: size,
      blur: false,
      child: Icon(icon, color: MatchiePalette.purple, size: size * 0.52),
    );
  }
}

class _IconBubble extends StatelessWidget {
  const _IconBubble({required this.icon});

  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return MatchieGlassSurface(
      compact: true,
      radius: 14,
      width: 42,
      height: 42,
      blur: false,
      child: Icon(icon, color: MatchiePalette.purple, size: 22),
    );
  }
}

class _FaIconBubble extends StatelessWidget {
  const _FaIconBubble({required this.icon});

  final FaIconData icon;

  @override
  Widget build(BuildContext context) {
    return MatchieGlassSurface(
      compact: true,
      radius: 14,
      width: 42,
      height: 42,
      blur: false,
      child: Center(
        child: FaIcon(icon, color: MatchiePalette.purple, size: 19),
      ),
    );
  }
}

class _TagChip extends StatelessWidget {
  const _TagChip({required this.label, this.active = false, this.onTap});

  final String label;
  final bool active;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final chip = _GlassChipFrame(
      label: label,
      active: active,
      tappable: onTap != null,
    );

    if (onTap == null) {
      return chip;
    }

    return Material(
      color: Colors.transparent,
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(99),
        child: chip,
      ),
    );
  }
}

class _ScoreRing extends StatelessWidget {
  const _ScoreRing({required this.score, this.large = false});

  final int score;
  final bool large;

  @override
  Widget build(BuildContext context) {
    final size = large ? 82.0 : 64.0;

    return SizedBox(
      width: size,
      height: size,
      child: Stack(
        alignment: Alignment.center,
        children: [
          SizedBox(
            width: size,
            height: size,
            child: CircularProgressIndicator(
              value: score / 100,
              strokeWidth: large ? 8 : 6,
              backgroundColor: MatchiePalette.outline,
              valueColor: const AlwaysStoppedAnimation<Color>(
                MatchiePalette.purple,
              ),
            ),
          ),
          Text(
            '$score',
            style: TextStyle(
              color: MatchiePalette.text,
              fontWeight: FontWeight.w900,
              fontSize: large ? 22 : 18,
              letterSpacing: 0,
            ),
          ),
        ],
      ),
    );
  }
}

class _CvScorePill extends StatelessWidget {
  const _CvScorePill({required this.score});

  final String score;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 58,
      height: 44,
      decoration: BoxDecoration(
        gradient: MatchieGradients.brand,
        borderRadius: BorderRadius.circular(16),
      ),
      child: Center(
        child: Text(
          score,
          style: const TextStyle(
            color: MatchiePalette.text,
            fontWeight: FontWeight.w900,
            letterSpacing: 0,
          ),
        ),
      ),
    );
  }
}

void _push(BuildContext context, Widget screen) {
  Navigator.of(context).push(MaterialPageRoute<void>(builder: (_) => screen));
}

void _showMatchieMenu(BuildContext context) {
  final tabSelected = MatchieMenuScope.maybeOf(context)?.onTabSelected;

  Navigator.of(context).push(
    PageRouteBuilder<void>(
      opaque: false,
      barrierColor: Colors.transparent,
      pageBuilder: (_, _, _) => MatchieMenuScreen(onTabSelected: tabSelected),
      transitionsBuilder: (_, animation, _, child) {
        return FadeTransition(opacity: animation, child: child);
      },
    ),
  );
}

void _replaceFromMenu(BuildContext context, int? tabIndex, Widget screen) {
  final onTabSelected = context
      .findAncestorWidgetOfExactType<MatchieMenuScreen>()
      ?.onTabSelected;

  Navigator.of(context).pop();

  if (tabIndex != null && onTabSelected != null) {
    onTabSelected(tabIndex);
    return;
  }

  _push(context, screen);
}

void _showPrototypeSheet(
  BuildContext context, {
  required String title,
  required String body,
}) {
  showModalBottomSheet<void>(
    context: context,
    backgroundColor: Colors.transparent,
    shape: const RoundedRectangleBorder(
      borderRadius: BorderRadius.vertical(top: Radius.circular(26)),
    ),
    builder: (context) {
      return ClipRRect(
        borderRadius: const BorderRadius.vertical(top: Radius.circular(26)),
        child: BackdropFilter(
          filter: MatchieStyle.glassBlur(active: true),
          child: Container(
            decoration: BoxDecoration(
              gradient: MatchieStyle.glassGradient(active: true),
              borderRadius: const BorderRadius.vertical(
                top: Radius.circular(26),
              ),
              border: Border(
                top: BorderSide(color: MatchieStyle.glassBorder(active: true)),
              ),
            ),
            child: SafeArea(
              child: Padding(
                padding: const EdgeInsets.all(22),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(title, style: MatchieStyle.brandHeading),
                    const SizedBox(height: 10),
                    Text(body, style: _PrototypeText.body),
                    const SizedBox(height: 18),
                    GradientButton(
                      label: 'Done',
                      icon: Icons.check,
                      onPressed: () => Navigator.of(context).pop(),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      );
    },
  );
}
