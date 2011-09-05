package Mason::Plugin::ClassAttribute::Component::Import;

use Mason::PluginRole;

require MooseX::ClassAttribute;

my $role = Moose::Meta::Role->create_anon_role;
$role->add_around_method_modifier('_process_new_class_attribute',
    sub {
        my $orig = shift;
        my $self = shift;
        my $name = shift;
        my %p    = @_;
        push @{$p{traits}}, "MooseX::HasDefaults::Meta::IsRW";
        $self->$orig($name, %p);
    }
);

after import_into => sub {
    my ( $class, $for_class ) = @_;

    MooseX::ClassAttribute->import( { into => $for_class } );

    Moose::Util::MetaRole::apply_metaroles(
        for             => $for_class,
        class_metaroles => {
            class => [$role->name],
        },
    );
};

1;
