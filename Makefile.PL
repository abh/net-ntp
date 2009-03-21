use 5.008;
use ExtUtils::MakeMaker;

WriteMakefile(
    'NAME'         => 'Net::NTP',
    'VERSION_FROM' => 'NTP.pm',     # finds $VERSION
    'PREREQ_PM'    => {},           # e.g., Module::Name => 1.1
    (   $] >= 5.005
        ?                           ## Add these new keywords supported since 5.005
          ( ABSTRACT_FROM => 'NTP.pm',                               # retrieve abstract from module
            AUTHOR        => 'Ask Bjørn Hansen <ask@develooper.com>'
          )
        : ()
    ),
);
