import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rentapp/presentation/bloc/car_bloc.dart';
import 'package:rentapp/presentation/bloc/car_state.dart';
import 'package:rentapp/presentation/widgets/car_card.dart';

class CarListScreen extends StatelessWidget {
  const CarListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CarBloc, CarState>(
      builder: (context, state){
        if(state is CarsLoading){
          return const Center(child: CircularProgressIndicator());
        } else if(state is CarsLoaded) {
          return ListView.builder(
            itemCount: state.cars.length,
            itemBuilder: (context, index){
              return CarCard(car: state.cars[index]);
            },
          );
        } else if(state is CarsError) {
          return Center(child: Text('error : ${state.message}'));
        }
        return Container();
      },
    );
  }
}
