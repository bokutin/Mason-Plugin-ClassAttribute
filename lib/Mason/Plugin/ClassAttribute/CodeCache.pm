package Mason::Plugin::ClassAttribute::CodeCache;

use Mason::PluginRole;

use Devel::GlobalDestruction;

before remove => sub {
    my $self = shift;
    my $key  = shift;

    if ( my $entry = $self->{datastore}->{$key} ) {
        if ( !in_global_destruction() ) {
            my $compc = $entry->{compc};

            for ( $compc->meta->get_class_attribute_list ) {
                $compc->meta->clear_class_attribute_value($_);
            }
        }
    }
};

1;
