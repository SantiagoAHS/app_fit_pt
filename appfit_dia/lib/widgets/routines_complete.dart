import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class CompletedRoutineCard extends StatelessWidget {
  final String title;

  const CompletedRoutineCard({
    super.key,
    required this.title,
  });

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final isSmallScreen = screenWidth < 350;

    return Container(
      margin: EdgeInsets.symmetric(
        vertical: isSmallScreen ? 4 : 8,
        horizontal: isSmallScreen ? 8 : 16,
      ),
      padding: EdgeInsets.symmetric(
        vertical: isSmallScreen ? 8 : 16,
        horizontal: isSmallScreen ? 12 : 20,
      ),
      decoration: BoxDecoration(
        color: Colors.green[100],
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.green.withOpacity(0.3),
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Text(
        title,
        style: TextStyle(
          fontSize: isSmallScreen ? 12 : 18,
          fontWeight: FontWeight.w600,
          color: Colors.green[800],
        ),
      ),
    );
  }
}

class RoutinesComplete extends StatelessWidget {
  const RoutinesComplete({super.key});

  String? get userId => FirebaseAuth.instance.currentUser?.uid;

  @override
  Widget build(BuildContext context) {
    if (userId == null) {
      return const Center(child: Text('Usuario no autenticado'));
    }

    final Query completedRoutinesQuery = FirebaseFirestore.instance
        .collection('rutinas_completadas')
        .where(FieldPath.documentId, isGreaterThanOrEqualTo: '$userId-')
        .where(FieldPath.documentId, isLessThanOrEqualTo: '$userId-\uf8ff');

    return StreamBuilder<QuerySnapshot>(
      stream: completedRoutinesQuery.snapshots(),
      builder: (context, snapshot) {
        if (snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot.error}'));
        }
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        }

        final docs = snapshot.data!.docs;
        if (docs.isEmpty) {
          return const Center(child: Text('No hay rutinas completadas aún.'));
        }

        return ListView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: docs.length,
          itemBuilder: (context, index) {
            final data = docs[index].data()! as Map<String, dynamic>;
            final title = data['title'] ?? 'Sin título';
            return CompletedRoutineCard(title: title);
          },
        );
      },
    );
  }
}
