function PMM_get_problem(fnum; uldim = 5, lldim = 5)
    F = eval(Symbol("PMM"*string(fnum) * "_leader"))
    f = eval(Symbol("PMM"*string(fnum) * "_follower"))

    optimum = eval(Symbol("PMM"*string(fnum) * "_optimum"))

    x, y = optimum(uldim, lldim)

    Fmin,_,_ = F(x,y)
    fmin,_,_ = f(x,y)


    xmin = fill(-10.0, uldim)
    xmax = fill( 10.0, uldim)

    ymin = fill(-10.0, lldim)
    ymax = fill( 10.0, lldim)

    # upperMember, lowerMember
    conf = Dict(:xmin  => xmin,
                :xmax  => xmax,
                :ymin  => ymin,
                :ymax  => ymax,
                :xbest => x,
                :ybest => y,
                :leader_optimum   => Fmin,
                :follower_optimum => fmin,
                :lldim => lldim,
                :uldim => uldim,
                :n_inequality_leader   => 0,
                :n_equality_leader     => 0,
                :n_inequality_follower => 0,
                :n_equality_follower   => 0,
                :problem => "PMM" * string(fnum)
               )

    return F, f, conf
end

export PMM_get_problem
