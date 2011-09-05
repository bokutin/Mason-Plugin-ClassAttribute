<%class>
class_has obj => ( default => sub { rand } );
</%class>

<%perl>
    $m->print( $.obj );
</%perl>
