import 'package:flutter/material.dart';

class SearchBar extends StatefulWidget {
  final String searchQuery;
  final Function(String) onSearchChanged;
  final VoidCallback onClearSearch;

  const SearchBar({
    super.key,
    required this.searchQuery,
    required this.onSearchChanged,
    required this.onClearSearch,
  });

  @override
  State<SearchBar> createState() => _SearchBarState();
}

class _SearchBarState extends State<SearchBar>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;
  late Animation<double> _pulseAnimation;
  late FocusNode _focusNode;
  bool _isFocused = false;

  @override
  void initState() {
    super.initState();
    _focusNode = FocusNode();
    _focusNode.addListener(_handleFocusChange);

    _animationController = AnimationController(
      duration: const Duration(milliseconds: 1500),
      vsync: this,
    );

    _pulseAnimation = Tween<double>(begin: 1.0, end: 1.1).animate(
      CurvedAnimation(parent: _animationController, curve: Curves.easeInOut),
    );

    _animationController.repeat(reverse: true);
  }

  void _handleFocusChange() {
    setState(() {
      _isFocused = _focusNode.hasFocus;
    });
  }

  @override
  void dispose() {
    _animationController.dispose();
    _focusNode.removeListener(_handleFocusChange);
    _focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final primaryColor = theme.colorScheme.primary;
    final secondaryColor = theme.colorScheme.secondary;

    return Container(
      margin: const EdgeInsets.fromLTRB(16, 16, 16, 16),
      child: Stack(
        children: [
          // Background container with animated gradient
          AnimatedContainer(
            duration: const Duration(milliseconds: 300),
            height: 60,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors:
                    _isFocused
                        ? [
                          primaryColor.withOpacity(0.12),
                          secondaryColor.withOpacity(0.15),
                        ]
                        : [
                          primaryColor.withOpacity(0.05),
                          secondaryColor.withOpacity(0.1),
                        ],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              borderRadius: BorderRadius.circular(30),
              boxShadow: [
                BoxShadow(
                  color:
                      _isFocused
                          ? primaryColor.withOpacity(0.15)
                          : Colors.black.withOpacity(0.05),
                  blurRadius: _isFocused ? 15 : 10,
                  spreadRadius: _isFocused ? 2 : 0,
                  offset: const Offset(0, 4),
                ),
              ],
            ),
          ),

          // Actual search field
          ClipRRect(
            borderRadius: BorderRadius.circular(30),
            child: TextField(
              focusNode: _focusNode,
              style: TextStyle(
                color: Colors.grey[800],
                fontWeight: FontWeight.w500,
                fontSize: 16,
              ),
              decoration: InputDecoration(
                hintText: 'Find your perfect melody...',
                hintStyle: TextStyle(
                  color: Colors.grey[500],
                  fontStyle: FontStyle.italic,
                  fontSize: 14,
                ),
                prefixIcon: AnimatedBuilder(
                  animation: _pulseAnimation,
                  builder: (context, child) {
                    return Container(
                      padding: const EdgeInsets.all(12),
                      child: ScaleTransition(
                        scale:
                            widget.searchQuery.isEmpty
                                ? _pulseAnimation
                                : const AlwaysStoppedAnimation(1.0),
                        child: Icon(
                          Icons.search_rounded,
                          color:
                              _isFocused
                                  ? primaryColor
                                  : primaryColor.withOpacity(0.7),
                          size: 24,
                        ),
                      ),
                    );
                  },
                ),
                suffixIcon:
                    widget.searchQuery.isNotEmpty
                        ? AnimatedContainer(
                          duration: const Duration(milliseconds: 200),
                          margin: const EdgeInsets.all(8),
                          decoration: BoxDecoration(
                            color:
                                _isFocused
                                    ? primaryColor.withOpacity(0.15)
                                    : Colors.grey[200],
                            shape: BoxShape.circle,
                          ),
                          child: InkWell(
                            borderRadius: BorderRadius.circular(30),
                            onTap: widget.onClearSearch,
                            child: Icon(
                              Icons.clear_rounded,
                              color: primaryColor,
                              size: 20,
                            ),
                          ),
                        )
                        : null,
                border: InputBorder.none,
                filled: true,
                fillColor: Colors.white.withOpacity(0.92),
                contentPadding: const EdgeInsets.symmetric(
                  horizontal: 20,
                  vertical: 16,
                ),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30),
                  borderSide: BorderSide(
                    color: primaryColor.withOpacity(0.1),
                    width: 1.5,
                  ),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(30),
                  borderSide: BorderSide(
                    color: primaryColor.withOpacity(0.7),
                    width: 2,
                  ),
                ),
              ),
              cursorColor: primaryColor,
              cursorWidth: 2,
              cursorRadius: const Radius.circular(2),
              onChanged: widget.onSearchChanged,
            ),
          ),

          // Search count indicator (if search has results)
          if (widget.searchQuery.isNotEmpty)
            Positioned(
              right: 60,
              top: 8,
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                decoration: BoxDecoration(
                  color: primaryColor,
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Text(
                  'Search',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 10,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
        ],
      ),
    );
  }
}
