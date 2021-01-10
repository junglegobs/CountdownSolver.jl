"""
    solve_countdown_number_problem(target, numbers)

Solves the countdown number problemby brute force.

# Example

# Optional arguments
`operators = (+,-,/,*)`: Permitted operators
`timeout = 30.0`: Time limit in seconds
"""
function solve_countdown_number_problem(target::Number, numbers;
        operators=(+,-,/,*),
        timeout::Number=30.0
    )
    @assert eltype(operators) <: Function
    NumType = eltype(numbers); @assert NumType <: Number
    best_match = CountdownSolver.NumberCombination(NumType(*(numbers...)))
    A = [CountdownSolver.NumberCombination(i) for i in numbers]
    timer = Timer(timeout)
    for i in 2:length(numbers)
        A_new = CountdownSolver.NumberCombination{NumType}[]
        for n1 in A, n2 in A, op in operators
            isopen(timer) || return best_match
            yield()
            if length(CountdownSolver.get_common_parents(n1, n2)) == 0
                try
                    n_new = op(n1, n2)
                    push!(A_new, n_new)
                    if abs(target - n_new.val) < abs(target - best_match.val)
                        print(
                        """
                        Current best match is:
                        $n_new
        
                        """
                        )
                        best_match = n_new
                    end
                    if best_match.val ≈ target
                        println("Found exact match, exiting.")
                        return best_match
                    end
                catch e
                    @debug e
                end
            end
        end
        append!(A, A_new)
    end
    return best_match
end