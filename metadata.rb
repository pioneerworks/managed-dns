name             'managed-dns'
maintainer       'Homebase, Inc.'
maintainer_email 'dev@joinhomebase.com'
license          'MIT'
description      'Managed DNS cookbook with pluggable adapters, supporting DnsMadeEasy'
long_description IO.read(File.join(File.dirname(__FILE__), 'README.md'))
version          '1.0.2'

source_url       'https://github.com/pioneerworks/managed-dns'
issues_url       'https://github.com/pioneerworks/managed-dns/issues'

supports 'ubuntu'

gem 'dnsmadeeasy-rest-api', git: 'https://github.com/kigster/dnsmadeeasy-rest-api'

depends 'hostname'
