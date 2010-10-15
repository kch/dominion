#!/usr/bin/env ruby
# encoding: UTF-8

module Dominion
  class DomainSuffixRule
    attr_reader :labels, :exception, :length

    def initialize(s)
      @string    = s.strip.gsub(/\A\.|\.\z/, '')
      @labels    = @string.split(/\A!|\./).reverse
      @exception = @labels.last.empty? and @labels.pop
      @length    = @labels.length - (@exception ? 1 : 0)
    end

    # match against a domain name. the domain must be an instance of DomainName
    def =~(domain)
      labels.zip(domain.labels).all? { |r, d| ["*", d].include? r }
    end

    def inspect
      @string
    end


    protected

    # these are used internally for sorting a list of rules so that the first match is the correct match
    # according to the algorithm defined in http://publicsuffix.org/format/

    def comparable
      [@exception ? 0 : 1, -@length, @string]
    end

    def <=> other
      comparable <=> other.comparable
    end
  end
end
