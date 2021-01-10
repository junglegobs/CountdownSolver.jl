include(joinpath(@__DIR__, "..", "src", "CountdownSolver.jl"))
# include(joinpath(@__DIR__, "..", "src", "build_web_app.jl"))

route("/", CountdownSolver.ui)
CountdownSolver.ui()
up(8000, open_browser=true)

# I think this link is more useful:
# https://github.com/GenieFramework/StippleDemos/blob/master/IrisClustering.jl