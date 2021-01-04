using Pkg
Pkg.activate(joinpath(@__DIR__, ".."))
using BenchmarkTools
include("CountdownSolver.jl")

# Setup
operators = (+,-,/,*)
numbers = convert.(Int8, rand([2:10..., 25, 50, 75], 6))
target = rand(1:1000)

A = [CountdownSolver.NumberComb(i) for i in numbers]

# Now some function which loops over all the possibilities, 
# possibly while increasing the set A?


# function try_combination(n1::NumbComb, n2::NumbComb, op)

# end


# @benchmark rand(operators)(
#     rand(operators)(
#         rand(numbers), rand(numbers)
#     ),
#     rand(numbers)
# )

# # Quick calcs
# eval_time = 10^-6 # seconds
# total_time = 60 # seconds
# @show total_possible_evaluations = total_time / eval_time
# n_op = length(operators)
# n_num = length(numbers)
# @show total_possible_combos = n_op^(n_num) * factorial(n_num)
# @show ratio = total_possible_evaluations / total_possible_combos

# So can easily go through every possible combination!!!