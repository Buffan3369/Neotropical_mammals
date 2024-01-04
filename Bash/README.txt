This folder contains shell scripts for running fossil-based diversification analyses using PyRate and treating PyRate outputs.
The order of the pipeline is:
	1. Run analyses (both at the genus and species level)
	( 2. Download mcmc runs (i.e. PyRate outputs) )
	3. Assess runs convergence and specify the most optimal proportion of the posterior distribution to remove (i.e. burn-in)
	4. Combine mcmc log files that converged and plot combined lineages and diversification rates through time
	5. Assess lineages-through-time individually (for final plot)
	6. Synthetise preservation rates across each retained replicate
	7. Overall plot : RTT, LTT and Q_rates
