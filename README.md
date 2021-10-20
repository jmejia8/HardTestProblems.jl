# Hard Test Problems

This package implements challenging test problems for testing metaheuristics (evolutionary
algorithms) for single and multi-objective optimization.


[![Build Status](https://github.com/jmejia8/HardTestProblems.jl/workflows/CI/badge.svg)](https://github.com/jmejia8/HardTestProblems.jl/actions)
[![Coverage](https://codecov.io/gh/jmejia8/HardTestProblems.jl/branch/main/graph/badge.svg)](https://codecov.io/gh/jmejia8/HardTestProblems.jl)

## Installation

This package can be installed in Julia (v1.1 or latter) via `Pkg` API:

```julia
julia> import Pkg; Pkg.add(url="https://github.com/jmejia8/HardTestProblems.jl.git")
```

## Benchmarks

- [x] [RW-MOP-2021](https://github.com/P-N-Suganthan/2021-RW-MOP)
      Real world multi-objective Constrained Optimization Test Suite.
- [x] [CEC2020-BC-SO](https://github.com/P-N-Suganthan/2020-Bound-Constrained-Opt-Benchmark)
      Bound-constrained test problems for single objective optimization.
- [ ] [CEC2017](https://github.com/P-N-Suganthan/CEC2017)   Competition on Constrained Real-Parameter Optimization.

## Usage

### RW-MOP-2021

Use the `get_RW_MOP_problem` to obtain the objective function and the corresponding
attributes:

```julia
julia> using HardTestProblems

julia> HardTestProblems.NAME_OF_PROBLEMS_RW_MOP_2021
50-element Vector{String}:
 "pressure_vessel"
 "vibrating_platform"
 "two_bar_Truss_design_problems"
 "weldan_beam_design"
 ⋮
 "minimization_of_active_power_loss_in_islanded_microgrids_3"
 "power_distribution_system_planning"

julia> f, conf =  get_RW_MOP_problem(1);

julia> conf
Dict{Symbol, Any} with 8 entries:
  :xmin     => [0.51, 0.51, 10.0, 10.0]
  :xmax     => [99.49, 99.49, 200.0, 200.0]
  :n        => 4
  :function => "pressure_vessel"
  :gn       => 2
  :hn       => 0
  :fn       => 2
  :nadir    => [3.59649e5, -7330.38]

julia> f(conf[:xmin])
([12.40080078125, -7330.382858376184], [0.0329, 0.1305], [0.0])
```

Note that `f` is in the form `f(x) = Tuple([f1, f2,...], [g1, g2,...], [h1, h2,...])`.
A feasible solution is such that `gi <= 0` and `hi = 0`.

### CEC2020-BC-SO

You can do the following to obtain the problem information:

```julia
julia> using HardTestProblems

julia> HardTestProblems.NAME_OF_PROBLEMS_CEC2020
10-element Vector{String}:
 "cec2020_f1"
 "cec2020_f2"
  ⋮
  "cec2020_f10"

julia> f, conf = get_cec2020_problem(1, n=10);

julia> conf
Dict{Symbol, Any} with 8 entries:
  :xmin     => [-100.0, -100.0, -100.0, -100.0, -100.0, -100.0, -100.0, -100.0, -100.0, -100.0]
  :xmax     => [100.0, 100.0, 100.0, 100.0, 100.0, 100.0, 100.0, 100.0, 100.0, 100.0]
  :n        => 10
  :minimum  => 100
  :function => "cec2020_f1"
  :gn       => 0
  :hn       => 0
  :fn       => 1

julia> f(conf[:xmin])
2.0983079296144998e11
```

Each problems is defined for dimension `n in [2,5,10,15,20,30,50,100]`.
