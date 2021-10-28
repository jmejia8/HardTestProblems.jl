include("attributes.jl")

function PMM1_leader(x, y)
    k = min(length(x), length(y)) ÷ 2

    x1 = x[1:k]; x2 = x[k+1:end];
    y1 = y[1:k]

    q1 = sum( (y1 - x1.^3/100).^2 )
    q2 = 10 + y[k+1] + 1e6sum( y[k+2:end].^2 )
    
    r1 = -sum(x1.^2)
    r2 = -sum(x2.^2)

    p1 = q1 + r1
    p2 = q2 + r2
    F = abs(p1) + abs(p2)

    F, zeros(0), zeros(0)
end

function PMM1_follower(x, y)
    k = min(length(x), length(y)) ÷ 2

    x1 = x[1:k]; x2 = x[k+1:end];
    y1 = y[1:k]

    q1 = sum( (y1 - x1.^3/100).^2 )
    q2 = 10 + y[k+1] + 1e6sum( y[k+2:end].^2 )
    
    r1 = -sum(x1.^2)
    r2 = -sum(x2.^2)

    p1 = q1 + r1
    p2 = q2 + r2

    f = p1 + p2

    f, zeros(0), zeros(0)
end


function PMM2_leader(x, y)
    k = min(length(x), length(y)) ÷ 2

    ###########################
    q1 = (y[1]- x[1] *sin(x[1]) ).^2 + 1e6sum((y[2:k]- x[2:k] .* sin.(x[2:k]) ).^2)

    m = k+1:length(y)
    v = (y[m] - sqrt.(m))
    q2 = sum(v.^2) + sum(0.5v)^2 + sum(0.5v)^4
    
    x1 = x[1:k]; x2 = x[k+1:end];
    r1 = -sum(x1.^2)
    r2 = -x2[1]^2 - 1e6sum(x2[2:end].^2)
    ###########################

    p1 = q1 + r1
    p2 = q2 + r2

    F = abs(p1) + abs(p2)

    F, zeros(0), zeros(0)
end

function PMM2_follower(x, y)
    k = min(length(x), length(y)) ÷ 2

    ###########################
    q1 = (y[1]- x[1] *sin(x[1]) ).^2 + 1e6sum((y[2:k]- x[2:k] .* sin.(x[2:k]) ).^2)

    m = k+1:length(y)
    v = (y[m] - sqrt.(m))
    q2 = sum(v.^2) + sum(0.5v)^2 + sum(0.5v)^4
    
    x1 = x[1:k]; x2 = x[k+1:end];
    r1 = -sum(x1.^2)
    r2 = -x2[1]^2 - 1e6sum(x2[2:end].^2)
    ###########################

    p1 = q1 + r1
    p2 = q2 + r2

    f = p1 + p2

    f, zeros(0), zeros(0)
end


function PMM3_leader(x, y)
    k = min(length(x), length(y)) ÷ 2

    ###########################
    x1 = x[1:k]; x2 = x[k+1:end];
    y1 = y[1:k]; y2 = y[k+1:end];

    q1 = sum( (y1 - x1.^3/100).^2 )
    q2 = sum( 100(y2[1:end-1].^2 - y2[2:end]).^2 + (y2[1:end-1] .- 1).^2 )

    r1 = -sum(x1.^2)
    r2 = -sum(x2.^2)
    ###########################

    p1 = q1 + r1
    p2 = q2 + r2

    F = abs(p1) + abs(p2)

    F, zeros(0), zeros(0)
end

function PMM3_follower(x, y)
    k = min(length(x), length(y)) ÷ 2

    ###########################
    x1 = x[1:k]; x2 = x[k+1:end];
    y1 = y[1:k]; y2 = y[k+1:end];

    q1 = sum( (y1 - x1.^3/100).^2 )
    q2 = sum( 100(y2[1:end-1].^2 - y2[2:end]).^2 + (y2[1:end-1] .- 1).^2 )

    r1 = -sum(x1.^2)
    r2 = -sum(x2.^2)
    ###########################

    p1 = q1 + r1
    p2 = q2 + r2

    f = p1 + p2

    f, zeros(0), zeros(0)
end


function PMM4_leader(x, y)
    k = min(length(x), length(y)) ÷ 2

    ###########################
    x1 = x[1:k]; x2 = x[k+1:end];
    y1 = y[1:k]; y2 = y[k+1:end];

    q1 = sum( (y1 - 10 ./ (1 .+ 2.5*x1.^2)).^2 )
    q2 = 10length(y2) + sum(y2.^2 - 10cos.(2π*y2))

    r1 = -sum(x1.^2)
    r2 = -sum(x2.^2)
    ###########################

    p1 = q1 + r1
    p2 = q2 + r2

    F = abs(p1) + abs(p2)

    F, zeros(0), zeros(0)
end

function PMM4_follower(x, y)
    k = min(length(x), length(y)) ÷ 2

    ###########################
    x1 = x[1:k]; x2 = x[k+1:end];
    y1 = y[1:k]; y2 = y[k+1:end];

    q1 = sum( (y1 - 10 ./ (1 .+ 2.5*x1.^2)).^2 )
    q2 = 10length(y2) + sum(y2.^2 - 10cos.(2π*y2))

    r1 = -sum(x1.^2)
    r2 = -sum(x2.^2)
    ###########################

    p1 = q1 + r1
    p2 = q2 + r2

    f = p1 + p2

    f, zeros(0), zeros(0)
end


function PMM5_leader(x, y)
    k = min(length(x), length(y)) ÷ 2

    ###########################
    x1 = x[1:k]; x2 = x[k+1:end];
    y1 = y[1:k]; y2 = y[k+1:end];

    q1 = 10k + sum( (y1-x1).^2 - 10cos.(2π*abs.(y1-x1)))
    q2 = sum( abs.(y2).^(2:length(y2)+1) )

    r1 = -sum(x1.^2)
    r2 = -sum(x2.^2)
    ###########################

    p1 = q1 + r1
    p2 = q2 + r2

    F = abs(p1) + abs(p2)

    F, zeros(0), zeros(0)
end

function PMM5_follower(x, y)
    k = min(length(x), length(y)) ÷ 2

    ###########################
    x1 = x[1:k]; x2 = x[k+1:end];
    y1 = y[1:k]; y2 = y[k+1:end];

    q1 = 10k + sum( (y1-x1).^2 - 10cos.(2π*abs.(y1-x1)))
    q2 = sum( abs.(y2).^(2:length(y2)+1) )

    r1 = -sum(x1.^2)
    r2 = -sum(x2.^2)
    ###########################

    p1 = q1 + r1
    p2 = q2 + r2

    f = p1 + p2

    f, zeros(0), zeros(0)
end


function PMM6_leader(x, y)
    k = min(length(x), length(y)) ÷ 2

    ###########################
    x1 = x[1:k]; x2 = x[k+1:end];
    y1 = y[1:k]; y2 = y[k+1:end];

    q1 = 1 + (1/4)*sum((y1 - x1).^2) - prod(cos.(10(y1 - x1) / sqrt.(1:k)))
    q2 = 10length(y2) + sum(y2.^2 - 10cos.(2π*y2))

    r1 = -sum(x1.^2)
    r2 = -10length(x2) - sum(x2.^2 - 10cos.(2π*x2))
    ###########################

    p1 = q1 + r1
    p2 = q2 + r2

    F = abs(p1) + abs(p2)

    F, zeros(0), zeros(0)
end

function PMM6_follower(x, y)
    k = min(length(x), length(y)) ÷ 2

    ###########################
    x1 = x[1:k]; x2 = x[k+1:end];
    y1 = y[1:k]; y2 = y[k+1:end];

    q1 = 1 + (1/4)*sum((y1 - x1).^2) - prod(cos.(10(y1 - x1) / sqrt.(1:k)))
    q2 = 10length(y2) + sum(y2.^2 - 10cos.(2π*y2))

    r1 = -sum(x1.^2)
    r2 = -10length(x2) - sum(x2.^2 - 10cos.(2π*x2))
    ###########################

    p1 = q1 + r1
    p2 = q2 + r2

    f = p1 + p2

    f, zeros(0), zeros(0)
end

function PMM1_optimum(uldim, lldim)
    k = min(uldim, lldim) ÷ 2
    x = zeros(uldim)
    y = zeros(lldim)
    y[k+1] = -10
    return x, y
end


function PMM2_optimum(uldim, lldim)
    k = min(uldim, lldim) ÷ 2
    x = zeros(uldim)
    y = zeros(lldim)
    y[k+1:length(y)] = sqrt.(k+1:length(y))
    return x, y
end


function PMM3_optimum(uldim, lldim)
    k = min(uldim, lldim) ÷ 2
    x = zeros(uldim)
    y = zeros(lldim)
    y[k+1:length(y)] .= 1
    return x, y
end


function PMM4_optimum(uldim, lldim)
    k = min(uldim, lldim) ÷ 2
    x = zeros(uldim)
    y = zeros(lldim)
    y[1:k] .= 10
    return x, y
end


function PMM5_optimum(uldim, lldim)
    k = min(uldim, lldim) ÷ 2
    x = zeros(uldim)
    y = zeros(lldim)
    return x, y
end


function PMM6_optimum(uldim, lldim)
    k = min(uldim, lldim) ÷ 2
    x = zeros(uldim)
    y = zeros(lldim)
    return x, y
end

#=
const PMM6_optimum = PMM_optimum
PMM1_optimum = PMM2_optimum = PMM3_optimum = PMM4_optimum = PMM5_optimum = PMM6_optimum
=#
