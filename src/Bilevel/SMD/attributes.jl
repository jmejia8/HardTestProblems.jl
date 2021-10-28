const epsi = 0.00001

function SMD1_optimum(upperDimensions,lowerDimensions)

    r = floor(Int,upperDimensions/2)
    p = upperDimensions - r
    q = lowerDimensions - r

    upperMember = zeros(upperDimensions)
    lowerMember = zeros(lowerDimensions)

    upperMember, lowerMember
end

function SMD2_optimum(upperDimensions,lowerDimensions)

    r = floor(Int,upperDimensions/2)
    p = upperDimensions - r
    q = lowerDimensions - r

    upperMember = zeros(upperDimensions)
    lowerMember = [zeros(q); ones(r)]

    upperMember, lowerMember
end

function SMD3_optimum(upperDimensions,lowerDimensions)

    r = floor(Int,upperDimensions/2)
    p = upperDimensions - r
    q = lowerDimensions - r

    upperMember = zeros(upperDimensions)
    lowerMember = zeros(lowerDimensions)

    upperMember, lowerMember
end

function SMD4_optimum(upperDimensions,lowerDimensions)

    r = floor(Int,upperDimensions/2)
    p = upperDimensions - r
    q = lowerDimensions - r

    upperMember = zeros(upperDimensions)
    lowerMember = zeros(lowerDimensions)

    upperMember, lowerMember
end

function SMD5_optimum(upperDimensions,lowerDimensions)

    r = floor(Int,upperDimensions/2)
    p = upperDimensions - r
    q = lowerDimensions - r

    upperMember = zeros(upperDimensions)
    lowerMember = [ones(q); zeros(r)]

    upperMember, lowerMember
end

function SMD6_optimum(upperDimensions,lowerDimensions)

    r = floor(Int,upperDimensions/2)
    p = upperDimensions - r
    q = floor(Int,(lowerDimensions - r)/2 - epsi)
    s = ceil(Int, (lowerDimensions - r)/2 + epsi)

    upperMember = zeros(upperDimensions)
    lowerMember = zeros(lowerDimensions)

    upperMember, lowerMember
end

function SMD7_optimum(upperDimensions,lowerDimensions)

    r = floor(Int,upperDimensions/2)
    p = upperDimensions - r
    q = lowerDimensions - r

    upperMember = zeros(upperDimensions)
    lowerMember = [zeros(q); ones(r)]

    upperMember, lowerMember
end

function SMD8_optimum(upperDimensions,lowerDimensions)

    r = floor(Int,upperDimensions/2)
    p = upperDimensions - r
    q = lowerDimensions - r

    upperMember = zeros(upperDimensions)
    lowerMember = [ones(q); zeros(r)]

    upperMember, lowerMember
end

function SMD9_optimum(upperDimensions,lowerDimensions)

    r = floor(Int,upperDimensions/2)
    p = upperDimensions - r
    q = lowerDimensions - r

    upperMember = zeros(upperDimensions)
    lowerMember = zeros(lowerDimensions)

    upperMember, lowerMember
end

function SMD10_optimum(upperDimensions,lowerDimensions)

    r = floor(Int,upperDimensions/2)
    p = upperDimensions - r
    q = lowerDimensions - r

    upperMember = 1/sqrt(p+r-1)*ones(upperDimensions)
    lowerMember = [1/sqrt(q-1)*ones(q); atan.(1/sqrt(p+r-1)*ones(r))]

    upperMember, lowerMember
end

function SMD11_optimum(upperDimensions,lowerDimensions)

    r = floor(Int,upperDimensions/2)
    p = upperDimensions - r
    q = lowerDimensions - r

    upperMember = zeros(upperDimensions)
    lowerMember = [zeros(q); exp(-1/sqrt(r))*ones(r)]

    upperMember, lowerMember
end

function SMD12_optimum(upperDimensions,lowerDimensions)

    r = floor(Int,upperDimensions/2)
    p = upperDimensions - r
    q = lowerDimensions - r

    upperMember = 1/sqrt(p+r-1)*ones(upperDimensions)
    lowerMember = [1/sqrt(q-1)*ones(q); atan.(1/sqrt(p+r-1)-1/sqrt(r))*ones(r)]

    upperMember, lowerMember
end

function SMD13_optimum(upperDimensions,lowerDimensions)

    r = floor(Int,upperDimensions/2)
    p = upperDimensions - r
    q = lowerDimensions - r

    upperMember = [ones(p); zeros(r)]
    lowerMember = [zeros(p); ones(r)]

    upperMember, lowerMember
end

function SMD14_optimum(upperDimensions,lowerDimensions)

    r = floor(Int,upperDimensions/2)
    p = upperDimensions - r
    q = floor(Int,(lowerDimensions - r)/2 - epsi)
    s = ceil(Int, (lowerDimensions - r)/2 + epsi)

    upperMember = [ones(p); zeros(r)]
    lowerMember = zeros(lowerDimensions)


    upperMember, lowerMember
end



function SMD_ranges(fno, ulDim, llDim)
    if fno == 6
        r = floor(Int, ulDim/2)
        p = ulDim - r
        q = floor(Int, (llDim - r)/2 - epsi)
        s = ceil((llDim - r)/2 + epsi)
    elseif fno in [1,2,3,4,5,7,8,9,10,11,12]
        r = floor(Int, ulDim/2) 
        p = ulDim - r 
        q = llDim - r
    end

    if fno ==  1 #ok
        ulDimMin = -5*ones(ulDim)                    
        ulDimMax = 10*ones(ulDim)                    
        llDimMin = [-5*ones(q); -pi/2*ones(r).+epsi]  
        llDimMax = [10*ones(q);  pi/2*ones(r).-epsi]  
    elseif fno ==  2 #ok
        ulDimMin = -5*ones(ulDim) 
        ulDimMax = [10*ones(p); 1*ones(r)]
        llDimMin = [-5*ones(q); epsi*ones(r)]
        llDimMax = [10*ones(q); exp(1)*ones(r)]
    elseif fno ==  3 #ok
        ulDimMin = -5*ones(ulDim)
        ulDimMax = 10*ones(ulDim)
        llDimMin = [-5*ones(q); -pi/2*ones(r).+epsi]
        llDimMax = [10*ones(q);  pi/2*ones(r).-epsi]
    elseif fno ==  4 #ok
        ulDimMin = [-5*ones(p); -1*ones(r)]
        ulDimMax = [10*ones(p); 1*ones(r)]
        llDimMin = [-5*ones(q); zeros(r)]
        llDimMax = [10*ones(q); exp(1)*ones(r)]
    elseif fno ==  5 #ok
        ulDimMin = -5*ones(ulDim)
        ulDimMax = 10*ones(ulDim)
        llDimMin = [-5*ones(q); -5*ones(r)]
        llDimMax = [10*ones(q); 10*ones(r)]
    elseif fno ==  6 #ok
        ulDimMin = -5*ones(ulDim)
        ulDimMax = 10*ones(ulDim)
        llDimMin = -5*ones(llDim)
        llDimMax = 10*ones(llDim)
    elseif fno ==  7 #ok
        ulDimMin = -5*ones(ulDim)
        ulDimMax = [10*ones(p); 1*ones(r)]
        llDimMin = [-5*ones(q); epsi*ones(r)]
        llDimMax = [10*ones(q); exp(1)*ones(r)]
    elseif fno ==  8 #ok
        ulDimMin = -5*ones(ulDim)
        ulDimMax = 10*ones(ulDim)
        llDimMin = [-5*ones(q); -5*ones(r)]
        llDimMax = [10*ones(q); 10*ones(r)]
    elseif fno ==  9 #ok
        ulDimMin = -5*ones(ulDim)
        ulDimMax = [10*ones(p); 1*ones(r)]
        llDimMin = [-5*ones(q); -1 .+ epsi*ones(r)]
        llDimMax = [10*ones(q); (-1 .+ exp(1)*ones(r))]
    elseif fno ==  10	#ok		
        ulDimMin = -5*ones(ulDim)
        ulDimMax = 10*ones(ulDim)
        llDimMin = [-5*ones(q); -pi/2*ones(r).+epsi]
        llDimMax = [10*ones(q);  pi/2*ones(r).-epsi]
    elseif fno ==  11 #ok
        ulDimMin = [-5*ones(p); -1*ones(r)]
        ulDimMax = [10*ones(p); 1*ones(r)]
        llDimMin = [-5*ones(q); 1/exp(1)*ones(r)]
        llDimMax = [10*ones(q); exp(1)*ones(r)]
    elseif fno ==  12 #???? inconsistent with the paper
        ulDimMin = [-5*ones(p); -1*ones(r)]
        ulDimMax = [10*ones(p); 1*ones(r)]
        llDimMin = [-5*ones(q); -pi/4*ones(r).+epsi]
        llDimMax = [10*ones(q);  pi/4*ones(r).-epsi]
    end
 
    bounds_ul = [ulDimMin ulDimMax]
    bounds_ll = [llDimMin llDimMax]

    return bounds_ul, bounds_ll
end

function SMD_get_problem(fnum; ulDim = 2, llDim = 3)
    
    F = eval(Symbol("SMD"*string(fnum) * "_leader"))
    f = eval(Symbol("SMD"*string(fnum) * "_follower"))

    optimum = eval(Symbol("SMD"*string(fnum) * "_optimum"))

    x, y = optimum(ulDim, llDim)

    Fmin,G,H = F(x,y)
    fmin,g,h = f(x,y)


    bounds_ul, bounds_ll = SMD_ranges(fnum, ulDim, llDim)

    # upperMember, lowerMember
    conf = Dict(:xmin => bounds_ul[:,1],
                :xmax => bounds_ul[:,2],
                :ymin => bounds_ll[:,1],
                :ymax => bounds_ll[:,2],
                :leader_optimum => Fmin,
                :follower_optimum => fmin,
                :n_inequality_leader => length(G),
                :n_equality_leader => 0,
                :n_inequality_follower => length(g),
                :n_equality_follower => 0 )

    return F, f, conf
end

export SMD_get_problem
