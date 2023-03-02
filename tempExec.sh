while [ 1 -gt 0 ]; do
    bash exec.bash antlr createCompile src/CalcToMvap/CalcToMvap.g4
    bash exec.bash antlr test dist/class/CalcToMvap/CalcToMvap.g4 calcul > test.mvap
    bash exec.bash mvap execute test.mvap tru tru
done