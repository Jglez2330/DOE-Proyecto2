
#!/bin/bash

# This script opens 4 terminal windows.

function runExperiment {
  run=$(date +"%Y-%m-%d-%H-%M-%S")
  input=/Users/jglez2330/Documents/TEC/2023/IS/DOE/DOE-Proyecto2/scripts/experiments.txt
  mkdir "$run"
  i=0
  while IFS= read -r var
  do
    filename=$(basename $var .pbrt)
	echo $filename
	echo $var "\n"
    pbrt $var 
    i=$[$i+1]
  done < "$input"
  echo "Completed $i experiments."
}

list= runExperiment
