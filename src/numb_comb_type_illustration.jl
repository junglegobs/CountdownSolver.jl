include("CountdownSolver.jl")
CountdownSolver.NumbComb
n1 = CountdownSolver.NumbComb(2)
n2 = CountdownSolver.NumbComb(3)

n3 = n1 + n2
n4 = n1 * n2
n5 = n1 - n2
n6 = n1 / n2

# CountdownSolver.add_parents_and_operators([n1,n2],[+])

list = CountdownSolver.get_parent_operator_list(n1)
strList = CountdownSolver.expand_parent_operator_list_as_string(list)
print(strList...)

@show n6

# This won't work
try
    n7 = n6 + n3
catch e
    @info e
end

# This will
n8 = CountdownSolver.NumbComb(10)
n9 = CountdownSolver.NumbComb(2)
n10 = n8 * n9
n7 = n6 + n10

list = CountdownSolver.get_parent_operator_list(n7)
strList = CountdownSolver.expand_parent_operator_list_as_string(list)
println(strList...)

OGParents7 = CountdownSolver.get_original_parents(n7)
OGParents6 = CountdownSolver.get_original_parents(n6)

CountdownSolver.find_common(OGParents7, OGParents6)

commonParents = CountdownSolver.get_common_parents(n7, n6)