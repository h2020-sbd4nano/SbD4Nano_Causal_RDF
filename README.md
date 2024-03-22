# Exposing causal links in nanosafety literature in the semantic web

This repository contains links to supporting data for the SbD4Nano network linking physicochemical properties of nanomaterials with stated biological outcomes in literature and the necessary files to map and verify their RDF graphs.

- [RDF files](data/RDF/), including the instances and the classes derived from the eNanoMapper Ontology.
- [YARRRML mapping file](/mappings/causal_network.yarrrml.yml)
- [RML mapping file](mappings/causal_network.rml)
- [Shape Expressions (ShEx)](/shapes)



## Authors

- Jeaphianne P. M. van Rijn [0000-0001-5026-7705](https://orcid.org/0000-0001-5026-7705)
- Javier Millan Acosta [0000-0002-4166-7093](https://orcid.org/0000-0002-4166-7093)
- Egon L. Willighagen [0000-0001-7542-0286](https://orcid.org/0000-0001-7542-0286)

The methodology to generate RDF versions of the curated spreadsheets was adapted from the Nano-MIE-interactions-RDF [(Ammar Ammar, 2023)](https://doi.org/10.5281/zenodo.8075705).


## Abstract
TBD 

## Generating the RDFs

The [`make_rdf.sh`](/make_rdf.sh) script regenerates the RML and RDF files from source
```
sudo bash make_rdf.sh
```

## Loading a local instance of Virtuoso + SNORQL with the data
```
docker compose up -d
```
The needed graphs are:
- Either `causal_network.nq` or `causal_network.ttl`
- The subset of the eNanoMapper Ontology, `classes.owl`
