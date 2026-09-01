// lib/views/home_view.dart
//
// Katman: VIEW
// Sorumluluğu: Sadece Controller'daki reaktif state'i (Obx) dinleyip ekrana
// basmak. Burada setState YOKTUR, network çağrısı YOKTUR, iş mantığı YOKTUR.
// Renkler HER ZAMAN Theme.of(context) üzerinden okunur (Colors.black /
// Colors.white gibi hardcoded değerler kesinlikle kullanılmaz).

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/product_controller.dart';
import '../controllers/theme_controller.dart';
import 'promo_banner.dart';

class HomeView extends GetView<ProductController> {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final themeController = Get.find<ThemeController>();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Dinamik Vitrin'),
        actions: [
          Obx(
            () => IconButton(
              icon: Icon(
                themeController.isDarkMode.value ? Icons.light_mode : Icons.dark_mode,
              ),
              onPressed: themeController.toggleTheme,
              tooltip: themeController.isDarkMode.value ? 'Açık moda geç' : 'Koyu moda geç',
            ),
          ),
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: controller.refreshProducts,
            tooltip: 'Yenile',
          ),
        ],
      ),
      body: Column(
        children: [
          // Aşama 3: İçeriği koda gömülü olmayan, Remote Config'ten gelen banner.
          const PromoBanner(),
          Expanded(child: _ProductGrid(theme: theme)),
        ],
      ),
    );
  }
}

class _ProductGrid extends GetView<ProductController> {
  const _ProductGrid({required this.theme});
  final ThemeData theme;

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      if (controller.isLoading.value) {
        return const Center(child: CircularProgressIndicator());
      }
      if (controller.hasError.value) {
        return _ErrorState(theme: theme, onRetry: controller.refreshProducts);
      }
      if (controller.products.isEmpty) {
        return _EmptyState(theme: theme);
      }
      return GridView.builder(
        padding: const EdgeInsets.all(12),
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio: 0.62,
          crossAxisSpacing: 12,
          mainAxisSpacing: 12,
        ),
        itemCount: controller.products.length,
        itemBuilder: (context, index) {
          final product = controller.products[index];
          return _ProductCard(theme: theme, title: product.title, price: product.price, imageUrl: product.image, category: product.category);
        },
      );
    });
  }
}

class _ProductCard extends StatelessWidget {
  const _ProductCard({
    required this.theme,
    required this.title,
    required this.price,
    required this.imageUrl,
    required this.category,
  });

  final ThemeData theme;
  final String title;
  final double price;
  final String imageUrl;
  final String category;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: theme.cardColor,
        borderRadius: BorderRadius.circular(14),
        boxShadow: [
          BoxShadow(
            color: theme.shadowColor.withValues(alpha: 0.08),
            blurRadius: 8,
            offset: const Offset(0, 3),
          ),
        ],
      ),
      clipBehavior: Clip.antiAlias,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Expanded(
            child: Image.network(
              imageUrl,
              fit: BoxFit.contain,
              errorBuilder: (context, error, stackTrace) => Padding(
                padding: const EdgeInsets.all(24),
                child: Image.asset('assets/images/no_connection.png'),
              ),
              loadingBuilder: (context, child, progress) {
                if (progress == null) return child;
                return const Center(child: CircularProgressIndicator(strokeWidth: 2));
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  category.toUpperCase(),
                  style: theme.textTheme.labelSmall?.copyWith(color: theme.colorScheme.primary),
                ),
                const SizedBox(height: 2),
                Text(
                  title,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                  style: theme.textTheme.bodyMedium,
                ),
                const SizedBox(height: 6),
                Text(
                  '\$${price.toStringAsFixed(2)}',
                  style: theme.textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _ErrorState extends StatelessWidget {
  const _ErrorState({required this.theme, required this.onRetry});
  final ThemeData theme;
  final VoidCallback onRetry;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Image.asset('assets/images/no_connection.png', width: 140, height: 140),
          const SizedBox(height: 16),
          Text('Ürünler yüklenemedi', style: theme.textTheme.titleMedium),
          const SizedBox(height: 4),
          Text(
            'İnternet bağlantınızı kontrol edin',
            style: theme.textTheme.bodyMedium?.copyWith(color: theme.colorScheme.onSurfaceVariant),
          ),
          const SizedBox(height: 16),
          ElevatedButton(onPressed: onRetry, child: const Text('Tekrar Dene')),
        ],
      ),
    );
  }
}

class _EmptyState extends StatelessWidget {
  const _EmptyState({required this.theme});
  final ThemeData theme;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Image.asset('assets/images/empty_cart.png', width: 140, height: 140),
          const SizedBox(height: 16),
          Text('Gösterilecek ürün yok', style: theme.textTheme.titleMedium),
        ],
      ),
    );
  }
}