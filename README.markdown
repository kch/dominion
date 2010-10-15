# Dominion

Dominion is a library to extract information from a domain name.

We're basically interested in two particulars:

• The de facto TLD: this is the part of the domain a NIC would be responsible for.
  It may be an honest-to-god TLD, or a ccTLD, and more importantly, a ccSLD.

• The base domain. That is the domain that is registered with the NIC, clear of
  any subdomains.

To resolve this we rely on the Mozilla Foundation's Public Suffix List, which can
be found at <http://publicsuffix.org/list/>.

See <http://publicsuffix.org/> to learn more.

A copy of the list file is provided with this library in `var/tlds.dat`, and loaded
automatically when you `require 'dominion'`.


# Usage

    require 'dominion'

    d = Dominion::DomainName.new(".name")
    d.tld?  # => true
    d.tld   # => "name"
    d.base  # => "name"

    d = Dominion::DomainName.new("foo.bar.co.uk")
    d.tld?  # => false
    d.tld   # => "co.uk"
    d.base  # => "bar.co.uk"


# Colophon

Copyright © 2010 Caio Chassot  
Released under the MIT license  
<http://github.com/kch/dominion>  
