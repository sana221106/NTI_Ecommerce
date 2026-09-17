import 'package:ecommerce/feature/main/presentation/cubits/Location_Cubit/location_cubit.dart';
import 'package:ecommerce/feature/main/presentation/cubits/Location_Cubit/location_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class LocationScreen extends StatelessWidget {
  const LocationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => LocationCubit(),
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Delivery Location'),
        ),
        body: BlocBuilder<LocationCubit, LocationState>(
          builder: (context, state) {
            if (state is LocationInitial) {
              return Center(
                child: ElevatedButton.icon(
                  onPressed: () {
                    context.read<LocationCubit>().getLocation();
                  },
                  icon: const Icon(Icons.location_on),
                  label: const Text('Get Current Location'),
                ),
              );
            }

            if (state is LocationLoading) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }

            if (state is LocationSuccess) {
              return Center(
                child: Padding(
                  padding: const EdgeInsets.all(24),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Icon(
                        Icons.location_on,
                        size: 70,
                        color: Colors.red,
                      ),
                      const SizedBox(height: 20),
                      const Text(
                        'Your Current Location',
                        style: TextStyle(
                          fontSize: 22,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      const SizedBox(height: 20),
                      Text(
                        'Latitude: ${state.position.latitude}',
                        style: const TextStyle(fontSize: 18),
                      ),
                      const SizedBox(height: 10),
                      Text(
                        'Longitude: ${state.position.longitude}',
                        style: const TextStyle(fontSize: 18),
                      ),
                      const SizedBox(height: 30),
                      ElevatedButton.icon(
                        onPressed: () {
                          context.read<LocationCubit>().getLocation();
                        },
                        icon: const Icon(Icons.refresh),
                        label: const Text('Update Location'),
                      ),
                    ],
                  ),
                ),
              );
            }

            if (state is LocationFailure) {
              return Center(
                child: Padding(
                  padding: const EdgeInsets.all(24),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Icon(
                        Icons.location_off,
                        size: 70,
                        color: Colors.red,
                      ),
                      const SizedBox(height: 20),
                      Text(
                        state.errorMessage,
                        textAlign: TextAlign.center,
                        style: const TextStyle(
                          fontSize: 16,
                          color: Colors.red,
                        ),
                      ),
                      const SizedBox(height: 20),
                      ElevatedButton(
                        onPressed: () {
                          context.read<LocationCubit>().getLocation();
                        },
                        child: const Text('Try Again'),
                      ),
                    ],
                  ),
                ),
              );
            }

            return const SizedBox();
          },
        ),
      ),
    );
  }
}