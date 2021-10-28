using HardTestProblems
using Test


@testset "SMD" begin
    for i in 1:12
        
        for (ulDim, llDim) in zip([2,5,10], [3,5,10])
            # objective function and problem configuration
            F, f, conf = SMD_get_problem(i, ulDim = ulDim, llDim = llDim)
            cond1 = length(conf[:xmin]) == ulDim == length(conf[:xmax])
            cond2 = length(conf[:ymin]) == llDim == length(conf[:ymax])
            @test cond1 && cond2
        end
        
        
    end
end

@testset "CEC2020" begin
    for fnum in 1:10
        for D in [5,10,15,20,30,50,100]
            f, conf = get_cec2020_problem(fnum)
            F =  f(rand(77, D))
            fmin = conf[:minimum]
            @test sum(F .< fmin) == 0 
        end
    end
end
    
@testset "RW-MOP-2021" begin
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

