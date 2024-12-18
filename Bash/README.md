This folder contains shell the scripts used in Buffan et al. (2024) for running fossil-based diversification analyses using PyRate and treating PyRate outputs.

The pipeline is organised in the following way:
	1. Run analyses (both at the genus and species level)
	2. Assess runs convergence and specify the most optimal proportion of the posterior distribution to remove (i.e. burn-in)
	3. Combine mcmc log files that converged and plot combined lineages and diversification rates through time
	4. Synthetise preservation rates across each retained replicate
	5. [EVENTUALLY] Overall plot : RTT, LTT and Q_rates

Inside the other folders, you will find the same analysis philosophy, but with different data.
