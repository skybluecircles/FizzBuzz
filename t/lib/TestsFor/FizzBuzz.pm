package TestsFor::FizzBuzz;

use strict;
use warnings;

use v5.15;

use autodie qw(:all);
use feature qw(say);

use FizzBuzz;

use Test::Class::Moose;
use Test::Fatal;

sub test_valid {
    my @tests = (
        {   params   => { fizz => 3, buzz => 5, start => 1, stop => 16, },
            expected => [
                qw/
                    1
                    2
                    Fizz
                    4
                    Buzz
                    Fizz
                    7
                    8
                    Fizz
                    Buzz
                    11
                    Fizz
                    13
                    14
                    FizzBuzz
                    16
                    /
            ],
        },
        {   params   => { fizz => 2, buzz => 3, start => 1, stop => 16, },
            expected => [
                qw/
                    1
                    Fizz
                    Buzz
                    Fizz
                    5
                    FizzBuzz
                    7
                    Fizz
                    Buzz
                    Fizz
                    11
                    FizzBuzz
                    13
                    Fizz
                    Buzz
                    Fizz
                    /
            ],
        },
    );

    foreach my $test ( @tests ) {
        is_deeply( FizzBuzz->new( $test->{params} )->series(),
            $test->{expected} );
    }
}

sub test_invalid {
    my @tests = (
        {   params => { fizz => 2, buzz => 2, start => 1, stop => 16, },
            expected => qr/^fizz and buzz must be different/,
        },
        {   params => { fizz => 2, buzz => 5, start => 16, stop => 1, },
            expected => qr/^stop must be less than start/,
        },
    );

    my $exception_class = 'FizzBuzz::Exception';

    foreach my $test ( @tests ) {
        my $exception = exception { FizzBuzz->new( $test->{params} ) };

        ok( blessed $exception && $exception->isa($exception_class) );
        like( $exception->as_string, $test->{expected} );
    }
}

1;
