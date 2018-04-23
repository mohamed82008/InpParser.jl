function extract_cload!(cloads::Dict{TI, Vector{TF}}, file, ::Type{Val{dim}}) where {TI, TF, dim}
    pattern = r"(\d*),(\d),(\-?\d*\.\d*E[\+\-]\d{2})"
    line = readline(file)
    while !contains(line, "*"^59)
        m = match(pattern, line)
        if m != nothing
            nodeidx = parse(TI, m[1])
            dof = parse(Int, m[2])
            load = parse(TF, m[3])
            if haskey(cloads, nodeidx)
                cloads[nodeidx][dof] += load
            else
                cloads[nodeidx] = zeros(TF, dim)
                cloads[nodeidx][dof] = load
            end
        end
        line = readline(file)
    end
    return 
end
