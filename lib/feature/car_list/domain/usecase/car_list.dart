import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:parking_management1/core/error/failures.dart';
import 'package:parking_management1/core/usecase/usecase.dart';
import 'package:parking_management1/feature/car_list/data/models/car_list_response_model.dart';
import 'package:parking_management1/feature/car_list/domain/repositories/car_list_repo.dart';

class VahicleList implements UseCase<VahicleListResponse, Params> {
  final VahicleListRepository courseContentsRepository;

  VahicleList(this.courseContentsRepository);

  @override
  Future<Either<Failure, VahicleListResponse>> call(Params params) async {
    return await courseContentsRepository.courseContents(
        params.loaixe!, params.name!);
  }
}

class Params extends Equatable {
  final String? loaixe;
  final String? name;

  Params({this.loaixe, this.name});

  @override
  // TODO: implement props
  List<Object> get props => [loaixe!, name!];
}
