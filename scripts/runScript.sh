#!/bin/sh

# This script runs experiments using the pbrt renderer.

runExperiment() {
  run=$(date +"%Y-%m-%d-%H-%M-%S")
  input=./experiments.txt
  mkdir -p "../results/$run"
  mkdir -p "../output/$run"
  i=0
  while IFS= read -r var; do
    filename=$(basename "$var")
    path="$PWD/$(dirname "$var")"
    pbrt ../scenes/$var --outfile "../output/$run/result_${i}_$filename.exr" | tee "../results/$run/result_$filename.txt"
    #echo "$var" | tee "../results/$run/result_$filename.txt"
    i=$(($i + 1))
  done <"$input"
  #sleep 1
  echo "Completed $i experiments."
}

runMultipleExperiments() {
  numExperiments=$1
  for i in $(seq 1 $numExperiments); do
    python3 "random_experiments_generator.py"
    echo "Running experiment $i"
    runExperiment
  done
}

# Call the runMultipleExperiments function to run 5 experiments
runMultipleExperiments 1
