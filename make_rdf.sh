#!/bin/bash

################################################################################
# Set up SbD4Nano Causal Links RDF Graph
# Author: Javier Millan Acosta
# ORCID: https://orcid.org/0000-0002-4166-7093
# Date: March 2024
# Purpose: automates the construction of the SbD4Nano Causal Links RDF Graph from its csv source.
# Replace with Docker when the project is ready for publication
################################################################################

# Step 0: retrieve csv #TODO need to retrieve from zenodo
echo Fetching latest spreadsheet data
jupyter execute notebooks/00_explore_clean_spreadsheet.ipynb
cat mappings/classes_map >> data/iris.tsv
# Step 1: define paths
CAUSAL_YARRRML="mappings/causal_network.yarrrml.yml"
CAUSAL_RML="mappings/causal_network.rml"
CAUSAL_TTL="data/RDF/causal_network.ttl"
CAUSAL_NQ="data/RDF/causal_network.nq"
NANOWIKI_YARRRML="mappings/nanowiki_network.yarrrml.yml"
NANOWIKI_RML="mappings/nanowiki_network.rml"
NANOWIKI_TTL="data/RDF/nanowiki_network.ttl"
NANOWIKI_NQ="data/RDF/nanowiki_network.nq"
ROBOT="https://github.com/ontodev/robot/raw/master/bin/robot"
ROBOT_JAR="https://github.com/ontodev/robot/releases/download/v1.9.5/robot.jar"

# Step 2: Download CAUSAL_RML Mapper
echo "Downloading RML Mapper v6.2.2"
wget -nc https://github.com/RMLio/rmlmapper-java/releases/download/v6.2.2/rmlmapper-6.2.2-r371-all.jar

# Step 3: Install CAUSAL_YARRRML Parser
echo "Installing YARRRML Parser (npm i @rmlio/yarrrml-parser -g)"
npm ls -g @rmlio/yarrrml-parser || npm install -g @rmlio/yarrrml-parser

echo ______________________________________
# Step 4: Run CAUSAL_YARRRML to obtain CAUSAL_RML
echo "Running yarrrml-parser on the YAML file to generate CAUSAL_RML: $CAUSAL_RML"
yarrrml-parser --input $CAUSAL_YARRRML > $CAUSAL_RML
#echo "Running yarrrml-parser on the YAML file to generate CAUSAL_RML: $NANOWIKI_RML"
#yarrrml-parser --input $NANOWIKI_YARRRML > $NANOWIKI_RML
# Step 5: Run CAUSAL_RML Mapper
echo "Running CAUSAL_RML Mapper to generate RDF ttl"
java -jar rmlmapper-6.2.2-r371-all.jar -m $CAUSAL_RML -o $CAUSAL_TTL -s turtle
#java -jar rmlmapper-6.2.2-r371-all.jar -m $NANOWIKI_RML -o $NANOWIKI_TTL -s turtle
#echo "Running CAUSAL_RML Mapper to generate RDF nq"
#java -jar rmlmapper-6.2.2-r371-all.jar -m $CAUSAL_RML -o $CAUSAL_NQ

# Step 6: Get ROBOT & eNM Ontology
rm enanomapper-dev.owl || true
wget https://raw.githubusercontent.com/enanomapper/ontologies/master/enanomapper-dev.owl
wget -nc $ROBOT
wget -nc $ROBOT_JAR

# Step 7: Extract used classes
less data/props.tsv >> data/iris.tsv
echo Creating module for eNM
bash robot \
    merge \
        --input enanomapper-dev.owl \
    extract \
        --method BOT \
        --term-file data/iris.tsv \
        --copy-ontology-annotations true \
        --annotate-with-source true \
    annotate \
        --version-iri "https://h2020-sbd4nano.github.io/sbd-data-landscape/classes/alpha.owl" \
        --output data/RDF/classes.owl
echo Success


# Step : cleanup
#echo "Removing files"
#rm rmlmapper*