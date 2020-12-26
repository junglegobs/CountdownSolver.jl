# CountdownSolver.jl

Solves the [countdown problem](https://www.youtube.com/watch?v=2wyj7Ja2CPU&t=1m55s). 

As a first attempt, just try all possible combinations (Monte Carlo).

As a second attempt, formulate as an optimisation problem, probably by defining auxiliary variables somehow?

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
