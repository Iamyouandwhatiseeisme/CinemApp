import 'package:cinemapp/data/firestore/firestore_database.dart';
import 'package:cinemapp/main.dart';
import 'package:flutter/material.dart';

class ReportDialog extends StatefulWidget {
  final String reportedText;

  const ReportDialog({
    super.key,
    required this.reportedText,
  });

  @override
  State<ReportDialog> createState() => _ReportDialogState();
}

class _ReportDialogState extends State<ReportDialog> {
  final TextEditingController controller = TextEditingController();
  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
        actions: [
          TextButton(
              onPressed: () => {Navigator.of(context).pop()},
              child: const Text('Cancel')),
          TextButton(
              onPressed: () async {
                await sl.get<FireStoreDataBase>().submitReport(
                    comment: controller.text, message: widget.reportedText);
                if (context.mounted) {
                  Navigator.of(context).pop();

                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                        content: Text('Report submitted successfully')),
                  );
                }
              },
              child: const Text('Submit')),
        ],
        title: const Text('Please specify a report message'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextFormField(
              controller: controller,
              decoration:
                  const InputDecoration(labelText: 'Reason for Reporting'),
            ),
          ],
        ));
  }
}
