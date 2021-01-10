# CountdownSolver.jl

Solves the [countdown problem](https://www.youtube.com/watch?v=2wyj7Ja2CPU&t=1m55s). 


## Problem description

Given a set `S` of natural numbers, combine these using `+`, `-`, `/`, `*` and `()` to get a desired result `r`. The brackets are required to distinguish between otherwise identitical combinations, e.g.:
```math
2 * 25 + 3 * 4 =/= 2 * (25 + 3) * 4
```

Some useful resources on the topic:
* [Writing an algorithm to decide whether a target number can be reached with a set](https://stackoverflow.com/questions/16564543/writing-an-algorithm-to-decide-whether-a-target-number-can-be-reached-with-a-set)
* [Writing an algorithm to decide whether a target number can be reached with a set of other numbers and specific operators?](https://stackoverflow.com/questions/16564543/writing-an-algorithm-to-decide-whether-a-target-number-can-be-reached-with-a-set)
* [Solver written in C++](https://github.com/jes/cntdn/blob/master/cntdn.js#L148)

It seems brute force is the only way of doing this, i.e. try as many combinations in 30 seconds and see which one is closest to the desired result. This algorithm could be desribed as follows:

1. Set `A = [(,n) for n in S]` to be the set of available numbers and how they were obtained (order of operations).
2. For `(a1,a1)` in `unique(product(A,A))`, combine `a1` and `a1` using `+`, `-`, `/`, `*` and `()`.
3. If this combination is equal to `r`, then stop. Else, save this number and the associated operations with it in `A_new`.
4. Set `A = union(A,A_new)`.
5. Go back to step 2.

The problem with this algorithm is that some impossible combinations are produced, e.g. if `S = [2,3,10,25]` then a possible combination (in terms of the algorithm) is `2 * 3 * 2`, even though 2 only appears once. I can get over this by saving the numbers used as well as the order of operation in the set `A`.

# Develop

Just do `include(<path_to_CountdownSolver.jl>)` before running a script or a test. Similarly for the functions to build the web UI.

Alternatively:

```julia
julia> ENV["JULIA_PKG_DEVDIR"] = joinpath(ENV["HOME"], "Desktop", "Julia_Dev")
(@v1.5) pkg> add git@github.com:junglegobs/CountdownSolver.jl.git
(@v1.5) pkg> dev CountdownSolver # Will copy files to Desktop/Julia_Dev
julia> using Revise
(@v1.5) pkg> activate CountdownSolver
julia> using CountdownSolver
```
The package is now located at `joinpath(ENV["HOME"], "Desktop", "Julia_Dev")`. Any exported functions from the module `CountdownSolver` are now accessible, and the `Revise.jl` package ensures that any changes are automatically taken into account. By activating `CountdownSolver`, any packages will be added to the `CountdownSolver.jl` package (and not your main environment).
