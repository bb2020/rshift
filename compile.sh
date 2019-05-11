#!/bin/sh

gcc -o rshift -Wall -std=c99 -O3 -framework Cocoa main.m main.c redshift/src/gamma-quartz.c redshift/src/colorramp.c
