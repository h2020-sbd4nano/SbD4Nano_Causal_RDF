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
YARRRML="mappings/causal_network.yarrrml.yml"
RML="mappings/causal_network.rml"
TTL="data/RDF/causal_network.ttl"
NQ="data/RDF/causal_network.nq"
ROBOT="https://github.com/ontodev/robot/raw/master/bin/robot"
ROBOT_JAR="https://github.com/ontodev/robot/releases/download/v1.9.5/robot.jar"

# Step 2: Download RML Mapper
echo "Downloading RML Mapper v6.2.2"
wget -nc https://github.com/RMLio/rmlmapper-java/releases/download/v6.2.2/rmlmapper-6.2.2-r371-all.jar

# Step 3: Install YARRRML Parser
echo "Installing YARRRML Parser (npm i @rmlio/yarrrml-parser -g)"
npm ls -g @rmlio/yarrrml-parser || npm install -g @rmlio/yarrrml-parser

echo ______________________________________
# Step 4: Run YARRRML to obtain RML
echo "Running YARRRML on the YAML file to generate RML: $RML"
yarrrml-parser --input $YARRRML > $RML

# Step 5: Run RML Mapper
echo "Running RML Mapper to generate RDF ttl"
java -jar rmlmapper-6.2.2-r371-all.jar -m $RML -o $TTL -s turtle
#echo "Running RML Mapper to generate RDF nq"
#java -jar rmlmapper-6.2.2-r371-all.jar -m $RML -o $NQ

# Step 6: Get ROBOT & eNM Ontology
wget -nc https://raw.githubusercontent.com/enanomapper/ontologies/master/enanomapper-dev.owl
wget -nc $ROBOT
wget -nc $ROBOT_JAR

# Step 7: Extract used classes
echo Creating BOTTOM module for eNM
bash robot merge --input enanomapper-dev.owl \
    extract --method BOT \
    --term-file data/iris.tsv \
    --output data/RDF/classes.owl

echo Success
# Step : cleanup
#echo "Removing files"
#rm rmlmapper*