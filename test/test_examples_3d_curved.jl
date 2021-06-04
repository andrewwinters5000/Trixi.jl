module TestExamples3DCurved

using Test
using Trixi

include("test_trixi.jl")

# pathof(Trixi) returns /path/to/Trixi/src/Trixi.jl, dirname gives the parent directory
EXAMPLES_DIR = joinpath(pathof(Trixi) |> dirname |> dirname, "examples", "3d")

@testset "Curved mesh" begin
  @testset "elixir_advection_basic_curved.jl" begin
    @test_trixi_include(joinpath(EXAMPLES_DIR, "elixir_advection_basic_curved.jl"),
      l2   = [0.00013446460962856976],
      linf = [0.0012577781391462928])
  end

  @testset "elixir_advection_free_stream_curved.jl" begin
    @test_trixi_include(joinpath(EXAMPLES_DIR, "elixir_advection_free_stream_curved.jl"),
      l2   = [1.830875777528287e-14],
      linf = [7.491784970170556e-13],
      atol = 8e-13, # required to make tests pass on Windows
      )
  end

  @testset "elixir_advection_nonperiodic_curved.jl" begin
    @test_trixi_include(joinpath(EXAMPLES_DIR, "elixir_advection_nonperiodic_curved.jl"),
      l2   = [6.522004549411137e-5],
      linf = [0.005554857853361295])
  end

  @testset "elixir_advection_restart_curved.jl" begin
    @test_trixi_include(joinpath(EXAMPLES_DIR, "elixir_advection_restart_curved.jl"),
      l2   = [0.0281388160824776],
      linf = [0.08740635193023694])
  end

  @testset "elixir_euler_source_terms_curved.jl" begin
    @test_trixi_include(joinpath(EXAMPLES_DIR, "elixir_euler_source_terms_curved.jl"),
      l2   = [0.01032310150257373, 0.009728768969448439, 0.009728768969448494, 0.009728768969448388, 0.015080412597559597],
      linf = [0.034894790428615874, 0.033835365548322116, 0.033835365548322116, 0.03383536554832034, 0.06785765131417065])
  end

  @testset "elixir_euler_free_stream_curved.jl" begin
    @test_trixi_include(joinpath(EXAMPLES_DIR, "elixir_euler_free_stream_curved.jl"),
      l2   = [2.8815700334367128e-15, 9.361915278236651e-15, 9.95614203619935e-15, 1.6809941842374106e-14, 1.4815037041566735e-14],
      linf = [4.1300296516055823e-14, 2.0444756998472258e-13, 1.0133560657266116e-13, 3.1896707497480747e-13, 6.092903959142859e-13])
  end

  @testset "elixir_euler_free_stream_curved.jl with FluxRotated(flux_lax_friedrichs)" begin
    @test_trixi_include(joinpath(EXAMPLES_DIR, "elixir_euler_free_stream_curved.jl"),
      surface_flux=FluxRotated(flux_lax_friedrichs),
      l2   = [2.8815700334367128e-15, 9.361915278236651e-15, 9.95614203619935e-15, 1.6809941842374106e-14, 1.4815037041566735e-14],
      linf = [4.1300296516055823e-14, 2.0444756998472258e-13, 1.0133560657266116e-13, 3.1896707497480747e-13, 6.092903959142859e-13])
  end

  @testset "elixir_euler_nonperiodic_curved.jl" begin
    @test_trixi_include(joinpath(EXAMPLES_DIR, "elixir_euler_nonperiodic_curved.jl"),
      l2   = [0.0018268326813744103, 0.001745601029521995, 0.001745601029521962, 0.0017456010295218891, 0.003239834454817457],
      linf = [0.014660503198892005, 0.01506958815284798, 0.01506958815283821, 0.015069588152864632, 0.02700205515651044])
  end

  @testset "elixir_euler_ec_curved.jl" begin
    @test_trixi_include(joinpath(EXAMPLES_DIR, "elixir_euler_ec_curved.jl"),
      l2   = [0.011367083018614027, 0.007022020327490176, 0.006759580335962235, 0.006820337637760632, 0.02912659127566544],
      linf = [0.2761764220925329, 0.20286331858055706, 0.18763944865434593, 0.19313636558790004, 0.707563913727584],
      tspan = (0.0, 0.25))
  end

  @testset "elixir_mhd_ec_curved.jl" begin
    @test_trixi_include(joinpath(EXAMPLES_DIR, "elixir_mhd_ec_curved.jl"),
      l2   = [0.009004021452004856, 0.007143957956917952, 0.006973755636325691, 0.0069016516181158,
              0.033006366599547275, 0.0031996515755530752, 0.0030752688029571135, 0.0030711742765310865,
              4.411700983795491e-5],
      linf = [0.2935375181753366, 0.25906662938283426, 0.2607906900919801, 0.24554085013509105,
              1.1920299902550622, 0.12964835514332484, 0.13226019826981572, 0.14207453734982423,
              0.00362554151305806],
      tspan = (0.0, 0.25))
  end

  @testset "elixir_mhd_alfven_wave_curved.jl" begin
    @test_trixi_include(joinpath(EXAMPLES_DIR, "elixir_mhd_alfven_wave_curved.jl"),
      l2   = [0.003015476175153681, 0.00145499403283373, 0.0009125744757935803, 0.0017703080480578979,
              0.0013046447673965966, 0.0014564863387645508, 0.0013332311430907598, 0.001647832598455728,
              0.0013647609788548722],
      linf = [0.027510637768610846, 0.02797062834945721, 0.01274249949295704, 0.038940694415543736,
              0.02200825678588325, 0.03167600959583505, 0.021420957993862344, 0.03386589835999665,
              0.01888303191983353])
  end

  @testset "elixir_mhd_alfven_wave_curved.jl with flux_lax_friedrichs" begin
    @test_trixi_include(joinpath(EXAMPLES_DIR, "elixir_mhd_alfven_wave_curved.jl"),
      l2   = [0.003171291382654337, 0.001466074967645249, 0.000906493396735031, 0.0018587873989296942,
              0.0012848233768432747, 0.001467736808787043, 0.0013283930550809693, 0.0017298643169967774,
              0.0013701161883901633],
      linf = [0.02760676560558184, 0.02653373877956791, 0.01246630960680778, 0.03966794601426052,
              0.020169271063350536, 0.03196355613790258, 0.02044690212705813, 0.0348500569684298,
              0.019830228302710272],
      surface_flux = flux_lax_friedrichs)
  end
end

end # module
