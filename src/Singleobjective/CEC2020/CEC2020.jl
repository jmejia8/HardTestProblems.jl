# load all stuff here
const o = zeros(0)
const M = zeros(0,0)


shift_and_rotate(X, o, M) = (X .- o)*M'
function rastrigin(X)
    X = 0.0512*X;
    return sum(X.^2 - 10cos.(2π*X) .+ 10, 2);
end

elliptic(X) = sum((1e6).^((0:size(X,2)-1)'/(size(X,2)-1+1e-6)) .* X.^2, dims = 2)

function schaffer(X)
    X = X .^ 2
    mask = vcat(2:size(X, 2),1)
    return sum(0.5.+(sin.(sqrt.(X.+X[:,mask])).^2-0.5)./(1 .+ 0.001*(X+X[:,mask])).^2, dims = 2)
end

function HGBat(X)
    X = 0.05X .- 1;
    sq = sum(X.^2, dims = 2)
    s = sum(X, dims = 2)
    return sqrt.(abs.(sq.^2 - s.^2)) + (0.5*sq + s)/size(X,2) .+ 0.5;
end

function rosenbrock(X)
    X = 0.02048*X .+ 1;
    sum(100*(X[:,1:end-1].^2-X[:,2:end]).^2+(X[:,1:end-1]-1).^2, dims = 2);
end

function griewank(X)
    X = 6*X;
    return sum(X.^2,dims=2)/4000 - prod(cos.(X)./sqrt.(1:size(X,2)), dims=2) .+ 1;
end

ackley(X) = -20exp.(-0.2*sqrt.(mean(X.^2,dims=2))) - exp.(mean(cos.(2*pi*X),dims=2)) .+(20 + exp(1))

########################3

# base function here
bent_cigar(X) = 100 .+ X[:,1].^2 + 1e6*sum(X[:,2:end].^2,2)

function schwefel(X)
    D = size(X,2)
    Z = 10X + 4.2097e2
    g = Z .* sin.(sqrt.(abs.(Z)))
    mask = Z .> 500
    temp = 500 - mod.(Z[mask],500)
    g[mask] = temp.*sin(sqrt(abs(temp))) - (Z[mask]-500).^2/10000/D

    mask = Z .< -500 
    temp = mod(abs(Z[mask]),500) - 500
    g[mask] = temp.*sin.(sqrt.(abs.(temp))) - (Z[mask] .- 500)/10000/D
    return 1100 + 418.9829*D .- sum(g,2)
end

function bi_rastrigin(X, O, M)
    D = size(X,2)
    s   = 1 - 1/(2*sqrt(D+20)-8.2)
    mu0 = 2.5
    mu1 = -sqrt((mu0^2-1)/s)
    Y   = (X .- O)/10
    tmp = 2O.*Y .+ mu0
    Z   = (tmp .- mu0) * M'
    F = 700 .+ min.(sum((tmp-mu0).^2, dims=2), D+s*sum((tmp-mu1).^2, dims = 2)) 
    F += 10*(D - sum(cos.(2π*Z), dims = 2))
    return F
end

function rosenbrock_plus_griewangk(X)
    Y = 0.05X;
    Z = Y + 1;
    temp   = 100*(Z.^2-Z[:, vcat(2:end,1)]).^2 + (Z-1).^2;
    return 1900 .+ sum(temp.^2/4000-cos(temp)+1, dims = 2);
end

function hybrid1(X, masks)
    1700 .+ schwefel( Z[:, masks[1]]) .+ rastrigin(Z[:, masks[2]]) .+ elliptic( Z[:, masks[3]])
end
function hybrid2(X, masks)
    return 1600 .+ 
    schaffer(Z[:,masks[1]]) .+
    HGBat(Z[:,masks[2]]) .+
    rosenbrock(Z[:,mask[3]]) .+
    schwefel(Z[:,mask[4]])
end

function hybrid3(Z, S)
    return 2100 .+
    schaffer(Z[:,S[1]]) .+
    HGBat(Z[:,S[2]]) .+
    rosenbrock(Z[:,S[3]]) .+
    schwefel(Z[:,S[4]]) .+
    elliptic(Z[:,S[5]])
end

function composition1(X)
    λ  = [1 10 1]
    δ  = [10 20 30]
    bias   = [0 100 200]
    func   = [rastrigin, griewank, schwefel]
    W      = zeros(size(X,1),3);
    F      = zeros(size(W));
    D = size(X,1)

    for i = 1 : size(W,2)
        tmp    = sum((X .- o).^2, dims = 2)
        W[:,i] = 1./(sqrt.(tmp) .+ 1e-10) .* exp.(-tmp/2/D/δ[i]^2)
        F[:,i] = func[i]((X-O[i,1:size(X,2)])*M[(i-1)*D+1:i*D,:]')
    end

    W = W ./ sum(W, dims=2);
    return 2200 .+ sum(W.*(λ.*F .+ bias), dims=2);
end

function composition2(X)
    λ = [10 1e-6 10 1]
    δ  = [10 20 30 40]
    bias   = [0 100 200 300]
    func   = [ackley,elliptic,griewank,rastrigin]
    W      = zeros(size(X,1),4)
    F      = zeros(size(W))
    D = size(X,1)
    
    for i = 1 : size(W,2)
        tmp    = sum((X .- o).^2, dims = 2)
        W[:,i] = 1./(sqrt.(tmp) .+ 1e-10) .* exp.(-tmp/2/D/δ[i]^2)
        F[:,i] = func[i]((X-O[i,1:size(X,2)])*M[(i-1)*D+1:i*D,:]')
    end

    W = W ./ sum(W, dims=2);
    return 2400 .+ sum(W.*(λ.*F .+ bias), dims=2);
end


function composition3(X)
    λ = [10 1 10 1e-6 1]
    δ  = [10 20 30 40 50]
    bias   = [0 100 200 300 400]
    func   = [rastrigin,happycat,ackley,discus,rosenbrock]
    W      = zeros(size(X,1),5)
    F      = zeros(size(W))
    D = size(X,1)

    for i = 1 : size(W,2)
        tmp    = sum((X .- o).^2, dims = 2)
        W[:,i] = 1./(sqrt.(tmp) .+ 1e-10) .* exp.(-tmp/2/D/δ[i]^2)
        F[:,i] = func[i]((X-O[i,1:size(X,2)])*M[(i-1)*D+1:i*D,:]')
    end

    W = W ./ sum(W, dims=2);
    return 5500 .+ sum(W.*(λ.*F .+ bias), dims=2);
end




# wrappers
cec2021_f1(x) = bent_cigar(shift_and_rotate(x, o, M))
cec2021_f2(x) = schwefel(shift_and_rotate(x, o, M))
cec2021_f3(x) = bi_rastrigin(x, o, M)
cec2021_f4(x) = rosenbrock_plus_griewangk(shift_and_rotate(x, o, M))
cec2021_f5(x) = hybrid1(shift_and_rotate(x, o, M), masks)
cec2021_f6(x) = hybrid2(shift_and_rotate(x, o, M), masks)
cec2021_f7(x) = hybrid3(shift_and_rotate(x, o, M), masks)
cec2021_f8(x) = composition1(shift_and_rotate(x, o, M), masks)
cec2021_f9(x) = composition2(shift_and_rotate(x, o, M), masks)
cec2021_f10(x) = composition3(shift_and_rotate(x, o, M), masks)
# pending the 9th function
