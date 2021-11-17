import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:parking_management1/core/error/failures.dart';
import 'package:parking_management1/core/usecase/usecase.dart';
import 'package:parking_management1/feature/list_vahicle_in_park/data/models/list_vahicle_in_park_res.dart';
import 'package:parking_management1/feature/list_vahicle_in_park/domain/repo/list_vahicle_in_park_repo.dart';

class ListVahicleInPark
    implements UseCase<ListVahicleInParkResponse, ListVahicleInParkParams> {
  final ListVahicleInParkRepository courseContentsRepository;

  ListVahicleInPark(this.courseContentsRepository);

  @override
  Future<Either<Failure, ListVahicleInParkResponse>> call(
      ListVahicleInParkParams a) async {
    return await courseContentsRepository.courseContents(a.loaixe!, a.name!);
  }
}

class ListVahicleInParkParams extends Equatable {
  final String? loaixe;
  final String? name;

  ListVahicleInParkParams({this.loaixe, this.name});

  @override
  // TODO: implement props
  List<Object> get props => [loaixe!, name!];
}
