include(joinpath(@__DIR__, "..", "src", "CountdownSolver.jl"))
# include(joinpath(@__DIR__, "..", "src", "build_web_app.jl"))

route("/") do
    CountdownSolver.ui() |> html
end
up(8000, open_browser=true)

# I think this link is more useful:
# https://github.com/GenieFramework/StippleDemos/blob/master/IrisClustering.jl

web_app = CountdownSolver.return_web_app()
web_app.process[] = true
@show web_app.output[]