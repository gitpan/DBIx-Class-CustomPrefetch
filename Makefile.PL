use inc::Module::Install;

name     'DBIx-Class-CustomPrefetch';
all_from 'lib/DBIx/Class/CustomPrefetch.pm';
author   'Andrey Kostenko <andrey@kostenko.name>';
license  'perl';

build_requires 'Test::More';
requires 'DBIx::Class', '0.081';
requires 'Module::Load';
requires 'Sub::Name';
requires 'DBIx::Class::VirtualColumns';

auto_install;

WriteAll;

