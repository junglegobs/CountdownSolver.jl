using Pkg
Pkg.activate(joinpath(@__DIR__, ".."))
using BenchmarkTools

# Setup
operators = (+,-,/,*)
numbers = convert.(Int8, (2,3,25,75,7,8))
target = rand(1:1000)

@benchmark rand(operators)(
    rand(operators)(
        rand(numbers), rand(numbers)
    ),
    rand(numbers)
)

# Quick calcs
eval_time = 10^-6 # seconds
total_time = 60 # seconds
@show total_possible_evaluations = total_time / eval_time
n_op = length(operators)
n_num = length(numbers)
@show total_possible_combos = n_op^(n_num) * factorial(n_num)
@show ratio = total_possible_evaluations / total_possible_combos

# So can easily go through every possible combination!!!