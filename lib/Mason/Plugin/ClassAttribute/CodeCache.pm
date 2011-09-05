package Mason::Plugin::ClassAttribute::CodeCache;

use Mason::PluginRole;

use Devel::GlobalDestruction;

before remove => sub {
    my $self = shift;
    my $key  = shift;

    if ( my $entry = $self->{datastore}->{$key} ) {
        if ( !in_global_destruction() ) {
            my $compc = $entry->{compc};

            use PadWalker qw(peek_sub);
            my $ref  = peek_sub(\&Eval::Closure::_make_compiler)->{'%compiler_cache'};
            my $name = $compc->meta->_class_attribute_var_name;
            for ( grep { /\b$name\b/ } keys %$ref ) {
                delete $ref->{$_};
            }
        }
    }
};

#around remove => sub {
#    my $orig = shift;
#    my $self = shift;
#    my $key  = shift;
#
#    my $name;
#    my $value;
#    if ( my $entry = $self->{datastore}->{$key} ) {
#        if ( !in_global_destruction() ) {
#            my $compc = $entry->{compc};
#
#            for ( $compc->meta->get_class_attribute_list ) {
#                $compc->meta->clear_class_attribute_value($_);
#            }
#
#            no strict 'refs';
#            $name  = $compc->meta->_class_attribute_var_name;
#            $value = \%{$name};
#        }
#    }
#
#    my $ret = $self->$orig($key, @_);
#
#    {
#        no strict 'refs';
#        *{$name} = $value;
#    }
#
#    $ret;
#};

1;
