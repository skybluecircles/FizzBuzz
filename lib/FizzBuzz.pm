package FizzBuzz;

use strict;
use warnings;

use v5.18;

use autodie qw(:all);
use feature qw(say);

use Moose;
use MooseX::StrictConstructor;

__PACKAGE__->meta()->make_immutable();

1;
