import 'package:flutter/material.dart';
import 'package:idenzza/firebase_options.dart';
import 'package:url_launcher/url_launcher.dart'; // Import para abrir URLs
import 'package:firebase_core/firebase_core.dart'; // Import para inicializar o Firebase
import 'package:firebase_auth/firebase_auth.dart'; // Import para autenticação Firebase
import 'package:cloud_firestore/cloud_firestore.dart'; // Import para o Firestore

void main() async {
  WidgetsFlutterBinding.ensureInitialized(); // Garante que o Flutter esteja inicializado

  // Inicializa o Firebase com a configuração fornecida pelo ambiente
  // Verifica se a configuração do Firebase está disponível

  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  // Autentica o usuário no Firebase
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
        // Define a fonte padrão para toda a aplicação.
        fontFamily: 'Inter',
        useMaterial3: false,
        visualDensity: VisualDensity.adaptivePlatformDensity,
        // Por padrão, o Flutter utiliza Material 2. Para usar Material 3,
        // seria necessário definir useMaterial3: true. Como não queremos,
        // garantimos que esta linha não está presente ou está como false.
      ),
      home: const LandingPage(),
    );
  }
}

// Convertendo LandingPage para StatefulWidget para gerenciar as chaves de rolagem
class LandingPage extends StatefulWidget {
  const LandingPage({super.key});

  @override
  State<LandingPage> createState() => _LandingPageState();
}

class _LandingPageState extends State<LandingPage> {
  // Chaves globais para cada seção da página
  final GlobalKey _heroKey = GlobalKey();
  final GlobalKey _benefitsKey = GlobalKey();
  final GlobalKey _methodologyKey = GlobalKey();
  final GlobalKey _contactKey =
      GlobalKey(); // Usaremos a chave do rodapé para "Contato"

  // Função para rolar para uma seção específica
  void _scrollToSection(GlobalKey key) {
    Scrollable.ensureVisible(
      key.currentContext!,
      duration: const Duration(
        milliseconds: 500,
      ), // Duração da animação de rolagem
      curve: Curves.easeInOut, // Curva da animação
    );
  }

  // Função para exibir o diálogo do questionário
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
    // Usamos o LayoutBuilder para tornar a página responsiva a diferentes tamanhos de tela.
    return LayoutBuilder(
      builder: (context, constraints) {
        return Scaffold(
          // AppBar para a navegação superior.
          appBar: AppBar(
            backgroundColor: const Color(
              0xFF1A237E,
            ), // Cor de fundo azul escuro
            elevation: 0, // Remove a sombra da AppBar
            title: const Text(
              'IDENZZA',
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
            actions: [
              // Botões de navegação na AppBar
              TextButton(
                onPressed: () => _scrollToSection(_heroKey),
                child: const Text(
                  'Início',
                  style: TextStyle(color: Colors.white),
                ),
              ),
              TextButton(
                onPressed: () => _scrollToSection(_benefitsKey),
                child: const Text(
                  'Benefícios',
                  style: TextStyle(color: Colors.white),
                ),
              ),
              TextButton(
                onPressed: () => _scrollToSection(_methodologyKey),
                child: const Text(
                  'Metodologia',
                  style: TextStyle(color: Colors.white),
                ),
              ),
              TextButton(
                onPressed: () => _scrollToSection(_contactKey),
                child: const Text(
                  'Contato',
                  style: TextStyle(color: Colors.white),
                ),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0,vertical:10),
                child: TextButton(
                  onPressed: () {
                    
                    _showQuestionnaireDialog(context);
                  },
                  style: TextButton.styleFrom(
                    // fixedSize: Size(150, 50),
                    backgroundColor: Colors.white,
                    foregroundColor: const Color(0xFF1A237E),
                    padding: const EdgeInsets.symmetric(
                      horizontal: 20,
                      vertical: 10,
                    ),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                  ),
                  child: const Text(
                    'Começar Agora',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
              ),
            ],
          ),
          // SingleChildScrollView permite que a página seja rolada.
          body: SingleChildScrollView(
            child: Column(
              children: [
                // Seção Hero (Destaque)
                // Adicionando a chave à seção
                Container(
                  key: _heroKey,
                  child: _buildHeroSection(context, constraints),
                ),
                // Seção "Por que Sua Marca Pessoal é Fundamental?" (Benefícios)
                // Adicionando a chave à seção
                Container(
                  key: _benefitsKey,
                  child: _buildBenefitsSection(context, constraints),
                ),
                // Seção "Como Construímos Sua Marca" (Metodologia)
                // Adicionando a chave à seção
                Container(
                  key: _methodologyKey,
                  child: _buildMethodologySection(context, constraints),
                ),
                // Seção "Pronto para Construir Sua Marca de Sucesso?" (Chamada para Ação)
                _buildCallToActionSection(context, constraints),
                // Rodapé
                // Adicionando a chave à seção
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

  // --- Seções da Landing Page ---

  Widget _buildHeroSection(BuildContext context, BoxConstraints constraints) {
    // A seção Hero ocupa 100% da largura e tem uma altura mínima.
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
            Color(0xFF1A237E), // Azul escuro
            Color(0xFF0D47A1), // Azul médio
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center, // Centraliza o conteúdo
        children: [
          Text(
            'Sua marca com identidade',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: isDesktop ? 48 : 32,
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
          SizedBox(height: isDesktop ? 20 : 15),
          Text(
            'Clareza, posicionamento e autenticidade: a ponte entre quem você é e como você é percebido.',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: isDesktop ? 18 : 16,
              color: Colors.white,
            ),
          ),
          SizedBox(height: isDesktop ? 60 : 40),
          // Estatísticas (85%, 3x, 92%) em cards
          isDesktop
              ? Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Expanded(
                      child: _buildStatCard(
                        '85%',
                        'dos profissionais com marca forte ganham mais',
                        height: 150,
                      ), // Altura fixa para desktop
                    ),
                    SizedBox(width: 40), // Espaçamento entre os cards
                    Expanded(
                      child: _buildStatCard(
                        '3x',
                        'mais oportunidades de negócio',
                        height: 150,
                      ), // Altura fixa para desktop
                    ),
                    SizedBox(width: 40), // Espaçamento entre os cards
                    Expanded(
                      child: _buildStatCard(
                        '92%',
                        'confiam em marcas autênticas',
                        height: 150,
                      ), // Altura fixa para desktop
                    ),
                  ],
                )
              : Wrap(
                  spacing: 20,
                  runSpacing: 20,
                  alignment: WrapAlignment.center,
                  children: [
                    SizedBox(
                      width: 200, // Largura fixa para mobile
                      height: 150, // Altura fixa para mobile
                      child: _buildStatCard(
                        '85%',
                        'dos profissionais com marca forte ganham mais',
                      ),
                    ),
                    SizedBox(
                      width: 200, // Largura fixa para mobile
                      height: 150, // Altura fixa para mobile
                      child: _buildStatCard(
                        '3x',
                        'mais oportunidades de negócio',
                      ),
                    ),
                    SizedBox(
                      width: 200, // Largura fixa para mobile
                      height: 150, // Altura fixa para mobile
                      child: _buildStatCard(
                        '92%',
                        'confiam em marcas autênticas',
                      ),
                    ),
                  ],
                ),
          SizedBox(height: isDesktop ? 60 : 40),
          // Botão "Descobrir Minha Marca"
          ElevatedButton(
            onPressed: () {
              // Abre o formulário de questionário
              _showQuestionnaireDialog(context);
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFFFF9800), // Laranja
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
            child: const Text('Descobrir minha marca'),
          ),
        ],
      ),
    );
  }

  Widget _buildStatCard(String value, String description, {double? height}) {
    return Container(
      height: height, // Altura opcional para padronização
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.1), // Fundo translúcido
        borderRadius: BorderRadius.circular(15),
        border: Border.all(color: Colors.white.withOpacity(0.2)),
      ),
      child: Column(
        mainAxisAlignment:
            MainAxisAlignment.center, // Centraliza o conteúdo verticalmente
        children: [
          Text(
            value,
            style: const TextStyle(
              fontSize: 36,
              fontWeight: FontWeight.bold,
              color: Colors.white,
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
          // Grid de benefícios
          GridView.builder(
            shrinkWrap: true,
            physics:
                const NeverScrollableScrollPhysics(), // Desabilita o scroll do GridView
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: isDesktop
                  ? 4
                  : (constraints.maxWidth > 600 ? 2 : 1),
              crossAxisSpacing: isDesktop ? 30 : 20,
              mainAxisSpacing: isDesktop ? 30 : 20,
              // Ajuste para manter a proporção em diferentes tamanhos, visando uma altura menor
              childAspectRatio: isDesktop
                  ? 1.3
                  : 1.1, // Aumentado para deixar os cards mais curtos
            ),
            itemCount: 4, // 4 itens de benefício
            itemBuilder: (context, index) {
              final List<Map<String, dynamic>> benefits = [
                {
                  'icon': Icons.emoji_events, // Ícone de coroa
                  'title': 'Autoridade no mercado',
                  'description': 'de reconhecimento profissional',
                  'highlight': '+150%',
                  'iconColor': const Color(0xFF1A237E), // Azul escuro
                  'iconBgColor': const Color(0xFFE3F2FD), // Azul claro
                },
                {
                  'icon': Icons.people_alt, // Ícone de atração de clientes
                  'title': 'Atração de clientes ideais',
                  'description': 'em qualidade de leads',
                  'highlight': '+200%',
                  'iconColor': const Color(0xFF0D47A1), // Azul médio
                  'iconBgColor': const Color(0xFFBBDEFB), // Azul mais claro
                },
                {
                  'icon': Icons.rocket_launch, // Ícone de foguete
                  'title': 'Crescimento acelerado',
                  'description': 'em oportunidades',
                  'highlight': '+300%',
                  'iconColor': const Color(0xFFFF9800), // Laranja
                  'iconBgColor': const Color(0xFFFFECB3), // Amarelo claro
                },
                {
                  'icon': Icons.security, // Ícone de escudo
                  'title': 'Proteção contra crises',
                  'description': 'de estabilidade',
                  'highlight': '+80%',
                  'iconColor': const Color(0xFF4CAF50), // Verde
                  'iconBgColor': const Color(0xFFDCEDC8), // Verde claro
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
                color: Color(0xFF1A237E), // Cor do destaque
              ),
            ),
            // Removendo o Expanded aqui para controlar a altura do texto
            Text(
              description,
              style: const TextStyle(fontSize: 15, color: Colors.black54),
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
            'Nossa Metodologia em 4 Etapas',
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
          // Itens da metodologia em linha para desktop, em coluna para mobile
          isDesktop
              ? Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    _buildMethodologyStep(
                      stepNumber: '01',
                      title: 'Descoberta Profunda',
                      description:
                          'Formulário estratégico para mapear sua essência, valores e diferenciais competitivos',
                      color: const Color(0xFF1A237E),
                    ),
                    _buildMethodologyStep(
                      stepNumber: '02',
                      title: 'Estratégia Personalizada',
                      description:
                          'Definição de nicho, proposta de valor única e plano de comunicação direcionado',
                      color: const Color(0xFF0D47A1),
                    ),
                    _buildMethodologyStep(
                      stepNumber: '03',
                      title: 'Implementação Guiada',
                      description:
                          'Ambientação digital, produção de conteúdo estratégico e networking direcionado',
                      color: const Color(0xFFFF9800),
                    ),
                    _buildMethodologyStep(
                      stepNumber: '04',
                      title: 'Resultados Mensuráveis',
                      description:
                          'Métricas de engajamento, análise de dados e otimização contínua',
                      color: const Color(0xFF4CAF50),
                    ),
                  ],
                )
              : Column(
                  children: [
                    _buildMethodologyStep(
                      stepNumber: '01',
                      title: 'Descoberta Profunda',
                      description:
                          'Formulário estratégico para mapear sua essência, valores e diferenciais competitivos',
                      color: const Color(0xFF1A237E),
                    ),
                    const SizedBox(height: 30),
                    _buildMethodologyStep(
                      stepNumber: '02',
                      title: 'Estratégia Personalizada',
                      description:
                          'Definição de nicho, proposta de valor única e plano de comunicação direcionado',
                      color: const Color(0xFF0D47A1),
                    ),
                    const SizedBox(height: 30),
                    _buildMethodologyStep(
                      stepNumber: '03',
                      title: 'Implementação Guiada',
                      description:
                          'Ambientação digital, produção de conteúdo estratégico e networking direcionado',
                      color: const Color(0xFFFF9800),
                    ),
                    const SizedBox(height: 30),
                    _buildMethodologyStep(
                      stepNumber: '04',
                      title: ' Resultados Mensuráveis',
                      description:
                          'Métricas de engajamento, análise de dados e otimização contínua',
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
      width: 200, // Largura fixa para cada passo da metodologia
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
            Color(0xFF0D47A1), // Azul médio
            Color(0xFF1A237E), // Azul escuro
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
          // Botão "Iniciar Minha Análise Gratuita"
          ElevatedButton(
            onPressed: () {
              // Abre o formulário de questionário
              _showQuestionnaireDialog(context);
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFFFF9800), // Laranja
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
      color: const Color(0xFF212121), // Cor de fundo escura para o rodapé
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
                    // Coluna IDENZZA
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
                    // Coluna Contato
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
                              Icon(
                                Icons.email,
                                color: Colors.white,
                                size: 18,
                              ),
                              SizedBox(width: 8),
                              Text(
                                'contato@idenzza.com.br',
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
                                Icons.phone,
                                color: Colors.white,
                                size: 18,
                              ),
                              SizedBox(width: 8),
                              Text(
                                '(11) 99999-9999',
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
                              Text(
                                'São Paulo, SP',
                                style: TextStyle(
                                  fontSize: 16,
                                  color: Colors.white,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    // Coluna Redes Sociais
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
                        Text(
                          'contato@idenzza.com.br',
                          style: TextStyle(fontSize: 16, color: Colors.white),
                        ),
                      ],
                    ),
                    const SizedBox(height: 5),
                    Row(
                      children: const [
                        Icon(Icons.phone, color: Colors.white, size: 18),
                        SizedBox(width: 8),
                        Text(
                          '(11) 99999-9999',
                          style: TextStyle(fontSize: 16, color: Colors.white),
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
                        Text(
                          'São Paulo, SP',
                          style: TextStyle(fontSize: 16, color: Colors.white),
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
          // Direitos autorais e crédito do desenvolvedor
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
                    // Tratar erro: não foi possível abrir a URL
                    print('Não foi possível abrir a URL: $url');
                  }
                },
                child: Text(
                  'Desenvolvido por C.Luan (github)',
                  style: TextStyle(
                    fontSize: isDesktop ? 14 : 12,
                    color: Colors.white54,
                    decoration: TextDecoration
                        .underline, // Sublinhado para indicar que é um link
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
        // TODO: Implementar a ação para as redes sociais
        print('$altText clicado!');
      },
      child: Container(
        width: 40,
        height: 40,
        decoration: BoxDecoration(
          color: Colors.blueAccent, // Cor de fundo para os ícones
          borderRadius: BorderRadius.circular(8),
        ),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Image.network(
            imageUrl,
            errorBuilder: (context, error, stackTrace) {
              return Icon(Icons.error, color: Colors.white); // Fallback icon
            },
          ),
        ),
      ),
    );
  }
}

// Widget para o diálogo do questionário
class QuestionnaireDialog extends StatefulWidget {
  const QuestionnaireDialog({super.key});

  @override
  State<QuestionnaireDialog> createState() => _QuestionnaireDialogState();
}

class _QuestionnaireDialogState extends State<QuestionnaireDialog> {
  final PageController _pageController = PageController();
  int _currentPage = 0;

  // GlobalKey para o formulário de cada página (para validação)
  final List<GlobalKey<FormState>> _formKeys = List.generate(
    5,
    (_) => GlobalKey<FormState>(),
  );

  // Controladores para os campos de texto de todas as perguntas
  final TextEditingController _fullNameController =
      TextEditingController(); // Q1
  final TextEditingController _professionController =
      TextEditingController(); // Q2
  final TextEditingController _brandSocialMediaController =
      TextEditingController(); // Q3
  final TextEditingController _threeWordsController =
      TextEditingController(); // Q4
  final TextEditingController _motivationController =
      TextEditingController(); // Q5
  final TextEditingController _storyController = TextEditingController(); // Q6

  final TextEditingController _rememberedByController =
      TextEditingController(); // Q7
  final TextEditingController _uniqueSellingPointController =
      TextEditingController(); // Q8
  final TextEditingController _clientComplimentsController =
      TextEditingController(); // Q9
  final TextEditingController _notAsBrandController =
      TextEditingController(); // Q10
  final TextEditingController _admiredBrandsProfessionalsController =
      TextEditingController(); // Q11

  final TextEditingController _idealClientController =
      TextEditingController(); // Q12
  final TextEditingController _clientProblemsController =
      TextEditingController(); // Q13
  final TextEditingController _clientSolutionSearchController =
      TextEditingController(); // Q14
  final TextEditingController _uniqueHelpController =
      TextEditingController(); // Q15
  final TextEditingController _consumedBrandsController =
      TextEditingController(); // Q16

  final TextEditingController _socialMediaPresenceController =
      TextEditingController(); // Q17
  final TextEditingController _publishFrequencyController =
      TextEditingController(); // Q18
  final TextEditingController _contentWorksBestController =
      TextEditingController(); // Q19
  String? _imageAlignmentAnswer; // Q20 (RadioListTile)
  final TextEditingController _admiredCommunicationBrandsController =
      TextEditingController(); // Q21

  final TextEditingController _repositioningGoalController =
      TextEditingController(); // Q22
  final TextEditingController _communicationChallengesController =
      TextEditingController(); // Q23
  final TextEditingController _ifRecognizedChangeController =
      TextEditingController(); // Q24
  final TextEditingController _brandAsSomethingController =
      TextEditingController(); // Q25
  double _brandPositioningScore = 6.0; // Q26 (Slider)

  // Map para armazenar todas as respostas
  final Map<String, dynamic> _answers = {};

  // Instância do Firestore
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

  // Função para avançar para a próxima página
  void _nextPage() {
    if (_formKeys[_currentPage].currentState!.validate()) {
      _formKeys[_currentPage].currentState!
          .save(); // Salva os dados do formulário
      if (_currentPage < 4) {
        // Total de 5 páginas (índice 0 a 4)
        _pageController.nextPage(
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeIn,
        );
      } else {
        // Última página, finalizar questionário
        _submitForm();
      }
    }
  }

  // Função para voltar para a página anterior
  void _previousPage() {
    if (_currentPage > 0) {
      _pageController.previousPage(
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeIn,
      );
    }
  }

  // Função para enviar o formulário para o Firestore
  void _submitForm() async {
    // Coleta todos os dados do formulário
    _answers['fullName'] = _fullNameController.text;
    _answers['profession'] = _professionController.text;
    _answers['brandSocialMedia'] = _brandSocialMediaController.text;
    _answers['threeWords'] = _threeWordsController.text;
    _answers['motivation'] = _motivationController.text;
    _answers['story'] = _storyController.text;

    _answers['rememberedBy'] = _rememberedByController.text;
    _answers['uniqueSellingPoint'] = _uniqueSellingPointController.text;
    _answers['clientCompliments'] = _clientComplimentsController.text;
    _answers['notAsBrand'] = _notAsBrandController.text;
    _answers['admiredBrandsProfessionals'] =
        _admiredBrandsProfessionalsController.text;

    _answers['idealClient'] = _idealClientController.text;
    _answers['clientProblems'] = _clientProblemsController.text;
    _answers['clientSolutionSearch'] = _clientSolutionSearchController.text;
    _answers['uniqueHelp'] = _uniqueHelpController.text;
    _answers['consumedBrands'] = _consumedBrandsController.text;

    _answers['socialMediaPresence'] = _socialMediaPresenceController.text;
    _answers['publishFrequency'] = _publishFrequencyController.text;
    _answers['contentWorksBest'] = _contentWorksBestController.text;
    _answers['imageAlignment'] = _imageAlignmentAnswer;
    _answers['admiredCommunicationBrands'] =
        _admiredCommunicationBrandsController.text;

    _answers['repositioningGoal'] = _repositioningGoalController.text;
    _answers['communicationChallenges'] =
        _communicationChallengesController.text;
    _answers['ifRecognizedChange'] = _ifRecognizedChangeController.text;
    _answers['brandAsSomething'] = _brandAsSomethingController.text;
    _answers['brandPositioningScore'] = _brandPositioningScore.round();

    // Obtém o ID do usuário atual (autenticado anonimamente ou com token)
    final String userId = FirebaseAuth.instance.currentUser?.uid ?? 'anonymous';

    try {
      // Salva os dados no Firestore

      await _firestore
          .collection('idenzza')
          .doc('responses')
          .collection('users')
          .doc(userId)
          .collection('questionnaires')
          .add({
            ..._answers, // Adiciona todas as respostas coletadas
            'timestamp':
                FieldValue.serverTimestamp(), // Adiciona um timestamp do servidor
            'userId': userId, // Adiciona o ID do usuário para referência
          });

      print('Formulário salvo com sucesso no Firestore!');
      // Você pode adicionar um AlertDialog de sucesso aqui
      // ignore: use_build_context_synchronously
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text('Sucesso!'),
            content: const Text('Seu formulário foi enviado com sucesso.'),
            actions: <Widget>[
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop(); // Fecha o AlertDialog
                  Navigator.of(context).pop(); // Fecha o formulário
                },
                child: const Text('OK'),
              ),
            ],
          );
        },
      );
    } catch (e) {
      print('Erro ao salvar o formulário no Firestore: $e');
      // Você pode adicionar um AlertDialog de erro aqui
      // ignore: use_build_context_synchronously
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text('Erro!'),
            content: Text('Ocorreu um erro ao enviar seu formulário: $e'),
            actions: <Widget>[
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop(); // Fecha o AlertDialog
                },
                child: const Text('OK'),
              ),
            ],
          );
        },
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Dialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      elevation: 10,
      child: Container(
        width:
            MediaQuery.of(context).size.width * 0.8, // 80% da largura da tela
        height:
            MediaQuery.of(context).size.height * 0.8, // 80% da altura da tela
        constraints: const BoxConstraints(
          maxWidth: 700,
          maxHeight: 750,
        ), // Limites para desktop
        child: Column(
          children: [
            // Cabeçalho do diálogo
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
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
                  IconButton(
                    icon: const Icon(Icons.close),
                    onPressed: () {
                      Navigator.of(context).pop(); // Fecha o diálogo
                    },
                  ),
                ],
              ),
            ),
            const Divider(height: 1, thickness: 1),
            // Conteúdo do formulário com PageView
            Expanded(
              child: PageView(
                controller: _pageController,
                physics:
                    const NeverScrollableScrollPhysics(), // Desabilita o arrastar entre as páginas
                onPageChanged: (index) {
                  setState(() {
                    _currentPage = index;
                  });
                },
                children: [
                  // Página 1: Identidade & Essência (Q1-6)
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
                        hintText:
                            'Designer especializada em transformação digital e estratégias de crescimento',
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
                      const SizedBox(height: 20),
                      _buildQuestionTitle(
                        '5. O que te motivou a iniciar essa carreira?',
                      ),
                      _buildTextField(
                        controller: _motivationController,
                        hintText:
                            'A paixão por ajudar pessoas a alcançarem seus objetivos...',
                        maxLines: 3,
                      ),
                      const SizedBox(height: 20),
                      _buildQuestionTitle(
                        '6. Existe alguma história marcante que resume sua essência profissional?',
                      ),
                      _buildTextField(
                        controller: _storyController,
                        hintText:
                            'Quando ajudei uma startup a crescer 300% em 6 meses...',
                        maxLines: 3,
                      ),
                    ],
                  ),
                  // Página 2: Percepção & Posicionamento (Q7-11)
                  _buildPage(
                    pageIndex: 1,
                    children: [
                      _buildQuestionTitle(
                        '7. Como você gostaria de ser lembrado(a) pelas pessoas?',
                      ),
                      _buildTextField(
                        controller: _rememberedByController,
                        hintText:
                            'Como alguém que transforma ideias em resultados concretos...',
                        maxLines: 3,
                      ),
                      const SizedBox(height: 20),
                      _buildQuestionTitle(
                        '8. Se você tivesse que se vender em 1 minuto, o que diria que só você faz?',
                      ),
                      _buildTextField(
                        controller: _uniqueSellingPointController,
                        hintText:
                            'Combino visão estratégica com execução prática, entregando resultados...',
                        maxLines: 3,
                      ),
                      const SizedBox(height: 20),
                      _buildQuestionTitle(
                        '9. O que seus clientes costumam elogiar mais em você?',
                      ),
                      _buildTextField(
                        controller: _clientComplimentsController,
                        hintText:
                            'Minha capacidade de simplificar o complexo e minha dedicação...',
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
                        hintText:
                            '@garyvee, @melrobbins, @simonsinekofficial - pela autenticidade e impacto',
                        maxLines: 3,
                      ),
                    ],
                  ),
                  // Página 3: Público-Alvo Ideal (Q12-16)
                  _buildPage(
                    pageIndex: 2,
                    children: [
                      _buildQuestionTitle(
                        '12. Quem é o seu cliente ideal? (idade, profissão, estilo de vida, rotina)',
                      ),
                      _buildTextField(
                        controller: _idealClientController,
                        hintText:
                            'Empreendedores entre 30-45 anos, donos de pequenas e médias empresas...',
                        maxLines: 3,
                      ),
                      const SizedBox(height: 20),
                      _buildQuestionTitle(
                        '13. Quais são os principais problemas, desejos ou dores que esse cliente tem?',
                      ),
                      _buildTextField(
                        controller: _clientProblemsController,
                        hintText:
                            'Falta de estratégia digital clara, dificuldade em converter leads...',
                        maxLines: 3,
                      ),
                      const SizedBox(height: 20),
                      _buildQuestionTitle(
                        '14. Onde ele(a) costuma buscar soluções antes de te encontrar? (Google, Instagram, indicação, YouTube etc.)',
                      ),
                      _buildTextField(
                        controller: _clientSolutionSearchController,
                        hintText:
                            'Google, LinkedIn, indicações de outros empresários, YouTube',
                        maxLines: 2,
                      ),
                      const SizedBox(height: 20),
                      _buildQuestionTitle(
                        '15. Como você ajuda essa pessoa de forma única?',
                      ),
                      _buildTextField(
                        controller: _uniqueHelpController,
                        hintText:
                            'Ofereço consultoria personalizada com foco em ROI e acompanhamento contínuo...',
                        maxLines: 3,
                      ),
                      const SizedBox(height: 20),
                      _buildQuestionTitle(
                        '16. Quais marcas, criadores de conteúdo ou perfis esse público consome ou admira? (Se possível, coloque links ou @s)',
                      ),
                      _buildTextField(
                        controller: _consumedBrandsController,
                        hintText:
                            '@sebrae, @endeavorbrasil, @startupbrasil, @exame',
                        maxLines: 3,
                      ),
                    ],
                  ),
                  // Página 4: Presença Digital & Comunicação (Q17-21)
                  _buildPage(
                    pageIndex: 3,
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
                        hintText:
                            'LinkedIn: diariamente, Instagram: 3x por semana, YouTube: semanalmente',
                        maxLines: 2,
                      ),
                      const SizedBox(height: 20),
                      _buildQuestionTitle(
                        '19. Que tipo de conteúdo funciona melhor com seu público hoje? (Ex: bastidores, dicas, vídeos, textos, reels, etc.)',
                      ),
                      _buildTextField(
                        controller: _contentWorksBestController,
                        hintText:
                            'Cases de sucesso, dicas práticas em vídeos curtos, bastidores de projetos',
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
                      const SizedBox(height: 20),
                      _buildQuestionTitle(
                        '21. Quais marcas ou pessoas você admira pela forma como se comunicam com o público? (Coloque os @s ou links que te inspiram)',
                      ),
                      _buildTextField(
                        controller: _admiredCommunicationBrandsController,
                        hintText:
                            '@apple, @nike, @patagonia - pela clareza e propósito bem definidos',
                        maxLines: 2,
                      ),
                    ],
                  ),
                  // Página 5: Objetivos e Direção & Expressão Criativa & Confirmação Final (Q22-26)
                  _buildPage(
                    pageIndex: 4,
                    children: [
                      _buildQuestionTitle(
                        '22. O que você gostaria de alcançar com o reposicionamento da sua marca pessoal?',
                      ),
                      _buildTextField(
                        controller: _repositioningGoalController,
                        hintText:
                            'Ser reconhecida como referência em transformação digital para PMEs no Brasil',
                        maxLines: 3,
                      ),
                      const SizedBox(height: 20),
                      _buildQuestionTitle(
                        '23. Quais são os maiores desafios que você enfrenta hoje na comunicação da sua marca?',
                      ),
                      _buildTextField(
                        controller: _communicationChallengesController,
                        hintText:
                            'Consistência entre plataformas e criação de conteúdo que gere engajamento real',
                        maxLines: 3,
                      ),
                      const SizedBox(height: 20),
                      _buildQuestionTitle(
                        '24. Se você já tivesse uma marca 100% alinhada e reconhecida, o que mudaria a partir de hoje?',
                      ),
                      _buildTextField(
                        controller: _ifRecognizedChangeController,
                        hintText:
                            'Teria mais seletividade nos projetos e poderia focar em clientes com maior potencial de impacto',
                        maxLines: 3,
                      ),
                      const SizedBox(height: 20),
                      _buildQuestionTitle(
                        '25. Se sua marca fosse uma música, uma cor ou uma cidade, qual seria? (Responda com o que vier à mente. Não existe certo ou errado.)',
                      ),
                      _buildTextField(
                        controller: _brandAsSomethingController,
                        hintText:
                            'Música: "Stronger" - Kelly Clarkson, Cor: Azul royal, Cidade: São Paulo',
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
            // Botões de navegação
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
                      backgroundColor: const Color(0xFF0D47A1), // Azul médio
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
                      _currentPage == 4 ? 'Finalizar Questionário' : 'Próximo',
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

  // Widget auxiliar para criar cada página do formulário
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

  // Widget auxiliar para criar campos de texto
  Widget _buildTextField({
    required TextEditingController controller,
    String labelText =
        '', // LabelText agora é opcional, pois o título da pergunta é separado
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
        labelText: labelText.isNotEmpty
            ? labelText
            : null, // Só mostra label se não for vazio
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

  // Widget auxiliar para títulos de perguntas
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
