function extract_nodedbcs!(node_dbcs::Dict{String, Vector{Tuple{TI,TF}}}, file) where {TI, TF}
    pattern_zero = r"([^,]*),(\d)"    
    pattern_other = r"([^,]*),(\d),\d,(\-?\d*\.\d*)"
    line = readline(file)
    while line != ""
        m = match(pattern_other, line)
        if m != nothing
            nodesetname = m[1]
            dof = parse(TI, m[2])
            val = parse(TF, m[3])
            if haskey(node_dbcs, nodesetname)
                push!(node_dbcs[nodesetname], (dof, val))
            else
                node_dbcs[nodesetname] = [(dof, val)]
            end
        end
        m = match(pattern_zero, line)
        if m != nothing
            nodesetname = m[1]
            dof = parse(TI, m[2])
            if haskey(node_dbcs, nodesetname)
                push!(node_dbcs[nodesetname], (dof, zero(TF)))
            else
                node_dbcs[nodesetname] = [(dof, zero(TF))]
            end
        end
        line = readline(file)
    end
    return 
end
