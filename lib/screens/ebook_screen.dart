import 'package:flutter/material.dart';
import 'package:flutter_cached_pdfview/flutter_cached_pdfview.dart';

class EbookScreen extends StatefulWidget {
  const EbookScreen({super.key});

  @override
  State<EbookScreen> createState() => _EbookScreenState();
}

class _EbookScreenState extends State<EbookScreen> {
  String? selectedPdf;

  final List<Map<String, String>> pdfList = [
    {'name': 'Thinking Straight', 'path': 'assets/pdfs/Book1.pdf'},
    {'name': 'Law Of Attraction', 'path': 'assets/pdfs/Book2.pdf'},
    {'name': 'Power of subsconsious mind', 'path': 'assets/pdfs/Book3.pdf'},
    {'name': 'As A man thinks', 'path': 'assets/pdfs/Book4.pdf'},
    {'name': 'SelfHelp is a art', 'path': 'assets/pdfs/Book5.pdf'},
    {'name': 'The Power of Now', 'path': 'assets/pdfs/Book6.pdf'},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[50],
      appBar: AppBar(
        title: Text(
          selectedPdf != null ? 'PDF Viewer' : 'Ebooks Collection',
          style: const TextStyle(
            fontWeight: FontWeight.w600,
            color: Colors.white,
            fontSize: 20,
          ),
        ),
        centerTitle: true,
        flexibleSpace: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                Color(0xFF7E57C2), // Deep Purple 400
                Color(0xFF673AB7), // Deep Purple 500
              ],
            ),
          ),
        ),
        elevation: 0,
        leading:
            selectedPdf != null
                ? IconButton(
                  icon: const Icon(Icons.arrow_back_ios, color: Colors.white),
                  onPressed: () {
                    setState(() {
                      selectedPdf = null;
                    });
                  },
                )
                : null,
        actions:
            selectedPdf == null
                ? [
                  IconButton(
                    icon: const Icon(Icons.search, color: Colors.white),
                    onPressed: () {
                      // Search functionality can be added here
                    },
                  ),
                ]
                : null,
      ),
      body:
          selectedPdf != null
              ? const PDF(
                enableSwipe: true,
                swipeHorizontal: false,
                autoSpacing: true,
                pageFling: true,
                pageSnap: true,
                nightMode: false,
              ).fromAsset(selectedPdf!)
              : Container(
                decoration: const BoxDecoration(color: Colors.white),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      padding: const EdgeInsets.fromLTRB(20, 24, 20, 16),
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          begin: Alignment.centerLeft,
                          end: Alignment.centerRight,
                          colors: [Colors.white, const Color(0xFFF3E5F5)],
                        ),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.1),
                            blurRadius: 8,
                            offset: const Offset(0, 3),
                          ),
                        ],
                      ),
                      child: Row(
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                children: [
                                  Container(
                                    height: 24,
                                    width: 4,
                                    decoration: BoxDecoration(
                                      color: const Color(0xFF9C27B0),
                                      borderRadius: BorderRadius.circular(2),
                                    ),
                                  ),
                                  const SizedBox(width: 12),
                                  const Text(
                                    'Discover',
                                    style: TextStyle(
                                      fontSize: 28,
                                      fontWeight: FontWeight.bold,
                                      color: Color(0xFF6A1B9A),
                                      letterSpacing: 0.5,
                                      fontFamily: 'Georgia',
                                    ),
                                  ),
                                ],
                              ),
                              const Padding(
                                padding: EdgeInsets.only(left: 16),
                                child: Text(
                                  'Premium Collection',
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.w500,
                                    color: Color(0xFF9575CD),
                                    fontStyle: FontStyle.italic,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          const Spacer(),
                          Container(
                            padding: const EdgeInsets.all(8),
                            decoration: BoxDecoration(
                              color: const Color(0xFFEDE7F6),
                              borderRadius: BorderRadius.circular(12),
                            ),
                            child: const Icon(
                              Icons.auto_stories,
                              color: Color(0xFF7B1FA2),
                              size: 28,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        child: GridView.builder(
                          padding: const EdgeInsets.only(bottom: 20),
                          gridDelegate:
                              const SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 2,
                                childAspectRatio: 0.7,
                                crossAxisSpacing: 16,
                                mainAxisSpacing: 20,
                              ),
                          itemCount: pdfList.length,
                          itemBuilder: (context, index) {
                            final pdf = pdfList[index];
                            return Material(
                              elevation: 2,
                              shadowColor: Colors.grey.withOpacity(0.3),
                              borderRadius: BorderRadius.circular(12),
                              color: Colors.transparent,
                              child: InkWell(
                                borderRadius: BorderRadius.circular(12),
                                onTap: () {
                                  setState(() {
                                    selectedPdf = pdf['path'];
                                  });
                                },
                                child: Container(
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(12),
                                    color: Colors.white,
                                  ),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Container(
                                        height: 140,
                                        decoration: BoxDecoration(
                                          borderRadius: const BorderRadius.only(
                                            topLeft: Radius.circular(12),
                                            topRight: Radius.circular(12),
                                          ),
                                          color: Color.lerp(
                                            const Color(0xFFE1BEE7),
                                            const Color(0xFFD1C4E9),
                                            index % 2 == 0 ? 0.5 : 0.0,
                                          ),
                                        ),
                                        child: Center(
                                          child: Icon(
                                            Icons.book,
                                            size: 50,
                                            color: const Color(0xFF673AB7),
                                          ),
                                        ),
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.fromLTRB(
                                          16,
                                          16,
                                          16,
                                          8,
                                        ),
                                        child: Text(
                                          pdf['name']!,
                                          style: const TextStyle(
                                            fontWeight: FontWeight.w600,
                                            fontSize: 16,
                                            color: Color(0xFF4A148C),
                                            height: 1.2,
                                          ),
                                          maxLines: 2,
                                          overflow: TextOverflow.ellipsis,
                                        ),
                                      ),
                                      const Spacer(),
                                      Padding(
                                        padding: const EdgeInsets.fromLTRB(
                                          16,
                                          0,
                                          16,
                                          16,
                                        ),
                                        child: TextButton(
                                          onPressed: () {
                                            setState(() {
                                              selectedPdf = pdf['path'];
                                            });
                                          },
                                          style: TextButton.styleFrom(
                                            backgroundColor: const Color(
                                              0xFF673AB7,
                                            ),
                                            minimumSize: const Size(
                                              double.infinity,
                                              40,
                                            ),
                                            shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(8),
                                            ),
                                            padding: EdgeInsets.zero,
                                          ),
                                          child: const Text(
                                            'Read Now',
                                            style: TextStyle(
                                              color: Colors.white,
                                              fontWeight: FontWeight.w500,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                    ),
                  ],
                ),
              ),
    );
  }
}
