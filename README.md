# CountdownSolver.jl

Solves the [countdown problem](https://www.youtube.com/watch?v=2wyj7Ja2CPU&t=1m55s). 


## Problem description

Given a set `S` of natural numbers, combine these using `+`, `-`, `/`, `*` and `()` to get a desired result `r`. The brackets are required to distinguish between otherwise identitical combinations, e.g.:
```math
(2 \times 25) + (3 \times 4) \neq 2 \times (25 + 3) \times 4
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

In Julia:

```julia
julia> ENV["JULIA_PKG_DEVDIR"] = joinpath(ENV["HOME"], "Desktop", "Julia_Dev")
"/home/u0128861/Desktop/Julia_Dev"

(@v1.5) pkg> add git@github.com:junglegobs/CountdownSolver.jl.git
    Cloning git-repo `git@github.com:junglegobs/CountdownSolver.jl.git`
   Updating git-repo `git@github.com:junglegobs/CountdownSolver.jl.git`
   Updating registry at `~/.julia/registries/General`
   Updating git-repo `https://github.com/JuliaRegistries/General.git`
   Updating registry at `~/.julia/registries/SpineRegistry`
   Updating git-repo `https://github.com/Spine-project/SpineJuliaRegistry.git`
  Resolving package versions...
Updating `~/.julia/environments/v1.5/Project.toml`
  [7e945158] + CountdownSolver v0.1.0 `git@github.com:junglegobs/CountdownSolver.jl.git#main`
Updating `~/.julia/environments/v1.5/Manifest.toml`
  [7e945158] + CountdownSolver v0.1.0 `git@github.com:junglegobs/CountdownSolver.jl.git#main`

(@v1.5) pkg> dev CountdownSolver
    Cloning git-repo `git@github.com:junglegobs/CountdownSolver.jl.git`
  Resolving package versions...
Updating `~/.julia/environments/v1.5/Project.toml`
  [7e945158] ~ CountdownSolver v0.1.0 `git@github.com:junglegobs/CountdownSolver.jl.git#main` ⇒ v0.1.0 `~/Desktop/Julia_Dev/CountdownSolver`
Updating `~/.julia/environments/v1.5/Manifest.toml`
  [7e945158] ~ CountdownSolver v0.1.0 `git@github.com:junglegobs/CountdownSolver.jl.git#main` ⇒ v0.1.0 `~/Desktop/Julia_Dev/CountdownSolver`

julia> using Revise

julia> using CountdownSolver
[ Info: Precompiling CountdownSolver [7e945158-e9db-46ef-8867-8dbbec1b05b8]

(@v1.5) pkg> activate CountdownSolver
 Activating environment at `~/Desktop/Julia_Dev/CountdownSolver/Project.toml`
```
The package is now located at `joinpath(ENV["HOME"], "Desktop", "Julia_Dev")`. Any exported functions from the module `CountdownSolver` are now accessible, and the `Revise.jl` package ensures that any changes are automatically taken into account. By activating `CountdownSolver`, any packages will be added to the `CountdownSolver.jl` package (and not your main environment).
