function extract_cells(file, ::Type{TI}=Int) where TI
    line = readline(file)

    cell_idx_pattern = r"^(\d*),"
    m = match(cell_idx_pattern, line)
    first_cell_idx = parse(TI, m[1])

    node_idx_pattern = r",\s(\d*)"
    local cells
    nodes = TI[]
    for m in eachmatch(node_idx_pattern, line)
        push!(nodes, parse(TI, m[1]))
    end
    cells = [Tuple(nodes)]

    _extract_cells!(cells, file, first_cell_idx)
    return cells, first_cell_idx-TI(1)
end

function _extract_cells!(cells::AbstractVector{NTuple{nnodes, TI}}, file, prev_cell_idx::TI) where {nnodes, TI}
    cell_idx_pattern = r"^(\d*),"
    node_idx_pattern = r",\s(\d*)"
    nodes = zeros(TI, nnodes)
    
    line = readline(file)
    while line != ""
        m = match(cell_idx_pattern, line)
        cell_idx = parse(TI, m[1])
        cell_idx == prev_cell_idx + TI(1) || throw("Cell indices are not consecutive.")

        nodes .= zero(TI)
        for (i, m) in enumerate(eachmatch(node_idx_pattern, line))
            nodes[i] = parse(TI, m[1])
        end
        all(nodes .!= zero(TI)) || throw("Cell $cell_idx has fewer nodes than it should.")
        push!(cells, Tuple(nodes))

        prev_cell_idx = cell_idx
        line = readline(file)
    end

    return
end
