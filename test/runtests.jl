using HardTestProblems
using Test

@testset "RW-MOP-2021" begin
    funcs = [ cec2021_f1, cec2021_f2, cec2021_f3, cec2021_f4, cec2021_f5,
              cec2021_f6, cec2021_f7, cec2021_f8, cec2021_f9, cec2021_f10 ]

    for (fnum, f) in enumerate(funcs)
        for D in [5,10,15,20,30,50,100]
            F =  f(rand(77, D))
            fmin = get_cec2021_minimum(fnum)
            @test sum(F .< fmin) == 0 
        end
    end
    
    return
    for i in 1:50
        # objective function and problem configuration
        f, conf = get_RW_MOP_problem(i)

        _, conf_tmp = get_RW_MOP_problem(conf[:function])
        # check get_RW_MOP_problem
        @test conf[:function] == conf_tmp[:function]

        # check dimension
        @test length(conf[:xmin]) == length(conf[:xmax]) == conf[:n]

        # check objectives
        @test length(conf[:nadir]) == conf[:fn]

        fx, gx, hx = f(conf[:xmin])

        # constraint violation sum
        vio = sum(max.(0.0, gx .<= 0)) + sum(max.(0.0, abs.(hx) .- 1e-2 .<= 0))

        # infeasible or feasible and not worst than nadir point.
        @test vio > 0 || (vio == 0 && sum(fx .> conf[:nadir]) == 0)
    end

end

