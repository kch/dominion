# encoding: UTF-8
require 'open-uri'

MOZILLA_TLDS_URL = "http://mxr.mozilla.org/mozilla-central/source/netwerk/dns/effective_tld_names.dat?raw=1"
LOCAL_TLDS_PATH  = File.join(File.dirname(__FILE__), "var/tlds.dat")

desc "Pull an updated tlds.dat from Mozilla"
task :update do
  src = open(MOZILLA_TLDS_URL, "r:UTF-8")
  dst = open(LOCAL_TLDS_PATH, "w:UTF-8")
  dst.write src.read
  dst.close
end
