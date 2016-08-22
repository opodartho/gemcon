require 'test_helper'

describe Gemcon::Cli do
  describe '#version' do
    it 'prints version number' do
      %w(version -v --version).freeze.each do |option|
        out = capture_io { Gemcon::Cli.start [option] }.join ''
        out.must_match "Gemcon #{Gemcon::VERSION}"
      end
    end
  end
end
