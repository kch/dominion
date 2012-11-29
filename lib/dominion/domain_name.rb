#!/usr/bin/env ruby
# encoding: UTF-8

module Dominion
  class DomainName
    attr_reader :labels, :rule

    # returns the current rule list or takes a new rule list; rules must be DomainSuffixRule instances.
    def self.rules(rules = nil)
      @rules = rules if rules
      @rules
    end

    # takes the path to a rule file in the format defined in http://publicsuffix.org/list/
    def self.load_rules_from_file(path)
      rules open(path, "r:UTF-8").lines.reject { |s| s =~ %r[\A\s*(//.*)?\Z\n?] }.map { |s| DomainSuffixRule.new(s) }.sort << DomainSuffixRule.new("*")
    end

    # takes a domain string as argument; i.e. the hostname part of a URL
    def initialize(s)
      raise "No DomainSuffixRule rules loaded" unless self.class.rules
      @labels = s.strip.gsub(/\A\.|\.\z/, '').split(".").reverse
      @rule   = self.class.rules.find { |rule| rule =~ self } or raise "Domain #{s.inspect} didn't match any rule."
    end

    # is this a TLD, ccTLD, ccSLD, etc.?
    def tld?
      labels.length == rule.length
    end

    # is this the root domain?
    def base?
      labels.length == rule.length.succ
    end
    alias_method :naked?, :base?
    alias_method :root?,  :base?
    alias_method :apex?,  :base?

    # returns the TLD part of the domain
    def tld
      domain(0)
    end

    # returns the base domain; i.e. the registered domain
    def base
      domain(1)
    end
    alias_method :naked, :base
    alias_method :root,  :base
    alias_method :apex,  :base

    # returns the complete hostname
    def full
      domain(labels.length - rule.length)
    end
    alias_method :to_s, :full

    # return the domain with the specified number of extra labels over the TLD. Used internally.
    def domain(non_tld_label_count = 1)
      labels[0, rule.length + non_tld_label_count].reverse.join(".")
    end

  end
end
