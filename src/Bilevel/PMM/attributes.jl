"""
    PMM_get_problem(fnum; uldim = 5, lldim = 5)

Return upper and lower level objective functions, and the problem configuration in a
dictionary.

### Example

```
julia> using HardTestProblems

julia> F, f, conf = PMM_get_problem(2,uldim=2,lldim=3);

julia> conf
Dict{Symbol, Any} with 15 entries:
  :follower_optimum      => 0.0
  :n_inequality_follower => 0
  :xbest                 => [0.0, 0.0]
  :problem               => "PMM2"
  :n_equality_follower   => 0
  :lldim                 => 3
  :uldim                 => 2
  :n_equality_leader     => 0
  :n_inequality_leader   => 0
  :xmin                  => [-10.0, -10.0]
  :leader_optimum        => 0.0
  :xmax                  => [10.0, 10.0]
  :ymax                  => [10.0, 10.0, 10.0]
  :ymin                  => [-10.0, -10.0, -10.0]
  :ybest                 => [0.0, 1.41421, 1.73205]

```
"""
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
