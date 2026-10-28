import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'chapters_cubit.dart';

class ChaptersPage extends StatelessWidget {
  const ChaptersPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('HSC ICT')),
      body: BlocBuilder<ChaptersCubit, ChaptersState>(
        builder: (context, state) {
          switch (state.status) {
            case LoadStatus.loading:
              return const Center(child: CircularProgressIndicator());
            case LoadStatus.failure:
              return Center(
                child: Padding(
                  padding: const EdgeInsets.all(24),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        state.error ?? 'কিছু একটা ভুল হয়েছে',
                        textAlign: TextAlign.center,
                      ),
                      const SizedBox(height: 16),
                      FilledButton(
                        onPressed: () => context.read<ChaptersCubit>().load(),
                        child: const Text('আবার চেষ্টা করুন'),
                      ),
                    ],
                  ),
                ),
              );
            case LoadStatus.success:
              return ListView.separated(
                itemCount: state.chapters.length,
                separatorBuilder: (_, __) => const Divider(height: 1),
                itemBuilder: (context, i) {
                  final c = state.chapters[i];
                  return ListTile(
                    leading: CircleAvatar(child: Text('${i + 1}')),
                    title: Text(c.name),
                    subtitle: Text('${c.questionsCount}টি প্রশ্ন'),
                  );
                },
              );
          }
        },
      ),
    );
  }
}
