#!/bin/bash
export myenv=first
echo my env set to $myenv
cmake -B ./build -S `pwd`
export myenv=second
echo my env changes to $myenv
cmake --build `pwd`/build
