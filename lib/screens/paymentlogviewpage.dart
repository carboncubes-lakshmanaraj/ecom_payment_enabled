import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:ecom_payment/datas/paymentlog.dart';
import 'package:ecom_payment/repositories/paymentlog_repo.dart';

class PaymentLogViewerPage extends StatelessWidget {
  final int orderId;

  const PaymentLogViewerPage({super.key, required this.orderId});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Logs for Order #$orderId')),
      body: FutureBuilder<List<PaymentLog>>(
        future: PaymentLogRepository.getLogsByOrder(orderId),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          if (snapshot.hasError) {
            return Center(child: Text("Error: ${snapshot.error}"));
          }

          final logs = snapshot.data ?? [];
          if (logs.isEmpty) {
            return const Center(child: Text('No logs found.'));
          }

          return ListView.builder(
            padding: const EdgeInsets.all(8),
            itemCount: logs.length,
            itemBuilder: (context, index) {
              final log = logs[index];
              String prettyPayload;

              try {
                final decoded = json.decode(log.payload);
                prettyPayload = const JsonEncoder.withIndent(
                  '  ',
                ).convert(decoded);
              } catch (e) {
                prettyPayload = log.payload; // fallback to raw
              }

              return Card(
                margin: const EdgeInsets.symmetric(vertical: 6),
                child: ExpansionTile(
                  title: Text(
                    '${log.direction.toUpperCase()} at ${log.createdAt}',
                    style: const TextStyle(fontWeight: FontWeight.bold),
                  ),
                  subtitle: Text(
                    log.payload.length > 60
                        ? '${log.payload.substring(0, 60)}...'
                        : log.payload,
                    style: const TextStyle(color: Colors.grey),
                  ),
                  children: [
                    Container(
                      width: double.infinity,
                      padding: const EdgeInsets.all(12),
                      color: const Color(0xFFFAFAFA),
                      child: SelectableText(
                        prettyPayload,
                        style: const TextStyle(
                          fontFamily: 'Courier',
                          fontSize: 14,
                        ),
                      ),
                    ),
                  ],
                ),
              );
            },
          );
        },
      ),
    );
  }
}
