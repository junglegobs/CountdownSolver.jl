"""
    NumbComb

A type which represents a combination of rational numbers using the operators +, -, * and +.
For this type, `parents` gives the `NumbComb`s required to produce `val` in conjunction with `operators`.

# Fields
`val::Rational{Integer}`

`operators::Vector{Function}`

`parents::Vector{NumbComb}`
"""
mutable struct NumbComb
    val::Rational{Integer}
    operators::Vector{Function}
    parents::Vector{NumbComb}

    NumbComb() = (n = new(); n.parents = typeof(n)[]; n)
    function NumbComb(val,op,par)
        n = NumbComb(); n.val = val; n.operators = op; n.parents = par;
        @assert is_valid_number_combination(n) "You can't use the same number twice!"
        return n
    end
    NumbComb(val) = (n = NumbComb(val, Function[], NumbComb[]))

    Base.:+(n1::NumbComb, n2::NumbComb) = NumbComb(n1.val + n2.val, Function[+], [n1,n2])
    Base.:-(n1::NumbComb, n2::NumbComb) = NumbComb(n1.val - n2.val, Function[-], [n1,n2])
    Base.:*(n1::NumbComb, n2::NumbComb) = NumbComb(n1.val * n2.val, Function[*], [n1,n2])
    Base.:/(n1::NumbComb, n2::NumbComb) = NumbComb(n1.val / n2.val, Function[/], [n1,n2])

    function Base.show(io::IO, n::NumbComb)
        if isempty(n.parents)
            print(io, n.val)
        else
            list = get_parent_operator_list(n)
            pretty_list = expand_parent_operator_list_as_string(list)
            print(io, "$(n.val) obtained by: ", pretty_list...)
        end
    end
end

function get_original_parents(n::NumbComb, pVec::Vector{NumbComb})
    if isempty(n.parents)
        push!(pVec, n)
    else
        for p in n.parents
            get_original_parents(p, pVec)
        end
    end
    return pVec
end
get_original_parents(n::NumbComb) = get_original_parents(n, NumbComb[])

function get_common_parents(n1::NumbComb, n2::NumbComb)
    p1 = get_original_parents(n1)
    p2 = get_original_parents(n2)
    return find_common(p1, p2)
end

function is_valid_number_combination(n::NumbComb)
    par = get_original_parents(n)
    return length(unique(par)) == length(par)
end

function get_parent_operator_list(n::NumbComb)
    list = []
    for i in 1:length(n.parents) + length(n.operators)
        if isodd(i)
            j = Int((i-1)/2 + 1)
            if isempty(n.parents[j].parents)
                push!(list, n.parents[j])
            else
                push!(list, get_parent_operator_list(n.parents[j]))
            end
        else
            j = Int(i/2)
            push!(list, n.operators[j])
        end
    end
    return list
end

function expand_parent_operator_list_as_string(list::Vector)
    strList = []
    for el in list
        if typeof(el) <: Vector
            el_append = expand_parent_operator_list_as_string(el)
            push!(strList, "(")
            append!(strList, el_append)
            push!(strList, ")")
        elseif typeof(el) <: NumbComb
            push!(strList, string(Int(el.val)))
            elseif typeof(el) <: Rational
            push!(strList, string(Int(el)))
        else
            push!(strList, " ")
            push!(strList, el)
            push!(strList, " ")
        end
    end
    return strList
end
