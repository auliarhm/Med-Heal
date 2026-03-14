import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:medical/Screens/Views/Homepage.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:page_transition/page_transition.dart';

class Article {
  final String id;
  final String judul;
  final String isi;
  final Timestamp tanggal;
  final String kategori;
  final Map<String, String>? gambar;
  final Map<String, String>? sumber;

  Article({
    required this.id,
    required this.judul,
    required this.isi,
    required this.tanggal,
    required this.kategori,
    this.gambar,
    this.sumber,
  });

  factory Article.fromJson(Map<String, dynamic> json) {
    return Article(
      id: json['id'] ?? '',
      judul: json['judul'] ?? 'Default Judul',
      isi: json['isi'] ?? '',
      tanggal: json['tanggal'] as Timestamp,
      kategori: json['kategori'] ?? 'Uncategorized',
      gambar: json['gambar'] != null ? Map<String, String>.from(json['gambar']) : null,
      sumber: json['sumber'] != null ? Map<String, String>.from(json['sumber']) : null,
    );
  }
}

Future<List<Article>> fetchArtikel() async {
  try {
    final firestore = FirebaseFirestore.instance;
    final articleRef = firestore.collection('artikel');
    final artikelSnapshot = await articleRef.get();

    print("Fetched articles count: ${artikelSnapshot.docs.length}");

    return artikelSnapshot.docs.map((doc) {
      var data = doc.data();
      return Article.fromJson(data);
    }).toList();
  } catch (e) {
    print("Error fetching artikel: $e");
    return [];
  }
}

class ArticlePage extends StatefulWidget {
  const ArticlePage({Key? key}) : super(key: key);

  @override
  _ArticlePageState createState() => _ArticlePageState();
}

class _ArticlePageState extends State<ArticlePage> {
  List<Article> artikel = [];
  List<Article> filteredArtikel = [];
  TextEditingController searchController = TextEditingController();
  FocusNode focusNode = FocusNode();

  @override
  void dispose() {
    searchController.dispose();
    focusNode.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    fetchArtikel().then((fetchedArtikel) {
      setState(() {
        artikel = fetchedArtikel;
        filteredArtikel = fetchedArtikel;
      });
    });

    searchController.addListener(() {
      filterArtikel(searchController.text);
    });
  }

  void filterArtikel(String query) {
    final filtered = artikel.where((article) {
      return article.judul.toLowerCase().contains(query.toLowerCase()) ||
          article.isi.toLowerCase().contains(query.toLowerCase());
    }).toList();

    setState(() {
      filteredArtikel = filtered;
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: _buildAppBar(context),
        backgroundColor: Colors.white,
        body: SingleChildScrollView(
          child: Column(
            children: [
              const SizedBox(height: 10),
              _buildSearchBar(context),
              const SizedBox(height: 15),
              _buildSectionTitle("Popular Artikel"),
              _buildArtikelList(filteredArtikel),
              const SizedBox(height: 20),
              _buildSectionTitle("Trending Artikel"),
              _buildArtikelList(filteredArtikel.where((article) => article.kategori == 'Trending').toList()),
              const SizedBox(height: 20),
              _buildSectionTitle("Related Artikel"),
              _buildArtikelList(filteredArtikel.where((article) => article.kategori == 'Related').toList()),
            ],
          ),
        ),
      ),
    );
  }

  AppBar _buildAppBar(BuildContext context) {
    return AppBar(
      backgroundColor: const Color(0xFF40BEF0),
      title: Text(
        "Artikel",
        style: GoogleFonts.poppins(
          fontSize: 20,
          color: Colors.white,
          fontWeight: FontWeight.w600,
        ),
      ),
      centerTitle: true,
      toolbarHeight: 80,
      elevation: 0,
      leading: IconButton(
        icon: SizedBox(
          height: MediaQuery.of(context).size.height * 0.06,
          width: MediaQuery.of(context).size.width * 0.06,
          child: Image.asset("lib/icons/back2.png"),
        ),
        onPressed: () {
          Navigator.pushReplacement(
            context,
            PageTransition(
              type: PageTransitionType.rightToLeft,
              child: const Homepage(),
            ),
          );
        },
      ),
    );
  }

  Widget _buildSearchBar(BuildContext context) {
    return Center(
      child: SizedBox(
        height: 45,
        width: MediaQuery.of(context).size.width * 0.85,
        child: TextField(
          controller: searchController,
          focusNode: focusNode,
          decoration: InputDecoration(
            fillColor: const Color(0xFFF1F1F1),
            filled: true,
            prefixIcon: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Image.asset('lib/icons/search.png', height: 12, width: 12),
            ),
            labelText: "Cari Artikel",
            border: OutlineInputBorder(
              borderSide: BorderSide.none,
              borderRadius: BorderRadius.circular(50),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildSectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Row(
        children: [
          Text(
            title,
            style: GoogleFonts.poppins(fontSize: 14, fontWeight: FontWeight.w600, color: const Color(0xFF40BEF0)),
          ),
        ],
      ),
    );
  }

  Widget _buildArtikelList(List<Article> articles) {
    return ListView.builder(
      physics: const NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      itemCount: articles.length,
      itemBuilder: (context, index) {
        final article = articles[index];
        return _buildArtikelCard(article);
      },
    );
  }

  Widget _buildArtikelCard(Article article) {
    String? imageUrl = article.gambar?['url'];
    String? articleUrl = article.sumber?['sumber'];

    return GestureDetector(
      onTap: () async {
        if (articleUrl != null && articleUrl.isNotEmpty) {
          try {
            final Uri sumber = Uri.parse(articleUrl);
            if (await canLaunchUrl(sumber)) {
              await launchUrl(sumber, mode: LaunchMode.externalApplication);
            } else {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text('Tidak dapat membuka URL: $articleUrl')),
              );
            }
          } catch (e) {
            ScaffoldMessenger.of(context).showSnackBar(
              SnackBar(content: Text('Gagal membuka URL: $articleUrl')),
            );
          }
        }
      },
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 8, vertical: 5),
        padding: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(8),
          border: Border.all(color: Colors.grey.shade300),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: imageUrl != null && imageUrl.isNotEmpty
                  ? Image.network(
                      imageUrl,
                      width: 150, // Increased image size
                      height: 100,
                      fit: BoxFit.cover,
                    )
                  : const Icon(Icons.article, size: 80, color: Colors.grey),
            ),
            const SizedBox(width: 10),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    article.judul,
                    style: GoogleFonts.poppins(fontSize: 12, fontWeight: FontWeight.w600), // Smaller text
                  ),
                  const SizedBox(height: 5),
                  Text(
                    article.isi,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: GoogleFonts.poppins(fontSize: 10, color: Colors.grey), // Smaller text
                  ),
                  const SizedBox(height: 5),
                  Text(
                    'Kategori: ${article.kategori}',
                    style: GoogleFonts.poppins(fontSize: 8, color: Colors.grey), // Smaller text
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
