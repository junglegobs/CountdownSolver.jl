using Genie, Genie.Router, Genie.Renderer.Html, Stipple, StippleUI

Base.@kwdef mutable struct StippleModel <: ReactiveModel
    process::R{Bool} = false
    output::R{String} = ""
    numbers::R{Vector{Int64}} = [2,3,8,25,25,50]
    target::Int64 = 0
end

web_app = Stipple.init(StippleModel())

on(web_app.process) do _ # This creates a function which "listens" to web_app.process
    if (web_app.process[]) # Do this function if process = true
        web_app.output[] = "Computing..."
        @info "Computing..."
        answer = NumberCombination(web_app.numbers[][1])
        io = IOBuffer(); print(io, answer) # Print answer to IO buffer
        web_app.output[] = String(take!(io)) # Set this in output
        web_app.output[] = "Boom" #
        web_app.process[] = false
    end
end

function ui()
    [
    dashboard(
        vm(web_app), class="container", title="Countdown Solver", [
        h1("Countdown Solver")
        p([
            "Target: "
            input(0, @bind(:target))
        ])

        p([
            "Number: "
            input([1,2,3,4,5,6], @bind(:numbers))
        ])

        p([
            "Enter the allowed numbers seperated by a comma in the box above."
        ])

        p([
            button("Solve countdown problem!", @click("process = true"))
        ])

        p([
            "Output: "
            span("", @text(:output))
        ])
        ]
    )
    ]
end

route("/") do
    CountdownSolver.ui() |> html
end
up(8000, open_browser=true)

function return_web_app()
    return web_app
end