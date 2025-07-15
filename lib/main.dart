import 'package:flutter/material.dart';
import 'package:idenzza/firebase_options.dart';
import 'package:url_launcher/url_launcher.dart'; // Import para abrir URLs
import 'package:firebase_core/firebase_core.dart'; // Import para inicializar o Firebase
import 'package:firebase_auth/firebase_auth.dart'; // Import para autenticação Firebase
import 'package:cloud_firestore/cloud_firestore.dart'; // Import para o Firestore

void main() async {
  WidgetsFlutterBinding.ensureInitialized(); // Garante que o Flutter esteja inicializado

  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  final FirebaseAuth auth = FirebaseAuth.instance;
  await auth.signInAnonymously();
  print('Autenticado anonimamente.');

  runApp(const IdenzzaApp());
}

class IdenzzaApp extends StatelessWidget {
  const IdenzzaApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Idenzza - Branding de Marca',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        fontFamily: 'Inter',
        useMaterial3: false,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: const LandingPage(),
    );
  }
}

class LandingPage extends StatefulWidget {
  const LandingPage({super.key});

  @override
  State<LandingPage> createState() => _LandingPageState();
}

class _LandingPageState extends State<LandingPage> {
  final GlobalKey _heroKey = GlobalKey();
  final GlobalKey _benefitsKey = GlobalKey();
  final GlobalKey _methodologyKey = GlobalKey();
  final GlobalKey _contactKey = GlobalKey();

  void _scrollToSection(GlobalKey key) {
    Scrollable.ensureVisible(
      key.currentContext!,
      duration: const Duration(milliseconds: 500),
      curve: Curves.easeInOut,
    );
  }

  void _showQuestionnaireDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return const QuestionnaireDialog();
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        return Scaffold(
          appBar: AppBar(
            backgroundColor: const Color(0xFF1A237E),
            elevation: 0,
            title: const Text(
              'IDENZZA',
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
            actions: [
              TextButton(
                onPressed: () => _scrollToSection(_heroKey),
                child: const Text('Início', style: TextStyle(color: Colors.white)),
              ),
              TextButton(
                onPressed: () => _scrollToSection(_benefitsKey),
                child: const Text('Benefícios', style: TextStyle(color: Colors.white)),
              ),
              TextButton(
                onPressed: () => _scrollToSection(_methodologyKey),
                child: const Text('Metodologia', style: TextStyle(color: Colors.white)),
              ),
              TextButton(
                onPressed: () => _scrollToSection(_contactKey),
                child: const Text('Contato', style: TextStyle(color: Colors.white)),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 16.0,
                  vertical: 10,
                ),
                child: TextButton(
                  onPressed: () {
                    _showQuestionnaireDialog(context);
                  },
                  style: TextButton.styleFrom(
                    backgroundColor: const Color(0xFFFF9800),
                    foregroundColor: Colors.white,
                    padding: const EdgeInsets.symmetric(
                      horizontal: 20,
                      vertical: 10,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  child: const Text(
                    'RAIO-X AGORA',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
              ),
            ],
          ),
          body: SingleChildScrollView(
            child: Column(
              children: [
                Container(
                  key: _heroKey,
                  child: _buildHeroSection(context, constraints),
                ),
                Container(
                  key: _benefitsKey,
                  child: _buildBenefitsSection(context, constraints),
                ),
                Container(
                  key: _methodologyKey,
                  child: _buildMethodologySection(context, constraints),
                ),
                _buildCallToActionSection(context, constraints),
                Container(
                  key: _contactKey,
                  child: _buildFooterSection(context, constraints),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _buildHeroSection(BuildContext context, BoxConstraints constraints) {
    final bool isDesktop = constraints.maxWidth > 800;

    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(
        vertical: isDesktop ? 100 : 50,
        horizontal: isDesktop ? constraints.maxWidth * 0.1 : 20,
      ),
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          colors: [
            Color(0xFF1A237E),
            Color(0xFF0D47A1),
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            'Sua Marca com Identidade',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: isDesktop ? 48 : 32,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
          SizedBox(height: isDesktop ? 20 : 15),
          Text(
            'Transforme sua essência em autoridade digital com uma marca clara e reconhecida.',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: isDesktop ? 18 : 16,
              color: Colors.white,
            ),
          ),
          SizedBox(height: isDesktop ? 60 : 40),
          isDesktop
              ? IntrinsicHeight(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Expanded(
                        child: _buildStatCard(
                          '85%',
                          '''dos profissionais com marca forte ganham mais
"Segundo pesquisas de mercado, marcas fortes ampliam reconhecimento e preço percebido"''',
                        ),
                      ),
                      const SizedBox(width: 40),
                      Expanded(
                        child: _buildStatCard(
                          '3x',
                          '''mais convites, parcerias e propostas certas''',
                        ),
                      ),
                      const SizedBox(width: 40),
                      Expanded(
                        child: _buildStatCard(
                          '92%',
                          '''dos consumidores escolhem marcas em que confiam de verdade''',
                        ),
                      ),
                    ],
                  ),
                )
              : Wrap(
                  spacing: 20,
                  runSpacing: 20,
                  alignment: WrapAlignment.center,
                  children: [
                    SizedBox(
                      width: 200,
                      child: _buildStatCard(
                        '85%',
                        '''dos profissionais com marca forte ganham mais
"Segundo pesquisas de mercado, marcas fortes ampliam reconhecimento e preço percebido"''',
                      ),
                    ),
                    SizedBox(
                      width: 200,
                      child: _buildStatCard(
                        '3x',
                        '''mais convites, parcerias e propostas certas''',
                      ),
                    ),
                    SizedBox(
                      width: 200,
                      child: _buildStatCard(
                        '92%',
                        '''dos consumidores escolhem marcas em que confiam de verdade''',
                      ),
                    ),
                  ],
                ),
          SizedBox(height: isDesktop ? 60 : 40),
          ElevatedButton(
            onPressed: () {
              _showQuestionnaireDialog(context);
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFFFF9800),
              foregroundColor: Colors.white,
              padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 20),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              textStyle: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            child: const Text('Desbloquear Minha Marca Agora'),
          ),
        ],
      ),
    );
  }

  Widget _buildStatCard(String value, String description) {
    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.1),
        borderRadius: BorderRadius.circular(15),
        border: Border.all(color: Colors.white.withOpacity(0.2)),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            value,
            style: const TextStyle(
              fontSize: 36,
              fontWeight: FontWeight.bold,
              color: Color(0xFFFF9800),
            ),
          ),
          const SizedBox(height: 10),
          Text(
            description,
            textAlign: TextAlign.center,
            style: const TextStyle(fontSize: 16, color: Colors.white),
          ),
        ],
      ),
    );
  }

  Widget _buildBenefitsSection(
    BuildContext context,
    BoxConstraints constraints,
  ) {
    final bool isDesktop = constraints.maxWidth > 800;

    return Container(
      width: double.infinity,
      color: Colors.white,
      padding: EdgeInsets.symmetric(
        vertical: isDesktop ? 80 : 40,
        horizontal: isDesktop ? constraints.maxWidth * 0.1 : 20,
      ),
      child: Column(
        children: [
          Text(
            'Por que sua marca pessoal é fundamental?',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: isDesktop ? 38 : 28,
              fontWeight: FontWeight.bold,
              color: Colors.black87,
            ),
          ),
          SizedBox(height: isDesktop ? 20 : 15),
          Text(
            'Transforme sua presença profissional e acelere seus resultados com uma marca autêntica e estratégica',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: isDesktop ? 18 : 16,
              color: Colors.black54,
            ),
          ),
          SizedBox(height: isDesktop ? 60 : 30),
          GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: isDesktop
                  ? 4
                  : (constraints.maxWidth > 600 ? 2 : 1),
              crossAxisSpacing: isDesktop ? 30 : 20,
              mainAxisSpacing: isDesktop ? 30 : 20,
              childAspectRatio: isDesktop ? 0.9 : 0.8,
            ),
            itemCount: 4,
            itemBuilder: (context, index) {
              final List<Map<String, dynamic>> benefits = [
                {
                  'icon': Icons.emoji_events,
                  'title': 'Autoridade no mercado',
                  'description':
                      'A marca certa posiciona você como referência.',
                  'highlight': '+150% de percepção profissional',
                  'iconColor': const Color(0xFF1A237E),
                  'iconBgColor': const Color(0xFFE3F2FD),
                },
                {
                  'icon': Icons.people_alt,
                  'title': 'Atração de clientes ideais',
                  'description':
                      'Profissionais com marca forte atraem quem realmente valoriza o seu trabalho.',
                  'highlight': '+200% na qualidade dos leads',
                  'iconColor': const Color(0xFF0D47A1),
                  'iconBgColor': const Color(0xFFBBDEFB),
                },
                {
                  'icon': Icons.rocket_launch,
                  'title': 'Crescimento acelerado',
                  'description':
                      'Quando sua marca comunica bem, o mercado responde com força.',
                  'highlight': '+300% nas oportunidades',
                  'iconColor': const Color(0xFFFF9800),
                  'iconBgColor': const Color(0xFFFFECB3),
                },
                {
                  'icon': Icons.security,
                  'title': 'Proteção contra crises',
                  'description': 'Uma marca sólida sustenta sua autoridade mesmo em tempos difíceis.',
                  'highlight': '+80% em estabilidade',
                  'iconColor': const Color(0xFF4CAF50),
                  'iconBgColor': const Color(0xFFDCEDC8),
                },
              ];
              final benefit = benefits[index];
              return _buildBenefitCard(
                icon: benefit['icon'],
                title: benefit['title'],
                description: benefit['description'],
                highlight: benefit['highlight'],
                iconColor: benefit['iconColor'],
                iconBgColor: benefit['iconBgColor'],
              );
            },
          ),
          SizedBox(height: isDesktop ? 60 : 30),
          const Text(
              '''*Dados estimados com base em tendências de mercado e análises internas da metodologia Idenzza. Resultados reais podem variar conforme o nível de implementação e maturidade da marca."''')
        ],
      ),
    );
  }

  Widget _buildBenefitCard({
    required IconData icon,
    required String title,
    required String description,
    required String highlight,
    required Color iconColor,
    required Color iconBgColor,
  }) {
    return Card(
      elevation: 5,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
      child: Padding(
        padding: const EdgeInsets.all(25.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: iconBgColor,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Icon(icon, size: 30, color: iconColor),
            ),
            const SizedBox(height: 15),
            Text(
              title,
              style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Colors.black87,
              ),
            ),
            const SizedBox(height: 10),
            Text(
              highlight,
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Color(0xFF1A237E),
              ),
            ),
            Expanded(
              child: Text(
                description,
                style: const TextStyle(fontSize: 15, color: Colors.black54),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildMethodologySection(
    BuildContext context,
    BoxConstraints constraints,
  ) {
    final bool isDesktop = constraints.maxWidth > 800;

    return Container(
      width: double.infinity,
      color: Colors.white,
      padding: EdgeInsets.symmetric(
        vertical: isDesktop ? 80 : 40,
        horizontal: isDesktop ? constraints.maxWidth * 0.1 : 20,
      ),
      child: Column(
        children: [
          Text(
            'O Caminho da sua Marca com Identidade',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: isDesktop ? 38 : 28,
              fontWeight: FontWeight.bold,
              color: Colors.black87,
            ),
          ),
          SizedBox(height: isDesktop ? 20 : 15),
          Text(
            'Um processo estruturado e comprovado para construir sua marca pessoal de forma estratégica',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: isDesktop ? 18 : 16,
              color: Colors.black54,
            ),
          ),
          SizedBox(height: isDesktop ? 60 : 30),
          isDesktop
              ? Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildMethodologyStep(
                      stepNumber: '01',
                      title: 'Diagnóstico Inteligente',
                      description:
                          '''Mapeie sua essência com precisão, combinando IA, estratégia e branding personalizado''',
                      color: const Color(0xFF1A237E),
                    ),
                    _buildMethodologyStep(
                      stepNumber: '02',
                      title: '''Reposicionamento com Essência''',
                      description:
                          '''Definição de nicho, voz autêntica e uma comunicação que traduz quem você é''',
                      color: const Color(0xFF0D47A1),
                    ),
                    _buildMethodologyStep(
                      stepNumber: '03',
                      title: 'Implementação Guiada',
                      description:
                          '''Do conceito à prática: alinhamento visual, co-criando conteúdos estratégicos com foco em autoridade e conexão''',
                      color: const Color(0xFFFF9800),
                    ),
                    _buildMethodologyStep(
                      stepNumber: '04',
                      title: 'Resultados Mensuráveis',
                      description:
                          '''Você vê o impacto: monitoramos dados reais e ajustamos sua presença para gerar resultados consistentemente''',
                      color: const Color(0xFF4CAF50),
                    ),
                  ],
                )
              : Column(
                  children: [
                    _buildMethodologyStep(
                      stepNumber: '01',
                      title: 'Diagnóstico Inteligente',
                      description:
                          '''Mapeie sua essência com precisão, combinando IA, estratégia e branding personalizado''',
                      color: const Color(0xFF1A237E),
                    ),
                    _buildMethodologyStep(
                      stepNumber: '02',
                      title: '''Reposicionamento com Essência''',
                      description:
                          '''Definição de nicho, voz autêntica e uma comunicação que traduz quem você é''',
                      color: const Color(0xFF0D47A1),
                    ),
                    _buildMethodologyStep(
                      stepNumber: '03',
                      title: 'Implementação Guiada',
                      description:
                          '''Do conceito à prática: alinhamento visual, co-criando conteúdos estratégicos com foco em autoridade e conexão''',
                      color: const Color(0xFFFF9800),
                    ),
                    _buildMethodologyStep(
                      stepNumber: '04',
                      title: 'Resultados Mensuráveis',
                      description:
                          '''Você vê o impacto: monitoramos dados reais e ajustamos sua presença para gerar resultados consistentemente''',
                      color: const Color(0xFF4CAF50),
                    ),
                  ],
                ),
        ],
      ),
    );
  }

  Widget _buildMethodologyStep({
    required String stepNumber,
    required String title,
    required String description,
    required Color color,
  }) {
    return SizedBox(
      width: 200,
      child: Column(
        children: [
          Container(
            width: 60,
            height: 60,
            decoration: BoxDecoration(color: color, shape: BoxShape.circle),
            alignment: Alignment.center,
            child: Text(
              stepNumber,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          const SizedBox(height: 20),
          Text(
            title,
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
              color: Colors.black87,
            ),
          ),
          const SizedBox(height: 10),
          Text(
            description,
            textAlign: TextAlign.center,
            style: const TextStyle(fontSize: 15, color: Colors.black54),
          ),
        ],
      ),
    );
  }

  Widget _buildCallToActionSection(
    BuildContext context,
    BoxConstraints constraints,
  ) {
    final bool isDesktop = constraints.maxWidth > 800;

    return Container(
      width: double.infinity,
      padding: EdgeInsets.symmetric(
        vertical: isDesktop ? 100 : 50,
        horizontal: isDesktop ? constraints.maxWidth * 0.1 : 20,
      ),
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          colors: [
            Color(0xFF0D47A1),
            Color(0xFF1A237E),
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
      ),
      child: Column(
        children: [
          Text(
            'Pronto para construir sua marca de sucesso?',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: isDesktop ? 42 : 30,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
          SizedBox(height: isDesktop ? 20 : 15),
          Text(
            'Comece agora respondendo nosso questionário estratégico. diagnóstico gratuito em 5 minutos.',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: isDesktop ? 18 : 16,
              color: Colors.white,
            ),
          ),
          SizedBox(height: isDesktop ? 50 : 30),
          ElevatedButton(
            onPressed: () {
              _showQuestionnaireDialog(context);
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFFFF9800),
              foregroundColor: Colors.white,
              padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 20),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10),
              ),
              textStyle: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            child: const Text('Iniciar minha análise gratuita'),
          ),
        ],
      ),
    );
  }

  Widget _buildFooterSection(BuildContext context, BoxConstraints constraints) {
    final bool isDesktop = constraints.maxWidth > 800;

    return Container(
      width: double.infinity,
      color: const Color(0xFF212121),
      padding: EdgeInsets.symmetric(
        vertical: isDesktop ? 50 : 30,
        horizontal: isDesktop ? constraints.maxWidth * 0.1 : 20,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          isDesktop
              ? Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      flex: 2,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'IDENZZA',
                            style: TextStyle(
                              fontSize: isDesktop ? 24 : 20,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                          const SizedBox(height: 10),
                          Text(
                            'Transformando profissionais em marcas autênticas e impactantes.\nSua identidade, nossa expertise.',
                            style: TextStyle(
                              fontSize: isDesktop ? 16 : 14,
                              color: Colors.white,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Expanded(
                      flex: 1,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Contato',
                            style: TextStyle(
                              fontSize: isDesktop ? 20 : 16,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                          const SizedBox(height: 10),
                          Row(
                            children: const [
                              Icon(Icons.email, color: Colors.white, size: 18),
                              SizedBox(width: 8),
                              Expanded(
                                child: Text(
                                  'alanrendeiro.fotografia@gmail.com',
                                  style: TextStyle(
                                    fontSize: 16,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 5),
                          Row(
                            children: const [
                              Icon(Icons.phone, color: Colors.white, size: 18),
                              SizedBox(width: 8),
                              Text(
                                '(91) 98972-7997',
                                style: TextStyle(
                                  fontSize: 16,
                                  color: Colors.white,
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 5),
                          Row(
                            children: const [
                              Icon(
                                Icons.location_on,
                                color: Colors.white,
                                size: 18,
                              ),
                              SizedBox(width: 8),
                              Expanded(
                                child: Text(
                                  'Tv Doutor Moraes 727, Belém- PA',
                                  style: TextStyle(
                                    fontSize: 16,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    Expanded(
                      flex: 1,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Redes Sociais',
                            style: TextStyle(
                              fontSize: isDesktop ? 20 : 16,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                          const SizedBox(height: 10),
                          Row(
                            children: [
                              _buildSocialMediaIcon(
                                'https://img.icons8.com/ios-filled/50/ffffff/linkedin.png',
                                'LinkedIn',
                              ),
                              const SizedBox(width: 10),
                              _buildSocialMediaIcon(
                                'https://img.icons8.com/ios-filled/50/ffffff/instagram-new.png',
                                'Instagram',
                              ),
                              const SizedBox(width: 10),
                              _buildSocialMediaIcon(
                                'https://img.icons8.com/ios-filled/50/ffffff/youtube--v1.png',
                                'YouTube',
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                )
              : Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'IDENZZA',
                      style: TextStyle(
                        fontSize: isDesktop ? 24 : 20,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    const SizedBox(height: 10),
                    Text(
                      'Transformando profissionais em marcas autênticas e impactantes.\nSua identidade, nossa expertise.',
                      style: TextStyle(
                        fontSize: isDesktop ? 16 : 14,
                        color: Colors.white,
                      ),
                    ),
                    const SizedBox(height: 30),
                    Text(
                      'Contato',
                      style: TextStyle(
                        fontSize: isDesktop ? 20 : 16,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    const SizedBox(height: 10),
                    Row(
                      children: const [
                        Icon(Icons.email, color: Colors.white, size: 18),
                        SizedBox(width: 8),
                        Expanded(
                          child: Text(
                            'alanrendeiro.fotografia@gmail.com',
                            style: TextStyle(fontSize: 16, color: Colors.white),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 5),
                    Row(
                      children: const [
                        Icon(Icons.phone, color: Colors.white, size: 18),
                        SizedBox(width: 8),
                        Text(
                          '(91) 98972-7997',
                          style: TextStyle(fontSize: 16, color: Colors.white),
                        ),
                      ],
                    ),
                    const SizedBox(height: 5),
                    Row(
                      children: const [
                        Icon(Icons.location_on, color: Colors.white, size: 18),
                        SizedBox(width: 8),
                        Expanded(
                          child: Text(
                            'Tv Doutor Moraes 727, Belém- PA',
                            style: TextStyle(fontSize: 16, color: Colors.white),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 30),
                    Text(
                      'Redes Sociais',
                      style: TextStyle(
                        fontSize: isDesktop ? 20 : 16,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ),
                    ),
                    const SizedBox(height: 10),
                    Row(
                      children: [
                        _buildSocialMediaIcon(
                          'https://img.icons8.com/ios-filled/50/ffffff/linkedin.png',
                          'LinkedIn',
                        ),
                        const SizedBox(width: 10),
                        _buildSocialMediaIcon(
                          'https://img.icons8.com/ios-filled/50/ffffff/instagram-new.png',
                          'Instagram',
                        ),
                        const SizedBox(width: 10),
                        _buildSocialMediaIcon(
                          'https://img.icons8.com/ios-filled/50/ffffff/youtube--v1.png',
                          'YouTube',
                        ),
                      ],
                    ),
                  ],
                ),
          const Divider(color: Colors.white38, height: 50, thickness: 1),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                '© 2025 IDENZZA. Todos os direitos reservados.',
                style: TextStyle(
                  fontSize: isDesktop ? 14 : 12,
                  color: Colors.white54,
                ),
              ),
              InkWell(
                onTap: () async {
                  final Uri url = Uri.parse(
                    'https://linktr.ee/_c.luan?fbclid=PAZXh0bgNhZW0CMTEAAafb7oTw8tTnFGZ4TkarQql9AwcspXs8giBuNBwRBQiQnNA2KF3eoAaymB3J1A_aem_E1qy3xkGGHmGKZBMkX09DQ',
                  );
                  if (await canLaunchUrl(url)) {
                    await launchUrl(url);
                  } else {
                    print('Não foi possível abrir a URL: $url');
                  }
                },
                child: Text(
                  'Desenvolvido por C.Luan (github)',
                  style: TextStyle(
                    fontSize: isDesktop ? 14 : 12,
                    color: Colors.white54,
                    decoration: TextDecoration.underline,
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildSocialMediaIcon(String imageUrl, String altText) {
    return InkWell(
      onTap: () {
        print('$altText clicado!');
      },
      child: Container(
        width: 40,
        height: 40,
        decoration: BoxDecoration(
          color: Colors.blueAccent,
          borderRadius: BorderRadius.circular(8),
        ),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Image.network(
            imageUrl,
            errorBuilder: (context, error, stackTrace) {
              return const Icon(Icons.error, color: Colors.white);
            },
          ),
        ),
      ),
    );
  }
}

class QuestionnaireDialog extends StatefulWidget {
  const QuestionnaireDialog({super.key});

  @override
  State<QuestionnaireDialog> createState() => _QuestionnaireDialogState();
}

class _QuestionnaireDialogState extends State<QuestionnaireDialog> {
  final PageController _pageController = PageController();
  int _currentPage = 0;

  final List<GlobalKey<FormState>> _formKeys = List.generate(
    7, // Now 7 pages (0-6)
    (_) => GlobalKey<FormState>(),
  );

  final TextEditingController _fullNameController = TextEditingController();
  final TextEditingController _professionController = TextEditingController();
  final TextEditingController _brandSocialMediaController = TextEditingController();
  final TextEditingController _threeWordsController = TextEditingController();
  final TextEditingController _motivationController = TextEditingController();
  final TextEditingController _storyController = TextEditingController();
  final TextEditingController _rememberedByController = TextEditingController();
  final TextEditingController _uniqueSellingPointController = TextEditingController();
  final TextEditingController _clientComplimentsController = TextEditingController();
  final TextEditingController _notAsBrandController = TextEditingController();
  final TextEditingController _admiredBrandsProfessionalsController = TextEditingController();
  final TextEditingController _idealClientController = TextEditingController();
  final TextEditingController _clientProblemsController = TextEditingController();
  final TextEditingController _clientSolutionSearchController = TextEditingController();
  final TextEditingController _uniqueHelpController = TextEditingController();
  final TextEditingController _consumedBrandsController = TextEditingController();
  final TextEditingController _socialMediaPresenceController = TextEditingController();
  final TextEditingController _publishFrequencyController = TextEditingController();
  final TextEditingController _contentWorksBestController = TextEditingController();
  String? _imageAlignmentAnswer;
  final TextEditingController _admiredCommunicationBrandsController = TextEditingController();
  final TextEditingController _repositioningGoalController = TextEditingController();
  final TextEditingController _communicationChallengesController = TextEditingController();
  final TextEditingController _ifRecognizedChangeController = TextEditingController();
  final TextEditingController _brandAsSomethingController = TextEditingController();
  double _brandPositioningScore = 6.0;

  final Map<String, dynamic> _answers = {};

  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  @override
  void dispose() {
    _pageController.dispose();
    _fullNameController.dispose();
    _professionController.dispose();
    _brandSocialMediaController.dispose();
    _threeWordsController.dispose();
    _motivationController.dispose();
    _storyController.dispose();
    _rememberedByController.dispose();
    _uniqueSellingPointController.dispose();
    _clientComplimentsController.dispose();
    _notAsBrandController.dispose();
    _admiredBrandsProfessionalsController.dispose();
    _idealClientController.dispose();
    _clientProblemsController.dispose();
    _clientSolutionSearchController.dispose();
    _uniqueHelpController.dispose();
    _consumedBrandsController.dispose();
    _socialMediaPresenceController.dispose();
    _publishFrequencyController.dispose();
    _contentWorksBestController.dispose();
    _admiredCommunicationBrandsController.dispose();
    _repositioningGoalController.dispose();
    _communicationChallengesController.dispose();
    _ifRecognizedChangeController.dispose();
    _brandAsSomethingController.dispose();
    super.dispose();
  }

  void _nextPage() {
    if (_formKeys[_currentPage].currentState!.validate()) {
      _formKeys[_currentPage].currentState!.save();
      if (_currentPage < 6) {
        _pageController.nextPage(
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeIn,
        );
      } else {
        _submitForm();
      }
    }
  }

  void _previousPage() {
    if (_currentPage > 0) {
      _pageController.previousPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeIn,
      );
    }
  }

  void _submitForm() async {
    _answers.clear();

    // Changed keys to Portuguese in the map for Firestore
    _answers['nomeCompleto'] = _fullNameController.text;
    _answers['profissaoEspecialidade'] = _professionController.text;
    _answers['nomeMarcaRedesSociais'] = _brandSocialMediaController.text;
    _answers['tresPalavrasMarca'] = _threeWordsController.text;
    _answers['motivacaoCarreira'] = _motivationController.text;
    _answers['historiaMarcante'] = _storyController.text;
    _answers['comoGostariaSerLembrado'] = _rememberedByController.text;
    _answers['oQueSoVoceFaz'] = _uniqueSellingPointController.text;
    _answers['elogiosClientes'] = _clientComplimentsController.text;
    _answers['naoComoMarca'] = _notAsBrandController.text;
    _answers['marcasProfissionaisAdmirados'] = _admiredBrandsProfessionalsController.text;
    _answers['clienteIdeal'] = _idealClientController.text;
    _answers['problemasDesejosCliente'] = _clientProblemsController.text;
    _answers['ondeClienteBuscaSolucoes'] = _clientSolutionSearchController.text;
    _answers['comoAjudaUnicamente'] = _uniqueHelpController.text;
    _answers['marcasConsumidasPeloPublico'] = _consumedBrandsController.text;
    _answers['presencaRedesSociais'] = _socialMediaPresenceController.text;
    _answers['frequenciaPublicacao'] = _publishFrequencyController.text;
    _answers['tipoConteudoMelhor'] = _contentWorksBestController.text;
    _answers['alinhamentoImagemProposito'] = _imageAlignmentAnswer;
    _answers['marcasComunicacaoAdmiradas'] = _admiredCommunicationBrandsController.text;
    _answers['objetivoReposicionamento'] = _repositioningGoalController.
text;
    _answers['desafiosComunicacaoAtual'] = _communicationChallengesController.text;
    _answers['mudancaMarcaReconhecida'] = _ifRecognizedChangeController.text;
    _answers['marcaComoAlgo'] = _brandAsSomethingController.text;
    _answers['pontuacaoPosicionamento'] = _brandPositioningScore.round();

    final String userId = FirebaseAuth.instance.currentUser?.uid ?? 'anonymous';

    try {
      // await Navigator.of(context).pop();

      if (!mounted) {
        print('Widget not mounted after popping, cannot proceed.');
        return;
      }

      await _firestore
          .collection('idenzza')
          .doc('responses')
          .collection('users')
          .doc(userId)
          .collection('questionnaires')
          .add({
            ..._answers,
            'timestamp': FieldValue.serverTimestamp(),
            'userId': userId,
          });

      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            scrollable: true,
            backgroundColor: const Color(0xFF1A237E),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15),
            ),
            content: SizedBox(
              width: 500,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Container(
                    width: 70,
                    height: 70,
                    decoration: const BoxDecoration(
                      color: Color(0xFF4CAF50),
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(
                      Icons.check,
                      color: Colors.white,
                      size: 40,
                    ),
                  ),
                  const SizedBox(height: 20),
                  const Text(
                    'Parabéns! Sua marca está prestes a se transformar.',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(height: 10),
                  const Text(
                    'Você acaba de dar o primeiro passo rumo a uma marca mais autêntica, estratégica e memorável.\n\nNossa equipe já recebeu suas respostas e, agora, iniciaremos uma análise profunda do seu perfil profissional para desenvolver um diagnóstico exclusivo - feito sob medida para seus objetivos de posicionamento.',
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 16, color: Colors.white70),
                  ),
                  const SizedBox(height: 20),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        _buildChecklistItem(
                          'Análise completa do seu perfil e essência de marca',
                        ),
                        _buildChecklistItem(
                          'Diagnóstico estratégico entregue em até 24h úteis',
                        ),
                        _buildChecklistItem(
                          'Proposta personalizada com recomendações táticas',
                        ),
                        _buildChecklistItem(
                          'Convite para uma consultoria gratuita com especialista',
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 20),
                  const Text(
                    'Todas as informações são tratadas com confidencialidade e usadas exclusivamente para construir a sua estratégia de marca.',
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 14, color: Colors.white54),
                  ),
                  const SizedBox(height: 30),
                  ElevatedButton(
                    onPressed: () async {
                      final Uri url = Uri.parse(
                        'https://wa.me/559189727997?text=Olá,%20gostaria%20de%20receber%20minha%20análise!',
                      );
                      if (await canLaunchUrl(url)) {
                        await launchUrl(url);
                      } else {
                        // ignore: use_build_context_synchronously
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text('Não foi possível abrir a URL: $url')),
                        );
                        print('Não foi possível abrir a URL: $url');
                      }
                      // ignore: use_build_context_synchronously
                      Navigator.of(context).pop();
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFFFF9800),
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(
                        horizontal: 20,
                        vertical: 15,
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    child: const Text(
                      'Fale com o especialista e receba sua análise →',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  const Text(
                    'IDENZZA',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      );
    } catch (e) {
      print('Erro ao salvar o formulário no Firestore: $e');
      // ignore: use_build_context_synchronously
      if (mounted) {
        showDialog(
          context: context,
          builder: (BuildContext context) {
            return AlertDialog(
              title: const Text('Erro!'),
              content: Text('Ocorreu um erro ao enviar seu formulário: $e'),
              actions: <Widget>[
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: const Text('OK'),
                ),
              ],
            );
          },
        );
      }
    }
  }

  Widget _buildChecklistItem(String text) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Icon(
            Icons.check,
            color: Color(0xFF4CAF50),
            size: 20,
          ),
          const SizedBox(width: 8),
          Expanded(
            child: Text(
              text,
              style: const TextStyle(fontSize: 16, color: Colors.white),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      elevation: 10,
      child: Container(
        width: MediaQuery.of(context).size.width * 0.9,
        height: MediaQuery.of(context).size.height * 0.9,
        constraints: const BoxConstraints(
          maxWidth: 700,
          maxHeight: 750,
        ),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: const [
                        Text(
                          'Vamos Começar!',
                          style: TextStyle(
                            fontSize: 24,
                            fontWeight: FontWeight.bold,
                            color: Colors.black87,
                          ),
                        ),
                        SizedBox(height: 5),
                        Text(
                          'Primeiro, precisamos conhecer você melhor',
                          style: TextStyle(fontSize: 16, color: Colors.black54),
                        ),
                      ],
                    ),
                  ),
                  IconButton(
                    icon: const Icon(Icons.close),
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                  ),
                ],
              ),
            ),
            const Divider(height: 1, thickness: 1),
            Expanded(
              child: PageView(
                controller: _pageController,
                physics: const NeverScrollableScrollPhysics(),
                onPageChanged: (index) {
                  setState(() {
                    _currentPage = index;
                  });
                },
                children: [
                  // PAGE 0 (Q1-Q4)
                  _buildPage(
                    pageIndex: 0,
                    children: [
                      _buildQuestionTitle('1. Qual o seu nome completo?'),
                      _buildTextField(
                        controller: _fullNameController,
                        hintText: 'Maria Silva',
                        validator: (value) =>
                            value!.isEmpty ? 'Campo obrigatório' : null,
                      ),
                      const SizedBox(height: 20),
                      _buildQuestionTitle(
                        '2. Qual a sua profissão e sua especialidade?',
                      ),
                      _buildTextField(
                        controller: _professionController,
                        hintText: 'Designer especializada em transformação digital e estratégias de crescimento',
                        maxLines: 2,
                        validator: (value) =>
                            value!.isEmpty ? 'Campo obrigatório' : null,
                      ),
                      const SizedBox(height: 20),
                      _buildQuestionTitle(
                        '3. Qual é o nome da sua marca ou perfil nas redes sociais?',
                      ),
                      _buildTextField(
                        controller: _brandSocialMediaController,
                        hintText: '@maria_silva_oficial',
                      ),
                      const SizedBox(height: 20),
                      _buildQuestionTitle(
                        '4. Quais são 3 palavras que melhor descrevem sua marca pessoal hoje?',
                      ),
                      _buildTextField(
                        controller: _threeWordsController,
                        hintText: 'Inovadora, Confiável, Inspiradora',
                        maxLines: 2,
                      ),
                    ],
                  ),
                  // PAGE 1 (Q5-Q8)
                  _buildPage(
                    pageIndex: 1,
                    children: [
                      _buildQuestionTitle(
                        '5. O que te motivou a iniciar essa carreira?',
                      ),
                      _buildTextField(
                        controller: _motivationController,
                        hintText: 'A paixão por ajudar pessoas a alcançarem seus objetivos...',
                        maxLines: 3,
                      ),
                      const SizedBox(height: 20),
                      _buildQuestionTitle(
                        '6. Existe alguma história marcante que resume sua essência profissional?',
                      ),
                      _buildTextField(
                        controller: _storyController,
                        hintText: 'Quando ajudei uma startup a crescer 300% em 6 meses...',
                        maxLines: 3,
                      ),
                      const SizedBox(height: 20),
                      _buildQuestionTitle(
                        '7. Como você gostaria de ser lembrado(a) pelas pessoas?',
                      ),
                      _buildTextField(
                        controller: _rememberedByController,
                        hintText: 'Como alguém que transforma ideias em resultados concretos...',
                        maxLines: 3,
                      ),
                      const SizedBox(height: 20),
                      _buildQuestionTitle(
                        '8. Se você tivesse que se vender em 1 minuto, o que diria que só você faz?',
                      ),
                      _buildTextField(
                        controller: _uniqueSellingPointController,
                        hintText: 'Combino visão estratégica com execução prática, entregando resultados...',
                        maxLines: 3,
                      ),
                    ],
                  ),
                  // PAGE 2 (Q9-Q12)
                  _buildPage(
                    pageIndex: 2,
                    children: [
                      _buildQuestionTitle(
                        '9. O que seus clientes costumam elogiar mais em você?',
                      ),
                      _buildTextField(
                        controller: _clientComplimentsController,
                        hintText: 'Minha capacidade de simplificar o complexo e minha dedicação...',
                        maxLines: 3,
                      ),
                      const SizedBox(height: 20),
                      _buildQuestionTitle(
                        '10. Em uma palavra, o que você não é como marca?',
                      ),
                      _buildTextField(
                        controller: _notAsBrandController,
                        hintText: 'Superficial',
                      ),
                      const SizedBox(height: 20),
                      _buildQuestionTitle(
                        '11. Quais marcas ou profissionais você admira pela forma como se posicionam ou comunicam? (Inclua links ou @s do Instagram ou outras redes que você acompanha e se inspira)',
                      ),
                      _buildTextField(
                        controller: _admiredBrandsProfessionalsController,
                        hintText: '@garyvee, @melrobbins, @simonsinekofficial - pela autenticidade e impacto',
                        maxLines: 3,
                      ),
                      const SizedBox(height: 20),
                      _buildQuestionTitle(
                        '12. Quem é o seu cliente ideal? (idade, profissão, estilo de vida, rotina)',
                      ),
                      _buildTextField(
                        controller: _idealClientController,
                        hintText: 'Empreendedores entre 30-45 anos, donos de pequenas e médias empresas...',
                        maxLines: 3,
                      ),
                    ],
                  ),
                  // PAGE 3 (Q13-Q16)
                  _buildPage(
                    pageIndex: 3,
                    children: [
                      _buildQuestionTitle(
                        '13. Quais são os principais problemas, desejos ou dores que esse cliente tem?',
                      ),
                      _buildTextField(
                        controller: _clientProblemsController,
                        hintText: 'Falta de estratégia digital clara, dificuldade em converter leads...',
                        maxLines: 3,
                      ),
                      const SizedBox(height: 20),
                      _buildQuestionTitle(
                        '14. Onde ele(a) costuma buscar soluções antes de te encontrar? (Google, Instagram, indicação, YouTube etc.)',
                      ),
                      _buildTextField(
                        controller: _clientSolutionSearchController,
                        hintText: 'Google, LinkedIn, indicações de outros empresários, YouTube',
                        maxLines: 2,
                      ),
                      const SizedBox(height: 20),
                      _buildQuestionTitle(
                        '15. Como você ajuda essa pessoa de forma única?',
                      ),
                      _buildTextField(
                        controller: _uniqueHelpController,
                        hintText: 'Ofereço consultoria personalizada com foco em ROI e acompanhamento contínuo...',
                        maxLines: 3,
                      ),
                      const SizedBox(height: 20),
                      _buildQuestionTitle(
                        '16. Quais marcas, criadores de conteúdo ou perfis esse público consome ou admira? (Se possível, coloque links ou @s)',
                      ),
                      _buildTextField(
                        controller: _consumedBrandsController,
                        hintText: '@sebrae, @endeavorbrasil, @startupbrasil, @exame',
                        maxLines: 3,
                      ),
                    ],
                  ),
                  // PAGE 4 (Q17-Q20)
                  _buildPage(
                    pageIndex: 4,
                    children: [
                      _buildQuestionTitle(
                        '17. Em quais redes sociais você está mais presente atualmente?',
                      ),
                      _buildTextField(
                        controller: _socialMediaPresenceController,
                        hintText: 'LinkedIn (principal), Instagram, YouTube',
                        maxLines: 2,
                      ),
                      const SizedBox(height: 20),
                      _buildQuestionTitle(
                        '18. Com que frequência você publica conteúdo?',
                      ),
                      _buildTextField(
                        controller: _publishFrequencyController,
                        hintText: 'LinkedIn: diariamente, Instagram: 3x por semana, YouTube: semanalmente',
                        maxLines: 2,
                      ),
                      const SizedBox(height: 20),
                      _buildQuestionTitle(
                        '19. Que tipo de conteúdo funciona melhor com seu público hoje? (Ex: bastidores, dicas, vídeos, textos, reels, etc.)',
                      ),
                      _buildTextField(
                        controller: _contentWorksBestController,
                        hintText: 'Cases de sucesso, dicas práticas em vídeos curtos, bastidores de projetos',
                        maxLines: 3,
                      ),
                      const SizedBox(height: 20),
                      _buildQuestionTitle(
                        '20. Você sente que sua imagem (visual, linguagem, posicionamento) está alinhada com seu propósito?',
                      ),
                      Column(
                        children: [
                          RadioListTile<String>(
                            title: const Text('Sim'),
                            value: 'Sim',
                            groupValue: _imageAlignmentAnswer,
                            onChanged: (value) {
                              setState(() {
                                _imageAlignmentAnswer = value;
                              });
                            },
                          ),
                          RadioListTile<String>(
                            title: const Text('Não'),
                            value: 'Não',
                            groupValue: _imageAlignmentAnswer,
                            onChanged: (value) {
                              setState(() {
                                _imageAlignmentAnswer = value;
                              });
                            },
                          ),
                          RadioListTile<String>(
                            title: const Text('Parcialmente'),
                            value: 'Parcialmente',
                            groupValue: _imageAlignmentAnswer,
                            onChanged: (value) {
                              setState(() {
                                _imageAlignmentAnswer = value;
                              });
                            },
                          ),
                        ],
                      ),
                    ],
                  ),
                  // PAGE 5 (Q21-Q24)
                  _buildPage(
                    pageIndex: 5,
                    children: [
                      _buildQuestionTitle(
                        '21. Quais marcas ou pessoas você admira pela forma como se comunicam com o público? (Coloque os @s ou links que te inspiram)',
                      ),
                      _buildTextField(
                        controller: _admiredCommunicationBrandsController,
                        hintText: '@apple, @nike, @patagonia - pela clareza e propósito bem definidos',
                        maxLines: 2,
                      ),
                      const SizedBox(height: 20),
                      _buildQuestionTitle(
                        '22. O que você gostaria de alcançar com o reposicionamento da sua marca pessoal?',
                      ),
                      _buildTextField(
                        controller: _repositioningGoalController,
                        hintText: 'Ser reconhecida como referência em transformação digital para PMEs no Brasil',
                        maxLines: 3,
                      ),
                      const SizedBox(height: 20),
                      _buildQuestionTitle(
                        '23. Quais são os maiores desafios que você enfrenta hoje na comunicação da sua marca?',
                      ),
                      _buildTextField(
                        controller: _communicationChallengesController,
                        hintText: 'Consistência entre plataformas e criação de conteúdo que gere engajamento real',
                        maxLines: 3,
                      ),
                      const SizedBox(height: 20),
                      _buildQuestionTitle(
                        '24. Se você já tivesse uma marca 100% alinhada e reconhecida, o que mudaria a partir de hoje?',
                      ),
                      _buildTextField(
                        controller: _ifRecognizedChangeController,
                        hintText: 'Teria mais seletividade nos projetos e poderia focar em clientes com maior potencial de impacto',
                        maxLines: 3,
                      ),
                    ],
                  ),
                  // PAGE 6 (Q25-Q26) - Final page
                  _buildPage(
                    pageIndex: 6,
                    children: [
                      _buildQuestionTitle(
                        '25. Se sua marca fosse uma música, uma cor ou uma cidade, qual seria? (Responda com o que vier à mente. Não existe certo ou errado.)',
                      ),
                      _buildTextField(
                        controller: _brandAsSomethingController,
                        hintText: 'Música: "Stronger" - Kelly Clarkson, Cor: Azul royal, Cidade: São Paulo',
                        maxLines: 2,
                      ),
                      const SizedBox(height: 20),
                      _buildQuestionTitle(
                        '26. De 0 a 10, quanto você acredita que sua marca está bem posicionada hoje?',
                      ),
                      Slider(
                        value: _brandPositioningScore,
                        min: 0,
                        max: 10,
                        divisions: 10,
                        label: _brandPositioningScore.round().toString(),
                        onChanged: (double value) {
                          setState(() {
                            _brandPositioningScore = value;
                          });
                        },
                      ),
                      Center(
                        child: Text(
                          'Sua pontuação: ${_brandPositioningScore.round()}/10',
                          style: const TextStyle(
                            fontSize: 18,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  if (_currentPage > 0)
                    ElevatedButton(
                      onPressed: _previousPage,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.grey.shade300,
                        foregroundColor: Colors.black87,
                        padding: const EdgeInsets.symmetric(
                          horizontal: 20,
                          vertical: 12,
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8),
                        ),
                      ),
                      child: const Text('Voltar'),
                    ),
                  const Spacer(),
                  ElevatedButton(
                    onPressed: _nextPage,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF0D47A1),
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(
                        horizontal: 20,
                        vertical: 12,
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    child: Text(
                      _currentPage == 6 ? 'Finalizar Questionário' : 'Próximo',
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

  Widget _buildPage({required int pageIndex, required List<Widget> children}) {
    return Form(
      key: _formKeys[pageIndex],
      child: SingleChildScrollView(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: children,
        ),
      ),
    );
  }

  Widget _buildTextField({
    required TextEditingController controller,
    String labelText = '',
    String? hintText,
    TextInputType keyboardType = TextInputType.text,
    int maxLines = 1,
    String? Function(String?)? validator,
  }) {
    return TextFormField(
      controller: controller,
      keyboardType: keyboardType,
      maxLines: maxLines,
      validator: validator,
      decoration: InputDecoration(
        labelText: labelText.isNotEmpty ? labelText : null,
        hintText: hintText,
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide(color: Colors.grey.shade300),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: BorderSide(color: Colors.grey.shade300),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(10),
          borderSide: const BorderSide(color: Color(0xFF1A237E), width: 2),
        ),
        filled: true,
        fillColor: Colors.grey.shade50,
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 15,
          vertical: 15,
        ),
      ),
    );
  }

  Widget _buildQuestionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 10.0),
      child: Text(
        title,
        style: const TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.w600,
          color: Colors.black87,
        ),
      ),
    );
  }
}