#!/usr/bin/env perl
# created on 2021-12-15

use warnings;
use utf8;
use 5.30.0;

use Bio::Gonzales::Util::Cerial;

my $data = yslurp("./filter-rules.yaml");

my $rule_tmpl = <<'EOR';
||DOMAIN^$all
duckduckgo.*###links > div:has(a[href*="DOMAIN"])
google.*###rso .MjjYud a[href*="DOMAIN"]:upward(.MjjYud)
EOR

open my $filters_fh, '>', './ublock-filters.txt' or die "Can't open filehandle: $!";

for my $d (@{ $data->{domains} }) {
  (my $r = $rule_tmpl) =~ s/DOMAIN/$d/g;
  print $filters_fh $r;
}

close $filters_fh;
