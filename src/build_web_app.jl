using Stipple
using CountdownSolver

Base.@kwdef mutable struct WebModel <: ReactiveModel
    process::R{Bool} = false
    answer::R{String} = "1000"
    numbers::R{String} = "1,2,3,4,25,50"
    target::R{String} = "1000"
    error::R{String} = "No errors, great!"
    timeout::R{String} = "30"
end

rt_model = Stipple.init(WebModel())

on(rt_model.process) do _
    if (rt_model.process[])
        try
            in_str = rt_model.numbers[]
            split_str = split(in_str, r"[,;:]")
            timeout = parse(Int, rt_model.timeout[])
            numbers = [parse(Int, s) for s in split_str if isempty(s) == false]
            target = parse(Int, rt_model.target[])
            rt_model.answer[] = "Computing..."
            best_guess = CountdownSolver.solve_countdown_number_problem(target, numbers)
            rt_model.answer[] = string(best_guess)
            rt_model.error[] = "No errors, great!"
        catch e
            rt_model.error[] = string(e)
        end
        rt_model.process[] = false
    end
end

function ui()
    [
        page(
            vm(rt_model), class="container", title="Countdown solver", [
                h2(["Countdown solver"])
                p([
                    "Target: "
                    input("", @bind(:target), @on("keyup.enter", "process = true"))
                ])
                p([
                    "Numbers (seperated by a comma): "
                    input("", @bind(:numbers), @on("keyup.enter", "process = true"))
                ])
                p([
                    "Time out (seconds): "
                    input("", @bind(:timeout), @on("keyup.enter", "process = true"))
                ])
                p(
                    button("Solve!", @click("process = true"))
                )
                p([
                    "Output: "
                    span("", @text(:answer))
                ])
                p([
                    "Errors: "
                    span("", @text(:error))
                ])
            ]
        )
    ] |> html
end

route("/", ui)
up(8000, open_browser=true)