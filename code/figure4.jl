include("seed.jl")

# Simulation with generalist natural enemies
sim, pars = simulation(25.0, 8.0; m=0.5, D=0.5, f=generalist_dyn)
# Fig 4a)
fig4a = plot(sim[:,1],sim[:,2], label="Hosts", frame=:origin, lw=2,
   xlims=(0,50), ylims=(0,25))
plot!(fig4a, sim[:,1],sim[:,3], label="Parasites", lw=2)
xlabel!(fig4a, "Generation")
ylabel!(fig4a, "Population size")
annotate!(fig4a, generate_legend_position((0,50),(0,25))..., text("(a)"))

kval = mapslices((r) -> kvalue_by_generation(r, pars), sim; dims=2)
fig4b = plot(log10.(sim[:,2]), kval,
   m=:circle, msc=:white, msw=2, ms=4, mc=:grey,
   lc=:grey, lw=2,
   leg=false, frame=:box,
   xlims=(0.75, 1.75),
   ylims=(0.2, 0.5))
xlabel!(fig4b, "Host density (log 10)")
ylabel!(fig4b, "k-value")
annotate!(fig4b, generate_legend_position((0.75,1.75),(0.2,0.5))..., text("(b)"))

plot(fig4a, fig4b, layout=(2,1), size=(500,900), margin=5mm)
savefig("../article/figures/figure4.pdf")
