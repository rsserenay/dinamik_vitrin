// lib/views/widgets/promo_banner.dart
//
// Katman: VIEW (yardımcı widget)
// Sorumluluğu: RemoteConfigController'ı dinleyip show_promo_banner true ise
// promo_text'i göstermek. İçerik hiçbir şekilde koda gömülü (hardcoded)
// değildir; Controller'dan Obx ile reaktif olarak okunur. Renkler yine
// Theme.of(context) üzerinden gelir.

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../controllers/remote_config_controller.dart';

class PromoBanner extends StatelessWidget {
  const PromoBanner({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final remoteConfigController = Get.find<RemoteConfigController>();

    return Obx(() {
      if (!remoteConfigController.showPromoBanner.value ||
          remoteConfigController.promoText.value.isEmpty) {
        return const SizedBox.shrink();
      }

      return Container(
        width: double.infinity,
        margin: const EdgeInsets.fromLTRB(12, 12, 12, 0),
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
        decoration: BoxDecoration(
          color: theme.colorScheme.primary,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Row(
          children: [
            Icon(Icons.campaign, color: theme.colorScheme.onPrimary),
            const SizedBox(width: 10),
            Expanded(
              child: Text(
                remoteConfigController.promoText.value,
                style: theme.textTheme.bodyMedium?.copyWith(
                  color: theme.colorScheme.onPrimary,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          ],
        ),
      );
    });
  }
}