<%class>
class_has obj => ( is => "rw", default => sub { rand } );
</%class>

<%perl>
    $m->print( $.obj );
</%perl>
