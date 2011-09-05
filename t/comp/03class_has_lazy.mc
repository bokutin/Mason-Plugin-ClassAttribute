<%class>
class_has obj => ( is => "rw", lazy_build => 1 );

method _build_obj { rand }
</%class>

<%perl>
    $m->print( $.meta->get_class_attribute('obj')->has_value($self) ? "has_value=1" : "has_value=0" );
    $m->print( " " );
    $m->print( $.obj );
</%perl>
