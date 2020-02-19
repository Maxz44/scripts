#!/bin/bash

#  SAM local web-server script to AWS

sam validate|sam build --use-container && sam local start-api