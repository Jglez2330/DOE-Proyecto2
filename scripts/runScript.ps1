function runExperiment {
  $run = (Get-Date).ToString("yyyy-MM-dd-HH-mm-ss")
  $input = ".\experiments.txt"
  $results = "..\results\$run"
  $output = "..\output\$run"
  New-Item -ItemType Directory -Force -Path $results
  New-Item -ItemType Directory -Force -Path $output
  $i = 0
  Get-Content $input | ForEach-Object {
    $filename = $_ | Split-Path -Leaf
    $path = $_ | Split-Path -Parent
    & "C:\pbrt\pbrt.exe" "..\scenes\$_" --outfile "$output\result_${i}_$filename.exr" | Tee-Object "$results\result_$filename.txt"
    $i++
  }
  Write-Output "Completed $i experiments."
}

function runMultipleExperiments {
  param([int]$numExperiments)
  for ($i = 1; $i -le $numExperiments; $i++) {
    py ".\random_experiments_generator.py"
    Write-Output "Running experiment $i"
    runExperiment
  }
}

# Call the runMultipleExperiments function to run 5 experiments
runMultipleExperiments -numExperiments 1


#function runExperiment {
#    $run = Get-Date -Format "yyyy-MM-dd-HH-mm-ss"
#    $input = "./experiments.txt"
#    mkdir -Force "../results/$run"
#    mkdir -Force "../output/$run"
#    $i = 0
#    Get-Content $input | ForEach-Object {
#        $filename = [System.IO.Path]::GetFileName($_)
#        $path = [System.IO.Path]::GetDirectoryName($_)
#        &$("C:\pbrt\pbrt.exe") "../scenes/$_" --outfile "../output/$run/result_${i}_$filename.exr" 2>&1 | tee-object "../results/$run/result_$filename.txt"
#        $i = $i + 1
#    }
#    echo "Completed $i experiments."
#}

#function runMultipleExperiments {
#    param([int] $numExperiments)
#    for ($i = 1; $i -le $numExperiments; $i++) {
#        python "random_experiments_generator.py"
#        echo "Running experiment $i"
#        runExperiment
#    }
#}

# Call the runMultipleExperiments function to run 5 experiments
#runMultipleExperiments 1
