import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import '../models/transaction.dart';
import '../widgets/atm_card.dart';
import '../widgets/grid_menu_item.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> with TickerProviderStateMixin {
  final PageController _pageController = PageController(viewportFraction: 0.86);
  late ScrollController _scrollController;
  final TextEditingController _searchController = TextEditingController();

  int _page = 0;
  int _selectedIndex = 0;
  bool isScrolled = false;

  late AnimationController _fadeController;
  late AnimationController _gridController;

  Color appBarColor = const Color(0xFF1B5E20);
  Color iconColor = Colors.white;

  final List<Map<String, dynamic>> cards = [
    {
      'bank': 'Bank BCA',
      'number': '**** 2345',
      'balance': 'Rp12.500.000',
      'c1': const Color(0xFF1B5E20),
      'c2': const Color(0xFF66BB6A),
    },
    {
      'bank': 'Bank BRI',
      'number': '**** 8765',
      'balance': 'Rp5.350.000',
      'c1': const Color(0xFF2E7D32),
      'c2': const Color(0xFF81C784),
    },
    {
      'bank': 'Bank BNI',
      'number': '**** 8910',
      'balance': 'Rp2.125.000',
      'c1': const Color(0xFF43A047),
      'c2': const Color(0xFF9CCC65),
    },
    {
      'bank': 'Bank Mandiri',
      'number': '**** 1112',
      'balance': 'Rp800.000',
      'c1': const Color(0xFF689F38),
      'c2': const Color(0xFFAED581),
    },
  ];

  final List<TransactionModel> transactions = [
    TransactionModel(
      title: 'Coffee Shop',
      category: 'Food',
      amount: '-Rp35.000',
      date: DateTime.now().subtract(const Duration(hours: 5)),
    ),
    TransactionModel(
      title: 'Grab Ride',
      category: 'Travel',
      amount: '-Rp25.000',
      date: DateTime.now().subtract(const Duration(hours: 10)),
    ),
    TransactionModel(
      title: 'Gym Membership',
      category: 'Health',
      amount: '-Rp150.000',
      date: DateTime.now().subtract(const Duration(days: 1)),
    ),
    TransactionModel(
      title: 'Movie Ticket',
      category: 'Event',
      amount: '-Rp60.000',
      date: DateTime.now().subtract(const Duration(days: 2)),
    ),
    TransactionModel(
      title: 'Salary',
      category: 'Income',
      amount: '+Rp5.000.000',
      date: DateTime.now().subtract(const Duration(days: 3)),
    ),
  ];

  List<TransactionModel> filteredTransactions = [];

  @override
  void initState() {
    super.initState();
    filteredTransactions = transactions;

    _scrollController = ScrollController();
    _scrollController.addListener(_scrollListener);

    _fadeController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 800),
    )..forward();
    _gridController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 900),
    )..forward();

    _pageController.addListener(() {
      int newPage = _pageController.page?.round() ?? 0;
      if (newPage != _page) setState(() => _page = newPage);
    });

    _searchController.addListener(_filterTransactions);
  }

  void _filterTransactions() {
    String query = _searchController.text.toLowerCase();
    setState(() {
      filteredTransactions = transactions
          .where((t) => t.title.toLowerCase().contains(query))
          .toList();
    });
  }

  void _scrollListener() {
    if (_scrollController.offset > 40 && !isScrolled) {
      setState(() {
        isScrolled = true;
        appBarColor = const Color(0xFF81C784);
        iconColor = const Color(0xFF1B5E20);
      });
    } else if (_scrollController.offset <= 40 && isScrolled) {
      setState(() {
        isScrolled = false;
        appBarColor = const Color(0xFF1B5E20);
        iconColor = Colors.white;
      });
    }
  }

  @override
  void dispose() {
    _scrollController.dispose();
    _pageController.dispose();
    _fadeController.dispose();
    _gridController.dispose();
    _searchController.dispose();
    super.dispose();
  }

  void _onNavTap(int index) => setState(() => _selectedIndex = index);

  IconData _getCategoryIcon(String category) {
    switch (category) {
      case 'Food':
        return Icons.fastfood;
      case 'Travel':
        return Icons.airplanemode_active;
      case 'Health':
        return Icons.health_and_safety;
      case 'Event':
        return Icons.local_activity;
      case 'Income':
        return Icons.attach_money;
      default:
        return Icons.category;
    }
  }

  Widget _buildIndicator() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: List.generate(cards.length, (index) {
        bool active = index == _page;
        return AnimatedContainer(
          duration: const Duration(milliseconds: 300),
          margin: const EdgeInsets.symmetric(horizontal: 4),
          width: active ? 18 : 8,
          height: 8,
          decoration: BoxDecoration(
            color: active ? const Color(0xFF1B5E20) : Colors.grey.shade300,
            borderRadius: BorderRadius.circular(8),
          ),
        );
      }),
    );
  }

  Widget _build3DCard(int index) {
    double value = 0;
    try {
      value = _pageController.page! - index;
    } catch (_) {}
    value = (value).clamp(-1, 1);
    double scale = 1 - (value.abs() * 0.15);
    double angle = value * 0.2;

    final card = cards[index];

    return Transform(
      alignment: Alignment.center,
      transform: Matrix4.identity()
        ..setEntry(3, 2, 0.001)
        ..rotateY(angle)
        ..scale(scale),
      child: Opacity(
        opacity: 1 - value.abs() * 0.3,
        child: AtmCard(
          bankName: card['bank'],
          cardNumber: card['number'],
          balance: card['balance'],
          color1: card['c1'],
          color2: card['c2'],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      backgroundColor: const Color(0xFFF9FFF9),
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(kToolbarHeight),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 350),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: isScrolled
                  ? [const Color(0xFF81C784), const Color(0xFFB9F6CA)]
                  : [const Color(0xFF1B5E20), const Color(0xFF4CAF50)],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
          ),
          child: SafeArea(
            child: AppBar(
              backgroundColor: Colors.transparent,
              elevation: isScrolled ? 4 : 0,
              centerTitle: false,
              title: Text(
                'Finance App',
                style: GoogleFonts.poppins(
                  color: iconColor,
                  fontWeight: FontWeight.w700,
                ),
              ),
              actions: [
                IconButton(
                  icon: Icon(
                    Icons.notifications_none_rounded,
                    color: iconColor,
                  ),
                  onPressed: () {},
                ),
                Padding(
                  padding: const EdgeInsets.only(right: 12.0),
                  child: CircleAvatar(
                    radius: 16,
                    backgroundImage: const AssetImage(
                      'assets/images/nunuy.jpg',
                    ),
                    backgroundColor: Colors.transparent,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        backgroundColor: const Color(0xFF43A047),
        child: const Icon(Icons.qr_code_rounded),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedIndex,
        onTap: _onNavTap,
        selectedItemColor: const Color(0xFF1B5E20),
        unselectedItemColor: Colors.grey,
        showUnselectedLabels: true,
        selectedLabelStyle: GoogleFonts.poppins(fontWeight: FontWeight.w600),
        unselectedLabelStyle: GoogleFonts.poppins(),
        type: BottomNavigationBarType.fixed,
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'Beranda'),
          BottomNavigationBarItem(
            icon: Icon(Icons.list_alt_rounded),
            label: 'Mutasi',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.local_activity_rounded),
            label: 'Aktivitas',
          ),
          BottomNavigationBarItem(icon: Icon(Icons.person), label: 'Profile'),
        ],
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          controller: _scrollController,
          physics: const BouncingScrollPhysics(),
          padding: const EdgeInsets.only(bottom: 100),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 12),
              FadeTransition(
                opacity: _fadeController,
                child: Card(
                  elevation: 3,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
                  color: const Color(0xFFE8F5E9),
                  margin: const EdgeInsets.symmetric(horizontal: 12),
                  child: Padding(
                    padding: const EdgeInsets.all(20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Halo, Nunuy Hasanah 👋',
                          style: GoogleFonts.poppins(
                            fontSize: 18,
                            fontWeight: FontWeight.w600,
                            color: const Color(0xFF1B5E20),
                          ),
                        ),
                        const SizedBox(height: 8),
                        Row(
                          children: const [
                            Icon(
                              Icons.account_balance_wallet_outlined,
                              color: Color(0xFF1B5E20),
                              size: 18,
                            ),
                            SizedBox(width: 6),
                            Text(
                              'Total Saldo',
                              style: TextStyle(color: Colors.black54),
                            ),
                          ],
                        ),
                        const SizedBox(height: 4),
                        Text(
                          'Rp20.775.000',
                          style: GoogleFonts.poppins(
                            fontSize: 26,
                            fontWeight: FontWeight.bold,
                            color: Color(0xFF1B5E20),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 20),

              // ATM Card
              SizedBox(
                height: 190,
                child: PageView.builder(
                  controller: _pageController,
                  itemCount: cards.length,
                  itemBuilder: (context, index) => _build3DCard(index),
                ),
              ),
              const SizedBox(height: 10),
              _buildIndicator(),
              const SizedBox(height: 16),

              // Search Bar with green outline
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 12),
                child: TextField(
                  controller: _searchController,
                  decoration: InputDecoration(
                    hintText: 'Cari transaksi...',
                    prefixIcon: const Icon(
                      Icons.search,
                      color: Color(0xFF1B5E20),
                    ),
                    filled: true,
                    fillColor: Colors.white,
                    contentPadding: const EdgeInsets.symmetric(
                      vertical: 0,
                      horizontal: 16,
                    ),
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(16),
                      borderSide: const BorderSide(
                        color: Color(0xFF1B5E20),
                        width: 2,
                      ),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(16),
                      borderSide: const BorderSide(
                        color: Color(0xFF1B5E20),
                        width: 2,
                      ),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(16),
                      borderSide: const BorderSide(
                        color: Color(0xFF1B5E20),
                        width: 2,
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 20),

              // Grid Menu
              ScaleTransition(
                scale: CurvedAnimation(
                  parent: _gridController,
                  curve: Curves.easeOutBack,
                ),
                child: Card(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20),
                  ),
                  elevation: 3,
                  margin: const EdgeInsets.symmetric(horizontal: 12),
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: GridView.count(
                      crossAxisCount: 3,
                      crossAxisSpacing: 14,
                      mainAxisSpacing: 14,
                      shrinkWrap: true,
                      physics: const NeverScrollableScrollPhysics(),
                      children: const [
                        GridMenuItem(
                          icon: Icons.send_rounded,
                          label: 'Transfer',
                        ),
                        GridMenuItem(
                          icon: Icons.payment_rounded,
                          label: 'Top Up',
                        ),
                        GridMenuItem(
                          icon: Icons.health_and_safety,
                          label: 'Health',
                        ),
                        GridMenuItem(
                          icon: Icons.airplanemode_active,
                          label: 'Travel',
                        ),
                        GridMenuItem(icon: Icons.fastfood, label: 'Food'),
                        GridMenuItem(icon: Icons.more_horiz, label: 'Lainnya'),
                      ],
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 20),

              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 12),
                child: Text(
                  'Transaksi Terakhir',
                  style: TextStyle(fontSize: 17, fontWeight: FontWeight.w700),
                ),
              ),
              const SizedBox(height: 8),

              // Transaction List
              AnimatedBuilder(
                animation: _fadeController,
                builder: (context, child) {
                  return Column(
                    children: filteredTransactions.map((t) {
                      return Card(
                        elevation: 1,
                        margin: const EdgeInsets.symmetric(
                          vertical: 4,
                          horizontal: 12,
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: ListTile(
                          contentPadding: const EdgeInsets.symmetric(
                            horizontal: 16,
                            vertical: 8,
                          ),
                          leading: CircleAvatar(
                            backgroundColor: const Color(0xFFE8F5E9),
                            child: Icon(
                              _getCategoryIcon(t.category),
                              color: const Color(0xFF1B5E20),
                            ),
                          ),
                          title: Text(
                            t.title,
                            style: GoogleFonts.poppins(
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          subtitle: Text(
                            t.category,
                            style: GoogleFonts.poppins(
                              fontSize: 12,
                              color: Colors.black54,
                            ),
                          ),
                          trailing: Text(
                            t.amount,
                            style: GoogleFonts.poppins(
                              color: t.amount.startsWith('-')
                                  ? Colors.red
                                  : const Color(0xFF1B5E20),
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      );
                    }).toList(),
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
