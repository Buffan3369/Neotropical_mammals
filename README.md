# The Fate of South America's endemic mammal fauna in response to the most dramatic Cenozoic climate disruption

<p style='text-align: justify;'>

Authors: [Lucas Buffan](lucas.buffan@umontpellier.fr), Fabien L. Condamine, Narla S. Stutz, François Pujos, Pierre-Olivier Antoine, Laurent Marivaux.

To cite the paper:
> L. Buffan, F. L. Condamine, N. S. Stutz, F. Pujos, P-O. Antoine, L. Marivaux (202X). The Fate of South America's endemic mammal fauna in response to the most dramatic Cenozoic climate disruption.

This repository contains the analytical pipeline that goes with the study "The Fate of South America's endemic mammal fauna in response to the most dramatic Cenozoic climate disruption" (*in prep.*).


-------

## Study details
This study aims at exploring the diversification dynamics of South American Mammals (SAM) and their likely drivers throughout the Eocene-Oligocene interval (*ca.* 56 -- 23 Ma), a period encompassing drastic environmental changes, in particular the Eocene-Oligocene Transition.    
For that purpose, we rely on a densely-revised fossil occurrence database and the cutting-edge Bayesian frameworks of diversification inference from fossil data implemented in [PyRate](https://github.com/dsilvestro/PyRate.git).    
In this repository, you will find the analytical framework that we developed along this work.

-------

## Repository structure

*Note that this repository does not contain any data output (only figures). To find the data associated with this study (e.g., occurrence datasets, PyRate mcmc log files), please download this Figshare repository: https://figshare.com/XXX. Then, merge the resulting `/results_EXTENDED/` folder within the root of this repository, and the `/SPECIES_LISTS/` folder within the `/data_2023/` folder.*

* `/paleoTropics/` contains the palaeo-biome maps with a 5-My time step produced by Scotese et al. (2021)<sup>1</sup> processed by Quintero et al. (2023)<sup>2</sup> so they finally only divide the world into tropical and extratropical areas.

-------

## Workflow

Additional scripts for data analysis can be found in the [CorsaiR](https://github.com/Alexis-Marion/CorsaiR) repository.

-------

References:    

<small>
<sup>1</sup> C. R. Scotese, H. Song, B. J. W. Mills, D. G. van der Meer, Phanerozoic paleotemperatures: The earth’s changing climate during the last 540 million years. Earth-Sci. Rev. 215, 103503 (2021).    
<sup>2</sup> I. Quintero, M. J. Landis, W. Jetz, H. Morlon, The build-up of the present-day tropical diversity of tetrapods. Proc. Natl. Acad. Sci. 120, e2220672120 (2023).
</small>

</p>