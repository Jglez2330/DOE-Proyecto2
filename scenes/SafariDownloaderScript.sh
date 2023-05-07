#!/bin/sh

# This script runs experiments using the pbrt renderer.

runExperiment() {
  numExperiments=$1
  for i in $(seq 1 $numExperiments)
  do
  run=$(date +"%Y-%m-%d-%H-%M-%S")
  input=/Users/jglez2330/Documents/TEC/2023/IS/DOE/DOE-Proyecto2/scripts/experiments.txt
  mkdir "$run"
  i=0
  while IFS= read -r var
  do
    filename=$(basename "$var" .pbrt)
    path="$PWD/$(dirname "$var")"
    pbrt "$var" | tee "$run/result_$filename.txt"
    i=$(($i+1))
  done < "$input"
  echo "Completed $i experiments."
  echo "Running experiment $i"
    runExperiment
  done
}

runMultipleExperiments() {
  
  
    
}

# Call the runMultipleExperiments function to run 5 experiments
#runMultipleExperiments 5

runExperiment 