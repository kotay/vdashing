# require 'rubygems'
# require 'bundler/setup'
# require 'nibbler'
# require 'nokogiri'
# require 'faraday'
# require 'openssl'
# require 'pry'

# class WebFetch
#   attr_accessor :uri, :document, :klass
  
#   OpenSSL::SSL::VERIFY_PEER = OpenSSL::SSL::VERIFY_NONE

#   def self.parse(uri, &block)
#     new(uri, &block)
#   end
 
#   def initialize(uri, &block)
#     @document, @uri = fetch uri
#     @klass = Class.new(Nibbler) { instance_eval(&block) }.parse(@document.body)
#   end
 
#   def method_missing(m)
#     @klass.send(:"#{m}")
#   end
 
#   private
#    def fetch(uri)
#      response = Faraday.get uri, :ssl => {:verify => false}
#      if [301,302].include?(response.status)
#        uri = response.headers['location']
#        response = fetch(uri).first
#      end
#      [response, uri]
#    end
# end

# c = WebFetch.parse("http://community.viaduct.io") do
#   element 'body' => :wrapper
# end
