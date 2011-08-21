package Mason::Plugin::ClassAttribute::Component::Import;

use Mason::PluginRole;

require MooseX::ClassAttribute;

after import_into => sub {
    my ( $class, $for_class ) = @_;

    MooseX::ClassAttribute->import( { into => $for_class } );
};

1;
