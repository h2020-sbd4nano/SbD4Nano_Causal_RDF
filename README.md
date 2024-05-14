# Exposing causal links in nanosafety literature using the semantic web

This repository contains links to supporting data for the SbD4Nano network linking physicochemical properties of nanomaterials with stated biological outcomes in literature and the necessary files to map and verify their RDF graphs.

- [RDF files](data/RDF/), including the instances and the classes derived from the eNanoMapper Ontology.
- [YARRRML mapping file](/mappings/causal_network.yarrrml.yml)
- [RML mapping file](mappings/causal_network.rml)
- [Shape Expressions (ShEx)](/shapes)
- [Unique IRIs used in the data model](https://github.com/h2020-sbd4nano/SbD4Nano_Causal_RDF/blob/master/data/iris.tsv)
- [Queries repository](https://github.com/h2020-sbd4nano/SbD4nano-causal-SPARQL/) used by the SNORQL interface to retrieve queries
- [Visualization dashboard](https://h2020-sbd4nano.github.io/SbD4Nano_Causal_RDF/)
## Authors

- Javier Millan Acosta [0000-0002-4166-7093](https://orcid.org/0000-0002-4166-7093)
- Jeaphianne P. M. van Rijn [0000-0001-5026-7705](https://orcid.org/0000-0001-5026-7705)
- Egon L. Willighagen [0000-0001-7542-0286](https://orcid.org/0000-0001-7542-0286)

The methodology to generate RDF versions of the curated spreadsheets was adapted from the Nano-MIE-interactions-RDF ([Ammar Ammar, 2023](https://doi.org/10.5281/zenodo.8075705)).


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
- `causal_network.ttl`
- The subset of the eNanoMapper Ontology, `classes.owl`
The SNORQL instance will fetch the queries from the [queries repository](https://github.com/h2020-sbd4nano/SbD4nano-causal-SPARQL/tree/main).
