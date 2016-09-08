#!/bin/bash

script="$1"
i="$2"
j="$3"
res="$4"
mesh="$5"
lhs="$6"
iaca_base="$7"

echo "1 $i $j"
echo "layers = $mesh" >> $res
echo "number of threads = 1 $i $j" >> $res
mpirun -n 1 likwid-pin -c 0 python $script $i $j $res $mesh $lhs

echo "8 $i $j"
echo "number of threads = 8 $i $j" >> $res
mpirun -n 1 likwid-pin -c 0 python $script $i $j $res $mesh $lhs : -n 1 likwid-pin -c 1 python $script $i $j $res $mesh $lhs : -n 1 likwid-pin -c 2 python $script $i $j $res $mesh $lhs : -n 1 likwid-pin -c 3 python $script $i $j $res $mesh $lhs : -n 1 likwid-pin -c 4 python $script $i $j $res $mesh $lhs : -n 1 likwid-pin -c 5 python $script $i $j $res $mesh $lhs : -n 1 likwid-pin -c 6 python $script $i $j $res $mesh $lhs : -n 1 likwid-pin -c 7 python $script $i $j $res $mesh $lhs

echo "16 $i $j"
echo "number of threads = 16 $i $j" >> $res
mpirun -n 1 likwid-pin -c 0 python $script $i $j $res $mesh $lhs : -n 1 likwid-pin -c 1 python $script $i $j $res $mesh $lhs : -n 1 likwid-pin -c 2 python $script $i $j $res $mesh $lhs : -n 1 likwid-pin -c 3 python $script $i $j $res $mesh $lhs : -n 1 likwid-pin -c 4 python $script $i $j $res $mesh $lhs : -n 1 likwid-pin -c 5 python $script $i $j $res $mesh $lhs : -n 1 likwid-pin -c 6 python $script $i $j $res $mesh $lhs : -n 1 likwid-pin -c 7 python $script $i $j $res $mesh $lhs : -n 1 likwid-pin -c 8 python $script $i $j $res $mesh $lhs : -n 1 likwid-pin -c 9 python $script $i $j $res $mesh $lhs : -n 1 likwid-pin -c 10 python $script $i $j $res $mesh $lhs : -n 1 likwid-pin -c 11 python $script $i $j $res $mesh $lhs : -n 1 likwid-pin -c 12 python $script $i $j $res $mesh $lhs : -n 1 likwid-pin -c 13 python $script $i $j $res $mesh $lhs : -n 1 likwid-pin -c 14 python $script $i $j $res $mesh $lhs : -n 1 likwid-pin -c 15 python $script $i $j $res $mesh $lhs

echo "32 $i $j"
echo "number of threads = 32 $i $j" >> $res
mpirun -n 1 likwid-pin -c 0 python $script $i $j $res $mesh $lhs : -n 1 likwid-pin -c 1 python $script $i $j $res $mesh $lhs : -n 1 likwid-pin -c 2 python $script $i $j $res $mesh $lhs : -n 1 likwid-pin -c 3 python $script $i $j $res $mesh $lhs : -n 1 likwid-pin -c 4 python $script $i $j $res $mesh $lhs : -n 1 likwid-pin -c 5 python $script $i $j $res $mesh $lhs : -n 1 likwid-pin -c 6 python $script $i $j $res $mesh $lhs : -n 1 likwid-pin -c 7 python $script $i $j $res $mesh $lhs : -n 1 likwid-pin -c 8 python $script $i $j $res $mesh $lhs : -n 1 likwid-pin -c 9 python $script $i $j $res $mesh $lhs : -n 1 likwid-pin -c 10 python $script $i $j $res $mesh $lhs : -n 1 likwid-pin -c 11 python $script $i $j $res $mesh $lhs : -n 1 likwid-pin -c 12 python $script $i $j $res $mesh $lhs : -n 1 likwid-pin -c 13 python $script $i $j $res $mesh $lhs : -n 1 likwid-pin -c 14 python $script $i $j $res $mesh $lhs : -n 1 likwid-pin -c 15 python $script $i $j $res $mesh $lhs : -n 1 likwid-pin -c 16 python $script $i $j $res $mesh $lhs : -n 1 likwid-pin -c 17 python $script $i $j $res $mesh $lhs : -n 1 likwid-pin -c 18 python $script $i $j $res $mesh $lhs : -n 1 likwid-pin -c 19 python $script $i $j $res $mesh $lhs : -n 1 likwid-pin -c 20 python $script $i $j $res $mesh $lhs : -n 1 likwid-pin -c 21 python $script $i $j $res $mesh $lhs : -n 1 likwid-pin -c 22 python $script $i $j $res $mesh $lhs : -n 1 likwid-pin -c 23 python $script $i $j $res $mesh $lhs : -n 1 likwid-pin -c 24 python $script $i $j $res $mesh $lhs : -n 1 likwid-pin -c 25 python $script $i $j $res $mesh $lhs : -n 1 likwid-pin -c 26 python $script $i $j $res $mesh $lhs : -n 1 likwid-pin -c 27 python $script $i $j $res $mesh $lhs : -n 1 likwid-pin -c 28 python $script $i $j $res $mesh $lhs : -n 1 likwid-pin -c 29 python $script $i $j $res $mesh $lhs : -n 1 likwid-pin -c 30 python $script $i $j $res $mesh $lhs : -n 1 likwid-pin -c 31 python $script $i $j $res $mesh $lhs
