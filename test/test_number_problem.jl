include(joinpath(@__DIR__, "..", "src", "CountdownSolver.jl"))

operators = (+,-,/,*)
numbers = rand([2:10..., 25, 50, 75], 6)
target = rand(1:1000)
CountdownSolver.solve_countdown_number_problem(target, numbers)