using Pkg
Pkg.activate(joinpath(@__DIR__, ".."))
using BenchmarkTools
include("CountdownSolver.jl")

# Setup
IntType = Int32
operators = (+,-,/,*)
numbers = convert.(IntType, rand([2:10..., 25, 50, 75], 6))
target = rand(1:1000)

A = [CountdownSolver.NumberCombination(i) for i in numbers]

print(
"""
The target number is: $target
Allowed operators are: $operators
Given numbers are: $numbers
"""
)

# Now some function which loops over all the possibilities, 
# possibly while increasing the set A
best_match = CountdownSolver.NumberCombination(IntType(target*10))
t = tic()
for i in 2:length(numbers)
    A_new = CountdownSolver.NumberCombination{IntType}[]
    for n1 in A, n2 in A, op in operators
        if length(CountdownSolver.get_common_parents(n1, n2)) == 0
            n_new = op(n1, n2)
            push!(A_new, n_new)
            if abs(target - n_new.val) < abs(target - best_match.val)
                print(
                """
                Current best match is:
                $n_new

                """
                )
                best_match = n_new
            end
            if best_match.val ≈ target
                break
            end 
        end
    end
    append!(A, A_new)
end