include("attributes.jl")

shift_and_rotate(X, o, M) = (X .- o[1,1:size(X, 2)]')*M'

function rastrigin(X)
    X = 0.0512*X;
    return sum(X.^2 - 10cos.(2π*X) .+ 10, dims = 2);
end

elliptic(X) = sum((1e6).^((0:size(X,2)-1)'/(size(X,2)-1+1e-6)) .* X.^2, dims = 2)

function schaffer(X)
    X = X .^ 2
    mask = vcat(2:size(X, 2),1)
    return sum(0.5.+(sin.(sqrt.(X.+X[:,mask])).^2 .-0.5)./(1 .+ 0.001*(X+X[:,mask])).^2, dims = 2)
end

function HGBat(X)
    X = 0.05X .- 1;
    sq = sum(X.^2, dims = 2)
    s = sum(X, dims = 2)
    return sqrt.(abs.(sq.^2 - s.^2)) + (0.5*sq + s)/size(X,2) .+ 0.5;
end

function rosenbrock(X)
    X = 0.02048*X .+ 1;
    sum(100*(X[:,1:end-1].^2-X[:,2:end]).^2+(X[:,1:end-1] .- 1).^2, dims = 2);
end

function griewank(X)
    X = 6X;
    return sum(X.^2,dims=2)/4000 - prod(cos.(X) ./ sqrt.(1:size(X,2))', dims=2) .+ 1;
end

ackley(X) = -20exp.(-0.2*sqrt.(mean(X.^2,dims=2))) - exp.(mean(cos.(2*pi*X),dims=2)) .+(20 + exp(1))

function happycat(X)
    X = 0.05*X;
    sq = sum(X.^2, dims=2)
    D = size(X,2)
    return abs.(sq.-D).^0.25 + (0.5*sq+sum(X,dims=2))/D .+ 0.5;
end

discus(X) = 1e6*X[:,1].^2 + sum(X[:,2:end].^2, dims=2);

########################3

# base function here
bent_cigar(X) = 100 .+ X[:,1].^2 + 1e6*sum(X[:,2:end].^2, dims = 2)

function schwefel(X)
    D = size(X,2)
    Z = 10X .+ 4.2097e2
    g = Z .* sin.(sqrt.(abs.(Z)))
    mask = Z .> 500
    temp = 500 .- mod.(Z[mask],500)
    g[mask] = temp.*sin.(sqrt.(abs.(temp))) - (Z[mask].-500).^2/10000/D

    mask = Z .< -500 
    temp = mod.(abs.(Z[mask]),500) .- 500
    g[mask] = temp.*sin.(sqrt.(abs.(temp))) - (Z[mask] .- 500)/10000/D
    return 1100 .+ 418.9829*D .- sum(g, dims = 2)
end

function bi_rastrigin(X, O, M)
    D = size(X,2)
    O = O[1,1:D]'
    s   = 1 - 1/(2*sqrt(D+20)-8.2)
    mu0 = 2.5
    mu1 = -sqrt((mu0^2-1)/s)
    Y   = (X .- O)/10
    tmp = 2O.*Y .+ mu0
    Z   = (tmp .- mu0) * M'
    F = 700 .+ min.(sum((tmp .- mu0).^2, dims=2), D .+ s*sum((tmp .- mu1).^2, dims = 2)) 
    F += 10*(D .- sum(cos.(2π*Z), dims = 2))
    return F
end

function rosenbrock_plus_griewangk(X)
    Y = 0.05X;
    Z = Y .+ 1;
    temp   = 100*(Z.^2-Z[:, vcat(2:end,1)]).^2 + (Z .- 1).^2;
    return 1900 .+ sum(temp.^2/4000-cos.(temp) .+ 1, dims = 2);
end

function hybrid1(X, S)
    1700 .+ schwefel( X[:, S[1]]) .+ rastrigin(X[:, S[2]]) .+ elliptic(X[:, S[3]])
end
function hybrid2(X, S)
    return 1600 .+ 
    schaffer(X[:,S[1]]) .+
    HGBat(X[:,S[2]]) .+
    rosenbrock(X[:,S[3]]) .+
    schwefel(X[:,S[4]])
end

function hybrid3(Z, S)
    return 2100 .+
    schaffer(Z[:,S[1]]) .+
    HGBat(Z[:,S[2]]) .+
    rosenbrock(Z[:,S[3]]) .+
    schwefel(Z[:,S[4]]) .+
    elliptic(Z[:,S[5]])
end

function composition1(X, O, M)
    λ  = [1 10 1]
    δ  = [10 20 30]
    bias   = [0 100 200]
    W      = zeros(size(X,1),3);
    F      = zeros(size(W));
    D = size(X,2)

    for (i, f) in enumerate([rastrigin, griewank, schwefel])
        o = O[i,1:D]'
        tmp    = sum((X .- o).^2, dims = 2)
        W[:,i] = 1 ./ (sqrt.(tmp) .+ 1e-10) .* exp.(-tmp/2/D/δ[i]^2)
        F[:,i] = f((X .- o)*M[(i-1)*D+1:i*D,:]')
    end

    W = W ./ sum(W, dims=2);
    return 2200 .+ sum(W.*(λ.*F .+ bias), dims=2);
end


function composition2(X, O, M)
    λ = [10 1e-6 10 1]
    δ  = [10 20 30 40]
    bias   = [0 100 200 300]
    
    W      = zeros(size(X,1),4)
    F      = zeros(size(W))
    D = size(X,2)
    
    for (i, f) in enumerate([ackley,elliptic,griewank,rastrigin])
        o = O[i,1:D]'
        Z = (X .- o)
        M_ = M[(i-1)*D+1:i*D,:]'
        tmp    = sum(Z.^2, dims = 2)
        W[:,i] = 1 ./ (sqrt.(tmp) .+ 1e-10) .* exp.(-tmp/2/D/δ[i]^2)
        F[:,i] = f(Z*M_)
    end

    W = W ./ sum(W, dims=2);
    return 2400 .+ sum(W.*(λ.*F .+ bias), dims=2);
end


function composition3(X, O, M)
    λ = [10 1 10 1e-6 1]
    δ  = [10 20 30 40 50]
    bias   = [0 100 200 300 400]
    W      = zeros(size(X,1),5)
    F      = zeros(size(W))
    D = size(X,2)

    for (i, f) in enumerate([rastrigin,happycat,ackley,discus,rosenbrock])
        o = O[i,1:D]'
        tmp    = sum((X .- o).^2, dims = 2)
        W[:,i] = 1 ./ (sqrt.(tmp) .+ 1e-10) .* exp.(-tmp/2/D/δ[i]^2)
        F[:,i] = f((X .- o)*M[(i-1)*D+1:i*D,:]')
    end

    W = W ./ sum(W, dims=2);
    return 5500 .+ sum(W.*(λ.*F .+ bias), dims=2);
end



function cec2020_f1(x)
    D = (size(x,2))
    o, M, _ = load_data_from_dict(1, D)
    bent_cigar(shift_and_rotate(x, o, M))
end

function cec2020_f2(x)
    D = (size(x,2))
    o, M, _ = load_data_from_dict(2, D)
    schwefel(shift_and_rotate(x, o, M))
end

function cec2020_f3(x)
    D = (size(x,2))
    o, M, _ = load_data_from_dict(3, D)
    bi_rastrigin(x, o, M)
end

function cec2020_f4(x) 
    D = (size(x,2))
    o, M, _ = load_data_from_dict(4, D)
    rosenbrock_plus_griewangk(shift_and_rotate(x, o, M))
end

function cec2020_f5(x) 
    D = (size(x,2))
    o, M, S_ = load_data_from_dict(5, D)
    p     = ceil.(Int, D*[0.3, 0.3, 0.4])
    p[1]  = D - sum(p[2:end])
    p     = vcat(0,cumsum(p))
    S = [S_[p[i]+1:p[i+1]] for i in 1:length(p)-1]
    hybrid1(shift_and_rotate(x, o, M), S)
end

function cec2020_f6(x) 
    D = size(x,2)
    o, M, S_ = load_data_from_dict(6, D)

    if D == 5
        p = [1, 1, 1, 2]
    else
        p = ceil.(Int, D*[0.2, 0.2, 0.3, 0.3])
        p[1]  = D - sum(p[2:end])
    end
    
    p     = vcat(0,cumsum(p))
    S = [S_[p[i]+1:p[i+1]] for i in 1:length(p)-1]

    hybrid2(shift_and_rotate(x, o, M), S)
end

function cec2020_f7(x) 
    D = (size(x,2))
    o, M, S_ = load_data_from_dict(7, D)

    if D == 5
        p = ones(Int, 5)
    else
        p = ceil.(Int, D*[0.1, 0.2, 0.2, 0.2, 0.3])
        p[1]  = D - sum(p[2:end])
    end
    
    p     = vcat(0,cumsum(p))
    S = [S_[p[i]+1:p[i+1]] for i in 1:length(p)-1]
    hybrid3(shift_and_rotate(x, o, M), S)
end

function cec2020_f8(x) 
    D = (size(x,2))
    O, M, _ = load_data_from_dict(8, D)
    composition1(x, O, M)
end

function cec2020_f9(x) 
    D = (size(x,2))
    O, M, _ = load_data_from_dict(9, D)
    composition2(x, O, M)
end

function cec2020_f10(x)
    D = (size(x,2))
    O, M, _ = load_data_from_dict(10, D)
    composition3(x, O, M)
end

cec2020_f1(x::AbstractVector{T}) where T <: Real = cec2020_f1(x')[1]
cec2020_f2(x::AbstractVector{T}) where T <: Real = cec2020_f2(x')[1]
cec2020_f3(x::AbstractVector{T}) where T <: Real = cec2020_f3(x')[1]
cec2020_f4(x::AbstractVector{T}) where T <: Real = cec2020_f4(x')[1]
cec2020_f5(x::AbstractVector{T}) where T <: Real = cec2020_f5(x')[1]
cec2020_f6(x::AbstractVector{T}) where T <: Real = cec2020_f6(x')[1]
cec2020_f7(x::AbstractVector{T}) where T <: Real = cec2020_f7(x')[1]
cec2020_f8(x::AbstractVector{T}) where T <: Real = cec2020_f8(x')[1]
cec2020_f9(x::AbstractVector{T}) where T <: Real = cec2020_f9(x')[1]
cec2020_f10(x::AbstractVector{T}) where T <: Real = cec2020_f10(x')[1]


export cec2020_f1, cec2020_f2, cec2020_f3, cec2020_f4, cec2020_f5
export cec2020_f6, cec2020_f7, cec2020_f8, cec2020_f9, cec2020_f10
export  get_cec2020_minimum, get_cec2020_problem
