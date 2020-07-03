#using PyPlot, Printf
using LinearAlgebra
using Flux, DiffEqFlux, Optim, DiffEqSensitivity
using DifferentialEquations
using Plots
gr()

function simple(u,p,t)
  lamda = p
  lamda * u
end

# Define the experimental parameter
tspan = (0.0,1.0)
u0 = 1/2
p_ = 1.0
prob = ODEProblem(simple, u0,tspan)
solution = solve(prob, Tsit5(), abstol=1e-12, reltol=1e-12, saveat = 0.1)
ode_data = Array(solution)

#pyplot()
#clossall()
plot(solution)
savefig("sol1.png")

function f(u,p,t)
  1.0*u
end

function lorenz!(du,u,p,t)
  x,y,z = u
  σ,ρ,β = p
  du[1] = dx = σ*(y-x)
  du[2] = dy = x*(ρ-z) - y
  du[3] = dz = x*y - β*z
end

u0 = [1.0;0.0;0.0]
tspan = (0.0,100.0)
p = [10.0,28.0,8/3]
prob = ODEProblem(lorenz!,u0,tspan, p)
sol = solve(prob)

plot(sol,vars=(1,2,3))
savefig("sol2.png")
