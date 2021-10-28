include("attributes.jl")

function SMD1_leader(xu, xl)

    r = floor(Int,length(xu)/2)
    p = length(xu) - r
    q = length(xl) - r

    xu1 = xu[1:p]
    xu2 = xu[p+1:p+r]

    xl1 = xl[1:q]
    xl2 = xl[q+1:q+r]

    functionValue = sum((xu1).^2) + sum((xl1).^2) + sum((xu2).^2) + sum((xu2 - tan.(xl2)).^2)



    #####################################
    #Write the constraints here
    inequalityConstrVals = [0.0]
    equalityConstrVals = [0.0]
    #####################################
    #
    functionValue,equalityConstrVals,inequalityConstrVals
end

function SMD2_leader(xu, xl)

    r = floor(Int,length(xu)/2)
    p = length(xu) - r
    q = length(xl) - r

    xu1 = xu[1:p]
    xu2 = xu[p+1:p+r]

    xl1 = xl[1:q]
    xl2 = xl[q+1:q+r]

    functionValue = sum((xu1).^2) - sum((xl1).^2) + sum((xu2).^2) - sum((xu2 - log.(xl2)).^2)

    #####################################
    #Write the constraints here
    inequalityConstrVals = [0.0]
    equalityConstrVals = [0.0]
    #####################################

    functionValue,equalityConstrVals,inequalityConstrVals
end
function  SMD3_leader(xu, xl)

    r = floor(Int,length(xu)/2)
    p = length(xu) - r
    q = length(xl) - r

    xu1 = xu[1:p]
    xu2 = xu[p+1:p+r]

    xl1 = xl[1:q]
    xl2 = xl[q+1:q+r]


    functionValue = sum((xu1).^2) + sum((xl1).^2) + sum((xu2).^2) + sum((xu2.^2 - tan.(xl2)).^2)


    #####################################
    #Write the constraints here
    inequalityConstrVals = [0.0]
    equalityConstrVals = [0.0]
    #####################################

    functionValue,equalityConstrVals,inequalityConstrVals
end
function  SMD4_leader(xu, xl)

    r = floor(Int,length(xu)/2)
    p = length(xu) - r
    q = length(xl) - r

    xu1 = xu[1:p]
    xu2 = xu[p+1:p+r]

    xl1 = xl[1:q]
    xl2 = xl[q+1:q+r]

    functionValue = sum((xu1).^2) - sum((xl1).^2) + sum((xu2).^2) - sum((abs.(xu2) - log.(1 .+ xl2)).^2)


    #####################################
    #Write the constraints here
    inequalityConstrVals = [0.0]
    equalityConstrVals = [0.0]
    #####################################

    functionValue,equalityConstrVals,inequalityConstrVals
end
function  SMD5_leader(xu, xl)

    r = floor(Int,length(xu)/2)
    p = length(xu) - r
    q = length(xl) - r

    xu1 = xu[1:p]
    xu2 = xu[p+1:p+r]

    xl1 = xl[1:q]
    xl2 = xl[q+1:q+r]

    term2 = 0
    for i=1:q-1
        term2 = term2 + (xl1[i+1] - xl1[i].^2).^2 + (xl1[i] - 1).^2
    end

    #Same as SMD5
    functionValue = sum((xu1).^2) - term2 + sum((xu2).^2) - sum((abs.(xu2) - xl2.^2).^2)


    #####################################
    #Write the constraints here
    inequalityConstrVals = [0.0]
    equalityConstrVals = [0.0]
    #####################################

    functionValue,equalityConstrVals,inequalityConstrVals
end
function  SMD6_leader(xu, xl)

    r = floor(Int,length(xu)/2)
    p = length(xu) - r
    q = floor(Int,(length(xl) - r)/2 - eps())
    s = ceil(Int, (length(xl) - r)/2 + eps())

    xu1 = xu[1:p]
    xu2 = xu[p+1:p+r]

    xl1 = xl[1:q+s]
    xl2 = xl[q+s+1:q+s+r]

    functionValue = sum((xu1).^2) - sum(xl1[1:q].^2) + sum(xl1[q+1:q+s].^2) + sum((xu2).^2) - sum((xu2 - xl2).^2)


    #####################################
    #Write the constraints here
    inequalityConstrVals = [0.0]
    equalityConstrVals = [0.0]
    #####################################

    functionValue,equalityConstrVals,inequalityConstrVals
end
function  SMD7_leader(xu, xl)

    r = floor(Int,length(xu)/2)
    p = length(xu) - r
    q = length(xl) - r

    xu1 = xu[1:p]
    xu2 = xu[p+1:p+r]

    xl1 = xl[1:q]
    xl2 = xl[q+1:q+r]

    m = 1:p
    functionValue = 1+1/400*sum((xu1).^2) - prod(cos.(xu1./sqrt.(m))) - sum((xl1).^2) + sum((xu2).^2) - sum((xu2 - log.(xl2)).^2)


    #####################################
    #Write the constraints here
    inequalityConstrVals = [0.0]
    equalityConstrVals = [0.0]
    #####################################

    functionValue,equalityConstrVals,inequalityConstrVals
end
function  SMD8_leader(xu, xl)

    r = floor(Int,length(xu)/2)
    p = length(xu) - r
    q = length(xl) - r

    xu1 = xu[1:p]
    xu2 = xu[p+1:p+r]

    xl1 = xl[1:q]
    xl2 = xl[q+1:q+r]

    term2 = 0
    for i=1:q-1
        term2 += (xl1[i+1] - xl1[i].^2)^2 + (xl1[i] - 1).^2
    end

    functionValue = 20+exp(1)-20*exp(-0.2*sqrt.(1/p*sum((xu1).^2))) - exp(1/p*sum(cos.(2*pi*xu1)))  - term2 + sum((xu2).^2) - sum((xu2 - xl2.^3).^2)


    #####################################
    #Write the constraints here
    inequalityConstrVals = [0.0]
    equalityConstrVals = [0.0]
    #####################################

    functionValue,equalityConstrVals,inequalityConstrVals
end
function  SMD9_leader(xu, xl)

    r = floor(Int,length(xu)/2)
    p = length(xu) - r
    q = length(xl) - r

    xu1 = xu[1:p]
    xu2 = xu[p+1:p+r]

    xl1 = xl[1:q]
    xl2 = xl[q+1:q+r]

    functionValue = sum((xu1).^2) - sum((xl1).^2) + sum((xu2).^2) - sum((xu2 - log.(1 .+xl2)).^2)


    #####################################
    #Write the constraints here
    inequalityConstrVals = [sum(xu1.^2)+sum(xu2.^2) - floor.(sum(xu1.^2)+sum(xu2.^2)+0.5)]
    inequalityConstrVals = - inequalityConstrVals
    equalityConstrVals = [0.0]
    #####################################

    functionValue,equalityConstrVals,inequalityConstrVals
end
function  SMD10_leader(xu, xl)

    r = floor(Int,length(xu)/2)
    p = length(xu) - r
    q = length(xl) - r

    xu1 = xu[1:p]
    xu2 = xu[p+1:p+r]

    xl1 = xl[1:q]
    xl2 = xl[q+1:q+r]

    a = 2*ones(size(xu1))
    c = 2*ones(size(xu2))


    functionValue = sum((xu1 - a).^2) + sum((xl1).^2) + sum((xu2 - c).^2) - sum((xu2 - tan.(xl2)).^2)


    inequalityConstrVals = Float64[]
    #####################################
    #Write the constraints here
    for i=1:p
        push!(inequalityConstrVals, xu1[i] + xu1[i].^3 - sum(xu1.^3) - sum(xu2.^3))
    end

    for i=1:r
        push!(inequalityConstrVals, xu2[i] + xu2[i].^3 - sum(xu2.^3) - sum(xu1.^3))
    end

    inequalityConstrVals = - inequalityConstrVals
    equalityConstrVals = [0.0]
    #####################################

    functionValue,equalityConstrVals,inequalityConstrVals
end
function  SMD11_leader(xu, xl)

    r = floor(Int,length(xu)/2)
    p = length(xu) - r
    q = length(xl) - r

    xu1 = xu[1:p]
    xu2 = xu[p+1:p+r]

    xl1 = xl[1:q]
    xl2 = xl[q+1:q+r]

    functionValue = sum((xu1).^2) - sum((xl1).^2) + sum((xu2).^2) - sum((xu2 - log.(xl2)).^2)


    #####################################
    #Write the constraints here
    inequalityConstrVals = xu2 .- 1/sqrt(r) .- log.(xl2)
    inequalityConstrVals = - inequalityConstrVals
    equalityConstrVals = [0.0]
    #####################################

    functionValue,equalityConstrVals,inequalityConstrVals
end
function  SMD12_leader(xu, xl)

    r = floor(Int,length(xu)/2)
    p = length(xu) - r
    q = length(xl) - r

    xu1 = xu[1:p]
    xu2 = xu[p+1:p+r]

    xl1 = xl[1:q]
    xl2 = xl[q+1:q+r]

    a = 2*ones(size(xu1))
    c = 2*ones(size(xu2))

    functionValue = sum((xu1 - a).^2) + sum((xl1).^2) + sum((xu2 - c).^2) + sum(tan.(abs.(xl2))) - sum((xu2 - tan.(xl2)).^2)

    inequalityConstrVals = Float64[]
    #####################################
    #Write the constraints here
    for i=1:p
        push!(inequalityConstrVals, xu1[i] + xu1[i].^3 - sum(xu1.^3) - sum(xu2.^3))
    end

    for i=1:r
        push!(inequalityConstrVals, xu2[i] + xu2[i].^3 - sum(xu2.^3) - sum(xu1.^3))
    end

    inequalityConstrVals = vcat(inequalityConstrVals, xu2 - tan.(xl2))
    inequalityConstrVals = - inequalityConstrVals
    equalityConstrVals = [0.0]



    functionValue,equalityConstrVals,inequalityConstrVals
end


function  SMD1_follower(xu,xl)

    r = floor(Int,length(xu)/2)
    p = length(xu) - r
    q = length(xl) - r

    xu1 = xu[1:p]
    xu2 = xu[p+1:p+r]

    xl1 = xl[1:q]
    xl2 = xl[q+1:q+r]

    functionValue = sum((xu1).^2) + sum((xl1).^2) + sum((xu2 - tan.(xl2)).^2)


    #####################################
    #Write the constraints here
    inequalityConstrVals = [0.0]
    equalityConstrVals = [0.0]
    #####################################

    functionValue,equalityConstrVals,inequalityConstrVals
end
function  SMD2_follower(xu,xl)

    r = floor(Int,length(xu)/2)
    p = length(xu) - r
    q = length(xl) - r

    xu1 = xu[1:p]
    xu2 = xu[p+1:p+r]

    xl1 = xl[1:q]
    xl2 = xl[q+1:q+r]

    functionValue = sum((xu1).^2) + sum((xl1).^2) + sum((xu2 - log.(xl2)).^2)


    #####################################
    #Write the constraints here
    inequalityConstrVals = [0.0]
    equalityConstrVals = [0.0]
    #####################################

    functionValue,equalityConstrVals,inequalityConstrVals
end
function  SMD3_follower(xu,xl)

    r = floor(Int,length(xu)/2)
    p = length(xu) - r
    q = length(xl) - r

    xu1 = xu[1:p]
    xu2 = xu[p+1:p+r]

    xl1 = xl[1:q]
    xl2 = xl[q+1:q+r]

    functionValue = sum((xu1).^2) + q + sum(xl1.^2 - cos.(2*pi*xl1)) + sum((xu2.^2 - tan.(xl2)).^2)

    #####################################
    #Write the constraints here
    inequalityConstrVals = [0.0]
    equalityConstrVals = [0.0]
    #####################################

    functionValue,equalityConstrVals,inequalityConstrVals
end
function  SMD4_follower(xu,xl)

    r = floor(Int,length(xu)/2)
    p = length(xu) - r
    q = length(xl) - r

    xu1 = xu[1:p]
    xu2 = xu[p+1:p+r]

    xl1 = xl[1:q]
    xl2 = xl[q+1:q+r]


    functionValue = sum((xu1).^2) + q + sum(xl1.^2 - cos.(2*pi*xl1)) + sum((abs.(xu2) - log.(1 .+xl2)).^2)


    #####################################
    #Write the constraints here
    inequalityConstrVals = [0.0]
    equalityConstrVals = [0.0]
    #####################################

    functionValue,equalityConstrVals,inequalityConstrVals
end
function  SMD5_follower(xu,xl)

    r = floor(Int,length(xu)/2)
    p = length(xu) - r
    q = length(xl) - r

    xu1 = xu[1:p]
    xu2 = xu[p+1:p+r]

    xl1 = xl[1:q]
    xl2 = xl[q+1:q+r]

    term2 = 0
    for i=1:q-1
        term2 = term2 + (xl1[i+1] - xl1[i].^2)^2 + (xl1[i] - 1).^2
    end

    functionValue = sum((xu1).^2) + term2 + sum((abs.(xu2) - xl2.^2).^2)


    #####################################
    #Write the constraints here
    inequalityConstrVals = [0.0]
    equalityConstrVals = [0.0]
    #####################################

    functionValue,equalityConstrVals,inequalityConstrVals
end
function  SMD6_follower(xu,xl)

    r = floor(Int,length(xu)/2)
    p = length(xu) - r
    q = ceil(Int, (length(xl) - r)/2 - eps())
    s = floor(Int,(length(xl) - r)/2 + eps())

    xu1 = xu[1:p]
    xu2 = xu[p+1:p+r]

    xl1 = xl[1:q+s]
    xl2 = xl[q+s+1:q+s+r]

    term2 = sum(xl1[1:q].^2)
    for i=q+1:2:q+s-1
        term2 = term2 + (xl1[i+1] - xl1[i]).^2
    end

    functionValue = sum((xu1).^2) + term2 + sum((xu2 - xl2).^2)


    #####################################
    #Write the constraints here
    inequalityConstrVals = [0.0]
    equalityConstrVals = [0.0]
    #####################################

    functionValue,equalityConstrVals,inequalityConstrVals
end
function  SMD7_follower(xu,xl)

    r = floor(Int,length(xu)/2)
    p = length(xu) - r
    q = length(xl) - r

    xu1 = xu[1:p]
    xu2 = xu[p+1:p+r]

    xl1 = xl[1:q]
    xl2 = xl[q+1:q+r]

    functionValue = sum((xu1).^3) + sum((xl1).^2) + sum((xu2 - log.(xl2)).^2)


    #####################################
    #Write the constraints here
    inequalityConstrVals = [0.0]
    equalityConstrVals = [0.0]
    #####################################

    functionValue,equalityConstrVals,inequalityConstrVals
end
function  SMD8_follower(xu,xl)

    r = floor(Int,length(xu)/2)
    p = length(xu) - r
    q = length(xl) - r

    xu1 = xu[1:p]
    xu2 = xu[p+1:p+r]

    xl1 = xl[1:q]
    xl2 = xl[q+1:q+r]

    term2 = 0
    for i=1:q-1
        term2 = term2 + (xl1[i+1] - xl1[i].^2).^2 + (xl1[i] - 1).^2
    end

    functionValue = sum(abs.(xu1)) + term2 + sum((xu2 - xl2.^3).^2)


    #####################################
    #Write the constraints here
    inequalityConstrVals = [0.0]
    equalityConstrVals = [0.0]
    #####################################

    functionValue,equalityConstrVals,inequalityConstrVals
end
function  SMD9_follower(xu,xl)

    r = floor(Int,length(xu)/2)
    p = length(xu) - r
    q = length(xl) - r

    xu1 = xu[1:p]
    xu2 = xu[p+1:p+r]

    xl1 = xl[1:q]
    xl2 = xl[q+1:q+r]

    functionValue = sum((xu1).^2) + sum((xl1).^2) + sum((xu2 - log.(1 .+xl2)).^2)

    # functionValue = -functionValue

    #####################################
    #Write the constraints here
    inequalityConstrVals = [sum(xl1.^2)+sum(xl2.^2) - floor.(sum(xl1.^2)+sum(xl2.^2)+0.5)]
    inequalityConstrVals = - inequalityConstrVals
    equalityConstrVals = [0.0]
    #####################################

    functionValue,equalityConstrVals,inequalityConstrVals
end
function  SMD10_follower(xu,xl)

    r = floor(Int,length(xu)/2)
    p = length(xu) - r
    q = length(xl) - r

    xu1 = xu[1:p]
    xu2 = xu[p+1:p+r]

    xl1 = xl[1:q]
    xl2 = xl[q+1:q+r]

    b = 2*ones(size(xl1))

    functionValue = sum((xu1).^2) + sum((xl1 - b).^2) + sum((xu2 - tan.(xl2)).^2)


    #####################################
    #Write the constraints here
    inequalityConstrVals = zeros(q)
    for i=1:q
        inequalityConstrVals[i] = xl1[i] + xl1[i].^3 - sum(xl1.^3)
    end
    inequalityConstrVals = - inequalityConstrVals
    equalityConstrVals = [0.0]
    #####################################

    functionValue,equalityConstrVals,inequalityConstrVals
end
function  SMD11_follower(xu,xl)

    r = floor(Int,length(xu)/2)
    p = length(xu) - r
    q = length(xl) - r

    xu1 = xu[1:p]
    xu2 = xu[p+1:p+r]

    xl1 = xl[1:q]
    xl2 = xl[q+1:q+r]

    functionValue = sum((xu1).^2) + sum((xl1).^2) + sum((xu2 - log.(xl2)).^2)


    #####################################
    #Write the constraints here
    inequalityConstrVals = [sum((xu2 - log.(xl2)).^2) - 1]
    inequalityConstrVals = - inequalityConstrVals
    equalityConstrVals = [0.0]
    #####################################

    functionValue,equalityConstrVals,inequalityConstrVals
end
function  SMD12_follower(xu,xl)

    r = floor(Int,length(xu)/2)
    p = length(xu) - r
    q = length(xl) - r

    xu1 = xu[1:p]
    xu2 = xu[p+1:p+r]

    xl1 = xl[1:q]
    xl2 = xl[q+1:q+r]

    b = 2*ones(size(xl1))

    functionValue = sum((xu1).^2) + sum((xl1 - b).^2) + sum((xu2 - tan.(xl2)).^2)


    #####################################
    #Write the constraints here
    inequalityConstrVals = zeros(q+1)
    for i=1:q
        inequalityConstrVals[i] = xl1[i] + xl1[i].^3 - sum(xl1.^3)
    end
    inequalityConstrVals[q+1] = sum((xu2 - tan.(xl2)).^2) - 1
    inequalityConstrVals = - inequalityConstrVals
    equalityConstrVals = [0.0]
    #####################################

    functionValue,equalityConstrVals,inequalityConstrVals
end
