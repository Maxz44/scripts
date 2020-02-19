#!/bin/bash

#  SAM Deploy script to AWS

test -f samconfig.toml || guided="--guided"
sam validate|sam build --use-container && sam deploy $guided