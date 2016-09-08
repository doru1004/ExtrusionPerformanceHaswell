#!/bin/bash

vers="$1"
lhs="$2"
run="$3"

side="RHS"
sside="rhs"
vectorized="1"

if [ x"$lhs" = "x0" ];
    then
    side="LHS"
    sside="lhs"
    echo "Running LHS."
fi

if [ x"$lhs" = "x1" ];
    then
    side="RHS"
    sside="rhs"
    echo "Running RHS."
    vectorized="0"
fi

if [ x"$lhs" = "x2" ];
    then
    side="FRHS"
    sside="frhs"
    echo "Running F RHS."
    vectorized="0"
fi

if [ x"$lhs" = "x3" ];
    then
    side="FFRHS"
    sside="ffrhs"
    echo "Running FF RHS."
fi

if [ x"$lhs" = "x4" ];
    then
    side="F3RHS"
    sside="f3rhs"
    echo "Running 3xF RHS."
fi

if [ x"$lhs" = "x5" ];
    then
    side="F4RHS"
    sside="f4rhs"
    echo "Running 4xF RHS."
fi

base="${PWD}/../../"
scripts="${base}/DATA/SCRIPTS"
gnuplot_dir="${base}/DATA/MASS_${side}_${vers}"

res="${gnuplot_dir}/results_${sside}_mpi_${PERF_KIT_VERSION}.txt"
script="${scripts}/rhs_cgdg_single.py"

roofline="${scripts}/rooflineExtruded.py"
rfl_dir="${gnuplot_dir}/ROOFLINE"
iaca_dir="${gnuplot_dir}/IACA"

dir_script="${scripts}/createDir.py"
dir_script_gentle="${scripts}/createDirGentle.py"
# Create the directory for the roofline data and plots
python $dir_script $rfl_dir
python $dir_script_gentle $iaca_dir

base_iaca="${iaca_dir}/iaca_"
export PYOP2_IACA_OUT_FILE="${base_iaca}"

if [ x"$run" = "xrun" ];
    then
    echo "Running the experiments."
    for i in 0 3 4
    do
        for j in 0 3 4
        do
            for mesh in 1 2 4 10 30 50 100
            do
                sh common_run.sh "$script" "$i" "$j" "$res" "$mesh" "$lhs"
            done
        done
    done
    echo "end" >> $res
fi

greedy_reader="${base}/greedy_compact_reader.py"

python $greedy_reader $res $gnuplot_dir $side $vectorized

cat "$gnuplot_dir"/RHS__*_1.txt > "${rfl_dir}/RHS_1.txt"
cat "$gnuplot_dir"/RHS__*_8.txt > "${rfl_dir}/RHS_8.txt"
cat "$gnuplot_dir"/RHS__*_16.txt > "${rfl_dir}/RHS_16.txt"
cat "$gnuplot_dir"/RHS__*_32.txt > "${rfl_dir}/RHS_32.txt"

python $roofline "${rfl_dir}/RHS_1.txt" "${side} - 1 MPI proc" 0 $vectorized
python $roofline "${rfl_dir}/RHS_8.txt" "${side} - 8 MPI procs" 0 $vectorized
python $roofline "${rfl_dir}/RHS_16.txt" "${side} - 16 MPI procs" 0 $vectorized
python $roofline "${rfl_dir}/RHS_32.txt" "${side} - 32 MPI procs" 0 $vectorized

cat "$gnuplot_dir"/RHS__*_1_u.txt > "${rfl_dir}/RHS_1_u.txt"
cat "$gnuplot_dir"/RHS__*_8_u.txt > "${rfl_dir}/RHS_8_u.txt"
cat "$gnuplot_dir"/RHS__*_16_u.txt > "${rfl_dir}/RHS_16_u.txt"
cat "$gnuplot_dir"/RHS__*_32_u.txt > "${rfl_dir}/RHS_32_u.txt"

python $roofline "${rfl_dir}/RHS_1_u.txt" "${side} - 1" 1 $vectorized
python $roofline "${rfl_dir}/RHS_8_u.txt" "${side} - 8" 1 $vectorized
python $roofline "${rfl_dir}/RHS_16_u.txt" "${side} - 16" 1 $vectorized
python $roofline "${rfl_dir}/RHS_32_u.txt" "${side} - 32" 1 $vectorized

cat "$gnuplot_dir"/RHS__DG1*_16.txt > "${rfl_dir}/RHS_DG1xX_16.txt"
cat "$gnuplot_dir"/RHS__CG1*_16.txt > "${rfl_dir}/RHS_CG1xX_16.txt"
cat "$gnuplot_dir"/RHS__DG0*_16.txt > "${rfl_dir}/RHS_DG0xX_16.txt"

python $roofline "${rfl_dir}/RHS_DG1xX_16.txt" "${side} - 16 MPI procs" 0 $vectorized
python $roofline "${rfl_dir}/RHS_CG1xX_16.txt" "${side} - 16 MPI procs" 0 $vectorized
python $roofline "${rfl_dir}/RHS_DG0xX_16.txt" "${side} - 16 MPI procs" 0 $vectorized

cat "$gnuplot_dir"/RHS__DG1*_32.txt > "${rfl_dir}/RHS_DG1xX_32.txt"
cat "$gnuplot_dir"/RHS__CG1*_32.txt > "${rfl_dir}/RHS_CG1xX_32.txt"
cat "$gnuplot_dir"/RHS__DG0*_32.txt > "${rfl_dir}/RHS_DG0xX_32.txt"

python $roofline "${rfl_dir}/RHS_DG1xX_32.txt" "${side} - 32 MPI procs" 0 $vectorized
python $roofline "${rfl_dir}/RHS_CG1xX_32.txt" "${side} - 32 MPI procs" 0 $vectorized
python $roofline "${rfl_dir}/RHS_DG0xX_32.txt" "${side} - 32 MPI procs" 0 $vectorized

