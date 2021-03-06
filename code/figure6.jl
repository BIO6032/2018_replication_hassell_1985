include("seed.jl")

# Simulation with specialist natural enemies with stochasticity on D
sim1, params1 = simulation(25.0, 8.0; m=0.5, f=generalist_dyn, D_std=0.5)
# Fig 5a)
fig6a = plot(sim1[:,1], sim1[:,2], label="Hosts", frame=:origin, lw=2, leg=false, ylims=(0, 60), xlims=(0,50))
plot!(fig6a, sim1[:,1],sim1[:,3], label="Parasites", lw=2)
ylabel!(fig6a, "Population size")
annotate!(fig6a, generate_legend_position((0,50),(0,60))..., text("(a)"))
annotate!(fig6a, generate_legend_position((0,50),(0,60); shift=0.4)..., text("D = 0.5 ± 0.5"))


kval1 = mapslices((r) -> kvalue_by_generation(r, params1), sim1; dims=2)
fig6d = scatter(log10.(sim1[:,2]), kval1,
   m=:circle, msc=:white, msw=2, ms=4, mc=:grey,
   lc=:grey, lw=2,
   leg=false, frame=:box,
   xlims=(-0.5, 1.5),
   ylims=(0, 0.5))
ylabel!(fig6d, "k-value")
annotate!(fig6d, generate_legend_position((-0.5,1.5),(0,0.5))..., text("(d)"))

sim1_R2 = cor(vec(log10.(sim1[:,2])), vec(kval1))^2
sim1_a, sim1_b = linreg(vec(log10.(sim1[:,2])), vec(kval1))

# Simulation with specialist natural enemies with stochasticity on h
sim2, params2 = simulation(25.0, 8.0; m=0.5, f=generalist_dyn, h_sd=5)
# Fig 5b)
fig6b = plot(sim2[:,1], sim2[:,2], label="Hosts", frame=:origin, lw=2, leg=false, ylims=(0, 60), xlims=(0,50))
plot!(fig6b, sim2[:,1],sim2[:,3], label="Parasites", lw=2)
xlabel!(fig6b, "Generation")
annotate!(fig6b, generate_legend_position((0,50),(0,60))..., text("(b)"))
annotate!(fig6b, generate_legend_position((0,50),(0,60); shift=0.4)..., text("h = 10 ± 5"))

kval2 = mapslices((r) -> kvalue_by_generation(r, params2), sim2; dims=2)
fig6e = scatter(log10.(sim2[:,2]), kval2,
   m=:circle, msc=:white, msw=2, ms=4, mc=:grey,
   lc=:grey, lw=2,
   leg=false, frame=:box,
   xlims=(1, 1.8),
   ylims=(0, 0.5))
xlabel!(fig6e, "Host density (log 10)")
annotate!(fig6e, generate_legend_position((1,1.8),(0,0.5))..., text("(e)"))

sim2_R2 = cor(vec(log10.(sim2[:,2])), vec(kval2))^2
sim2_a, sim2_b = linreg(vec(log10.(sim2[:,2])), vec(kval2))

# Simulation with specialist natural enemies with stochasticity on a
sim3, params3 = simulation(25.0, 8.0; m=0.5, f=generalist_dyn, a_sd=0.5)
# Fig 5c)
fig6c = plot(sim3[:,1],sim3[:,2], label="Hosts", frame=:origin, lw=2, ylims=(0, 60), xlims=(0,50))
plot!(fig6c, sim3[:,1],sim3[:,3], label="Parasites", lw=2)
annotate!(fig6c, generate_legend_position((0,50),(0,60))..., text("(c)"))
annotate!(fig6c, generate_legend_position((0,50),(0,60); shift=0.4)..., text("a = 0.5 ± 0.5"))

kval3 = mapslices((r) -> kvalue_by_generation(r, params3), sim3; dims=2)
fig6f = scatter(log10.(sim3[:,2]), kval3,
   m=:circle, msc=:white, msw=2, ms=4, mc=:grey,
   lc=:grey, lw=2,
   leg=false, frame=:box,
   xlims=(0.5, 1.5),
   ylims=(0, 0.6))
annotate!(fig6f, generate_legend_position((0.5,1.5),(0,0.6))..., text("(f)"))

xlabel!(fig6a, " ")
xlabel!(fig6c, " ")

sim3_R2 = cor(vec(log10.(sim3[:,2])), vec(kval3))^2
sim3_a, sim3_b = linreg(vec(log10.(sim3[:,2])), vec(kval3))

plot(fig6a, fig6b, fig6c, fig6d, fig6e, fig6f, layout=(2,3), size=(1200,900), margin=5mm)
savefig("../article/figures/figure6.pdf")
