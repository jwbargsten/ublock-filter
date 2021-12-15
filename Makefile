.PHONY: all clean test

date=$(shell date +%F)

all:
	perl bin/create-filters.pl
