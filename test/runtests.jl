using HardTestProblems
using Test

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

