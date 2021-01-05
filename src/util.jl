function find_common(x, y)
    common = NumberCombination[]
    for i in 1:length(x)
        for j in 1:length(y)
            if @inbounds x[i] == y[j]
                push!(common, x[i])
            end
        end
    end
    return common
end