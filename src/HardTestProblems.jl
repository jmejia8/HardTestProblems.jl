module HardTestProblems
import BSON
import Statistics: mean

# Multiobjective problems
include("Multiobjective/RW_MOP_2021/RW_MOP_2021.jl")
include("Singleobjective/CEC2020/CEC2020.jl")
include("Bilevel/SMD/SMD.jl")
include("Bilevel/PMM/PMM.jl")



end
