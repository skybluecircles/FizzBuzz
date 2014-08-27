#!/usr/bin/perl

use strict;
use warnings;

use v5.16;

use autodie qw(:all);
use feature qw(say);

my $a = 3;
my $b = 5;
my $c = $a * $b;

for ( 1 .. 100 ) {
    fizzbuzz($_);
}

exit 0;

sub fizzbuzz {
    my $num = shift;

    if ( $num % $c == 0 ) {
        say 'FizzBuzz';
    }
    elsif ( $num % $b == 0 ) {
        say 'Buzz';
    }
    elsif ( $num % $a == 0 ) {
        say 'Fizz';
    }
    else {
        say $num;
    } 
}

=pod

=head1 NAME

FizzBuzz

=head1 SYNOPSIS

  $ fizzbuzz

=head1 DESCRIPTION

Takes no arguments.

Assumes two numbers: 3 and 5.

For the numbers 1 to 100:

=over 4

=item

if the number is divisible by both 3 and 5, prints 'FizzBuzz'

=item

if the number is divisible by 5 (and not by 3),  prints 'Buzz'

=item

if the number is divisible by 3 (and not by 5),  prints 'Fizz'

=item

otherwise, prints the number

=back

=head1 AUTHOR

William Stevenson <william@skybluecircles.com>

=head1 COPYRIGHT AND LICENSE

This software is copyright (c) 2014 by William Stevenson.

This is free software, licensed under:

    The GNU Public License version 3.0

=cut
