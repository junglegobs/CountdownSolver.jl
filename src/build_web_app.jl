using Genie, Genie.Router, Genie.Renderer.Html, Stipple, StippleUI

Base.@kwdef mutable struct StippleModel <: ReactiveModel
    process::R{Bool} = false
    output::R{NumberCombination} = NumberCombination(0)
    numbers::R{Vector{Int64}} = [2,3,8,25,25,50]
    target::Int64 = 0
end

web_app = Stipple.init(StippleModel())

on(web_app.process) do _
    if (web_app.process[])
        web_app.output[] = solve_countdown_number_problem(web_app.input[])
        web_app.process[] = false
    end
end

function ui()
    page(
        root(web_app), class="container", [
            
        p([
            "Target: "
            input(Int[], @data(:input), @on("keyup.enter", "process = true"))
        ])

        p([
            "Number: "
            input(Int[], @data(:input), @on("keyup.enter", "process = true"))
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
    ) |> html
end