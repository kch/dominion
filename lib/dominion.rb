require File.join(File.dirname(__FILE__), "dominion/domain_suffix_rule")
require File.join(File.dirname(__FILE__), "dominion/domain_name")

Dominion::DomainName.load_rules_from_file(File.join(File.dirname(__FILE__), '../var/tlds.dat'))
