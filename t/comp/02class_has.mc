<%class>
class_has obj => ( is => "rw", default => sub { rand } );
</%class>

<%perl>
    $m->print( $.meta->get_class_attribute('obj')->has_default ? "has_default=1" : "has_default=0" );
    $m->print( " " );
    $m->print( "default=" . $.meta->get_class_attribute('obj')->default );
    $m->print( " " );
    $m->print( $.obj );
</%perl>
