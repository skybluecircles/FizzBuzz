package FizzBuzz::Exception;

use strict;
use warnings;

use v5.16;

use autodie qw(:all);
use feature qw(say);

use Moose;
extends 'Throwable::Error';

__PACKAGE__->meta()->make_immutable();

1;
