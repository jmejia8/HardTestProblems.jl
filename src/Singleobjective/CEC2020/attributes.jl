const INPUT_DATA_CEC2020 = BSON.load(joinpath(@__DIR__, "data.bson"))


const NAME_OF_PROBLEMS_CEC2020 = [ 
                                      "cec2020_f1", "cec2020_f2",
                                      "cec2020_f3", "cec2020_f4",
                                      "cec2020_f5", "cec2020_f6",
                                      "cec2020_f7", "cec2020_f8",
                                      "cec2020_f9", "cec2020_f10"
                                     ]

function load_data_from_dict(fnum, D)
    fnums = [1,2,3,7,4,16,6,22,24,25]
    # dimensions = [2,5,10,15,20,30,50,100]

    fnum = fnums[fnum]

    if D==2&&(fnum==4||fnum==16||fnum==6)
        error("function $fnum not implemented for D = $D.")
    end

    str_fnum = string(fnum)
    str_D = string(D)
    o = INPUT_DATA_CEC2020["o_fnum"*str_fnum*"_D"*str_D]
    M = INPUT_DATA_CEC2020["M_fnum"*str_fnum*"_D"*str_D]
    S = INPUT_DATA_CEC2020["S_fnum"*str_fnum*"_D"*str_D]

    return o, M, S
end


get_cec2020_minimum(fnum) = [100,1100,700,1900,1700,1600,2100,2200,2400,2500][fnum]

"""
    get_cec2020_config(fnum::Int; n = 10)

Return a dictionary containing the information about the problem in CEC2020 benchmark.
`n` is number of variables (2,5,10,15,20,30,50,100)
"""
function get_cec2020_config(fnum::Int; n = 10)
    @assert 1 <= fnum <= 10
    @assert n in [2,5,10,15,20,30,50,100]

    return Dict(:function => NAME_OF_PROBLEMS_CEC2020[fnum],
                :fn    => 1,
                :n     => n,
                :minimum => get_cec2020_minimum(fnum),
                :gn    => 0,
                :hn    => 0,
                :xmin  => fill(-100.0, n),
                :xmax  => fill(100.0, n))
end

"""
    get_cec2020_config(fnum::Int; n = 10)

Return a dictionary containing the information about the problem in CEC2020 benchmark.
`n` is number of variables (2,5,10,15,20,30,50,100)
"""
function get_cec2020_problem(fnum::Int; n = 10)

    !(1 <= fnum <= 10) && error("Problem $fnum is not implemented yet or does not exist.")

    # objetive function x -> f(x)
    f = eval(Symbol(NAME_OF_PROBLEMS_CEC2020[fnum]))

    # problem configuration
    conf = get_cec2020_config(fnum; n = n)

    return f, conf
end
