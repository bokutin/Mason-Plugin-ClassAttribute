<%class>
method obj { no strict 'refs'; ${CLASS."::OBJ"} ||= rand }
</%class>

<%perl>
    $m->print( $.obj );
</%perl>
