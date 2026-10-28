import 'package:dio/dio.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../data/models/chapter.dart';

enum LoadStatus { loading, success, failure }

class ChaptersState extends Equatable {
  final LoadStatus status;
  final List<Chapter> chapters;
  final String? error;

  const ChaptersState({
    this.status = LoadStatus.loading,
    this.chapters = const [],
    this.error,
  });

  ChaptersState copyWith({
    LoadStatus? status,
    List<Chapter>? chapters,
    String? error,
  }) => ChaptersState(
    status: status ?? this.status,
    chapters: chapters ?? this.chapters,
    error: error,
  );

  @override
  List<Object?> get props => [status, chapters, error];
}

class ChaptersCubit extends Cubit<ChaptersState> {
  ChaptersCubit(this._dio) : super(const ChaptersState());

  final Dio _dio;

  Future<void> load() async {
    emit(state.copyWith(status: LoadStatus.loading));
    try {
      final res = await _dio.get('/chapters');
      final chapters = (res.data['data'] as List)
          .map((e) => Chapter.fromJson(e as Map<String, dynamic>))
          .toList();
      emit(state.copyWith(status: LoadStatus.success, chapters: chapters));
    } on DioException catch (e) {
      emit(
        state.copyWith(
          status: LoadStatus.failure,
          error: e.message ?? 'সার্ভারের সাথে সংযোগ হয়নি',
        ),
      );
    }
  }
}
