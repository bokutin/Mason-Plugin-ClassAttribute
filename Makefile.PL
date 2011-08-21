use inc::Module::Install;

name 'Mason-Plugin-ClassAttribute';
all_from 'lib/Mason/Plugin/ClassAttribute.pm';

requires 'Mason' => "2.13";
requires 'MooseX::ClassAttribute';

auto_install;
auto_set_repository;
githubmeta;

WriteAll;
