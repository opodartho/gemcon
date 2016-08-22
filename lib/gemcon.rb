require 'pathname'
require 'gemcon/runner'
require 'gemcon/version'

module Gemcon
  class << self
    def root
      @base ||= Pathname.new(__FILE__).join('../..')
    end
  end
end
