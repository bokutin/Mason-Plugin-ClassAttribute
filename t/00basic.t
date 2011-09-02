use strict;
use Test::More;

use IO::All;
use Mason;

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
    isnt( $output1, $output3 );
}

{
    my $output1 = $interp->run("/02class_has")->output;
    my $output2 = $interp->run("/02class_has")->output;
    ok( io("t/comp/02class_has.mc")->touch );
    my $output3 = $interp->run("/02class_has")->output;

    is( $output1, $output2 );
    isnt( $output1, $output3 );
}

done_testing();
