using Genie, Genie.Router, Genie.Renderer.Html, Stipple

Base.@kwdef mutable struct Model <: ReactiveModel
    process::R{Bool} = false
    output::R{String} = ""
    input::R{String} = ""
end

web_app = Stipple.init(Model())

on(web_app.process) do _
    if (web_app.process[])
        web_app.output[] = web_app.input[] |> reverse
        web_app.process[] = false
    end
end

function ui()
    page(
        root(web_app), class="container", [
        p([
            "Input: "
            input("", @bind(:input), @on("keyup.enter", "process = true"))
        ])

        p([
            button("Action!", @click("process = true"))
        ])

        p([
            "Output: "
            span("", @text(:output))
        ])
        ]
    ) |> html
end