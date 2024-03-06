#!/bin/bash

# Author: Javier Millan Acosta
# Date: February 2024
# TODO turn into proper Makefile
# Step 1: define paths
YARRRML="src/mappings/$1.yarrrml.yml"
RML="src/mappings/$1.rml"
TTL="data/RDF/$1.ttl"
NQ="data/RDF/$1.nq"

# Step 2: Download RML Mapper
#echo "Downloading RML Mapper v6.2.2"
#wget -nc https://github.com/RMLio/rmlmapper-java/releases/download/v6.2.2/rmlmapper-6.2.2-r371-all.jar

# Step 3: Install YARRRML Parser
#echo "Installing YARRRML Parser (npm i @rmlio/yarrrml-parser -g)"
#npm list yarrrml-parser | npm install -g @rmlio/yarrrml-parser

echo ______________________________________
# Step 4: Run YARRRML to obtain RML
echo "Running YARRRML on the YAML file to generate RML: $RML"
yarrrml-parser --input $YARRRML > $RML

# Step 5: Run RML Mapper
echo "Running RML Mapper to generate RDF ttl"
java -jar rmlmapper-6.2.2-r371-all.jar -m $RML -o $TTL -s turtle
echo "Running RML Mapper to generate RDF nq"
java -jar rmlmapper-6.2.2-r371-all.jar -m $RML -o $NQ
# Step 6: cleanup
echo "Removing files"
#rm rmlmapper*
