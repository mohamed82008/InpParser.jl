function extract_nodes(file, ::Type{TF}=Float64, ::Type{TI}=Int) where {TF, TI}
    line = readline(file)

    pattern = r"(\d*),\s(-?\d*\.?\d*),\s(-?\d*\.?\d*)(,\s(-?\d*\.?\d*))?"
    m = match(pattern, line)
    
    first_node_idx = parse(TI, m[1])
    first_node_idx == TI(1) || throw("First node index is not 1.")

    if m[4] isa Void
        node_coords = [(parse(TF, m[2]), parse(TF, m[3]))]
        _extract_nodes!(node_coords, file, TI(1))
    else
        node_coords = [(parse(TF, m[2]), parse(TF, m[3]), parse(TF, m[5]))]
        _extract_nodes!(node_coords, file, TI(1))
    end
    return node_coords
end

function _extract_nodes!(node_coords::AbstractVector{NTuple{dim, TF}}, file, prev_node_idx::TI) where {dim, TF, TI}
    if dim === 2
        pattern = r"(\d*),\s(-?\d*\.?\d*),\s(-?\d*\.?\d*)"
    elseif dim === 3
        pattern = r"(\d*),\s(-?\d*\.?\d*),\s(-?\d*\.?\d*),\s(-?\d*\.?\d*)"
    else
        error("Dimension is not supported.")
    end

    line = readline(file)
    while line != ""
        m = match(pattern, line)
        node_idx = parse(Int, m[1])
        node_idx == prev_node_idx + TI(1) || throw("Node indices are not consecutive.")
        if dim === 2
            push!(node_coords, (parse(TF, m[2]), parse(TF, m[3])))
        else
            push!(node_coords, (parse(TF, m[2]), parse(TF, m[3]), parse(TF, m[4])))
        end
        prev_node_idx = node_idx
        line = readline(file)
    end
    return 
end
