package FizzBuzz;

use strict;
use warnings;

use v5.18;

use autodie qw(:all);
use feature qw(say);

use Moose;
use MooseX::StrictConstructor;

with 'MooseX::Getopt::Dashes';

has fizz => (
    is      => 'ro',
    isa     => 'Int',
    default => 3,
);

has buzz => (
    is      => 'ro',
    isa     => 'Int',
    default => 5,
);

has _fizz_buzz => (
    is       => 'ro',
    isa      => 'Int',
    builder  => '_build_fizz_buzz',
    lazy     => 1,
    init_arg => undef,
);

has start => (
    is      => 'ro',
    isa     => 'Int',
    default => 1,
);

has stop => (
    is      => 'ro',
    isa     => 'Int',
    default => 100,
);

sub _build_fizz_buzz {
    my $self = shift;

    return $self->fizz * $self->buzz;
}

sub BUILD {
    my $self = shift;

    if ( $self->fizz == $self->buzz ) {
        die sprintf
            "fizz and buzz must be different numbers, but you passed %d for both$/",
            $self->fizz;
    }

    if ( $self->stop <= $self->start ) {
        die "stop must be less than start$/";
    }
}

sub series {
    my $self = shift;

    return [ map { $self->_fizz_buzz_num( $_ ) }
            $self->start .. $self->stop ];
}

sub print {
    my $self = shift;

    foreach my $element ( @{ $self->series } ) {
        say $element; 
    }
}

sub _fizz_buzz_num {
    my $self = shift;
    my $num  = shift;

    if ( $num % $self->_fizz_buzz == 0 ) {
        return 'FizzBuzz';
    }
    elsif ( $num % $self->buzz == 0 ) {
        return 'Buzz';
    }
    elsif ( $num % $self->fizz == 0 ) {
        return 'Fizz';
    }
    else {
        return $num;
    }
}

__PACKAGE__->meta()->make_immutable();

1;

=pod

=head1 NAME

FizzBuzz

=head1 SYNOPSIS

    my $fb_series = FizzBuzz->new( fizz = 3, buzz = 5, start = 1, stop = 100 )
        ->series();

    FizzBuzz->new_with_options()->print();

=head1 DESCRIPTION

Creates the FizzBuzz series between C<start> and C<stop> inclusive given your C<fizz> and your C<buzz>.

Has a convenience method to print the series.

=head1 SERIES DEFINITION

For the integers from C<start> to C<stop> inclusive, if the integer:

=over 4

=item

is divisible by C<fizz> and not C<buzz>, replaces integer with 'Fizz'

=item

is divisible by C<buzz> and not C<fizz>, replaces integer with 'Buzz'

=item

is divisible by both C<fizz> and C<buzz>, replaces integer with 'FizzBuzz'

=back

otherwise, the integer is unchanged.

=head1 EXAMPLE

    FizzBuzz->new( fizz = 3, buzz = 5, start = 1, stop = 16 )->print();

    # 1
    # 2
    # Fizz
    # 4
    # Buzz
    # Fizz
    # 7
    # 8
    # Fizz
    # Buzz
    # 11
    # Fizz
    # 13
    # 14
    # FizzBuzz
    # 16

=head1 CONSTRUCTORS

=head2 C<new>

I<See attributes in section below.>

=head2 C<new_with_options>

Like new, but lets you pass the attribute values on the command line if used in a script. See L<MooseX::Getopt::Dashes> for more info.

=head1 ATTRIBUTES

=head2 C<fizz>

An integer.

Default is 3.

=head2 C<buzz>

An integer.

Default is 5.

An exception is raised if it is the same integer as C<buzz>.

=head2 C<start>

The integer from which the FizzBuzz series starts.

Default is 1.

=head2 C<stop>

The integer at which the FizzBuzz series stops.

Default is 100.

An exception is raised if C<stop> is less than or equal to C<start>.

=head1 METHODS

=head2 C<series>

Returns your FizzBuzz series as an array ref.

=head2 C<print>

Prints each element of your FizzBuzz series to STDOUT followed by $/.

=head1 AUTHOR

William Stevenson <wds@cpan.org>

=head1 COPYRIGHT AND LICENSE

This software is Copyright (c) 2014 by William Stevenson.

This is free software, licensed under:

    The Artistic License 2.0 (GPL compatible)

=cut
