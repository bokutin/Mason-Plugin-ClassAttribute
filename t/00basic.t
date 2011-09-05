use strict;
use Test::More;

use IO::All;
use Mason;
use Test::Exception;

my $DEBUG = 0;

my $interp = Mason->new(
    comp_root => "t/comp",
    plugins => [
        "ClassAttribute",
    ],
);

{
    my $output = $interp->run("/00hello")->output;
    is( $output, "HELLO WORLD!!\n" );
}

{
    my $output1 = $interp->run("/01handmaid")->output;
    my $output2 = $interp->run("/01handmaid")->output;
    ok( io("t/comp/01handmaid.mc")->touch );
    my $output3 = $interp->run("/01handmaid")->output;

    is( $output1, $output2 );
    isnt( $output3, $output1 );
}

{
    my $output1 = $interp->run("/02class_has")->output;
    my $output2 = $interp->run("/02class_has")->output;
    ok( io("t/comp/02class_has.mc")->touch );
    my $output3 = $interp->run("/02class_has")->output;

    $DEBUG && diag( $output1 );
    $DEBUG && diag( $output2 );
    $DEBUG && diag( $output3 );

    ok ( $output1 =~ s/has_default=1 // );
    ok ( $output2 =~ s/has_default=1 // );
    ok ( $output3 =~ s/has_default=1 // );

    ok ( $output1 =~ s/default=CODE\S* // );
    ok ( $output2 =~ s/default=CODE\S* // );
    ok ( $output3 =~ s/default=CODE\S* // );

    ok( $output1 );
    ok( $output2 );
    ok( $output3 );

    is( $output1, $output2 );
    isnt( $output3, $output1 );
}

{
    my $output1 = $interp->run("/03class_has_lazy")->output;
    my $output2 = $interp->run("/03class_has_lazy")->output;
    ok( io("t/comp/03class_has_lazy.mc")->touch );
    my $output3 = $interp->run("/03class_has_lazy")->output;

    $DEBUG && diag( $output1 );
    $DEBUG && diag( $output2 );
    $DEBUG && diag( $output3 );

    ok( $output1 );
    ok( $output2 );
    ok( $output3 );

    ok ( $output1 =~ s/has_value=0 // );
    ok ( $output2 =~ s/has_value=1 // );
    ok ( $output3 =~ s/has_value=0 // );

    is( $output1, $output2 );
    isnt( $output3, $output1 );
}

{
    my $output1;
    lives_ok( sub { $output1 = $interp->run("/04is_rw_default")->output } );
    ok( $output1 );
}

{
    package Foo;
    use Moose;
    use MooseX::ClassAttribute;
    class_has obj => ( default => sub { rand } );

    package main;

    throws_ok( sub { Foo->new->obj }, qr/^Can't locate object method "obj"/ );
}

{
    package Bar;
    use Moose;
    has obj => ( default => sub { rand } );

    package main;

    throws_ok( sub { Bar->new->obj }, qr/^Can't locate object method "obj"/ );
}

done_testing();
