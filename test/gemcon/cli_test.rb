require 'test_helper'
require 'pry'

describe Gemcon::Cli do
  describe '#new' do
    before do
      FakeFS do
        FakeFS::FileSystem.clone(Gemcon::Cli.source_root)
      end
    end

    it 'generate files and directories' do
      FakeFS do
        Gemcon::Cli.start %w(new TreeFlex)
        assert File.directory? 'TreeFlex'
        assert File.directory? 'TreeFlex/app'
        assert File.directory? 'TreeFlex/config'
        assert File.directory? 'TreeFlex/bin'
        assert File.file? 'TreeFlex/app/TreeFlex.rb'
        assert File.file? 'TreeFlex/bin/console'
        assert File.file? 'TreeFlex/config/boot.rb'
        assert File.file? 'TreeFlex/Gemfile'
      end
    end

    it 'prints usqges error' do
      out = capture_io { Gemcon::Cli.start %w(new) }.join ''
      binding.pry
    end
  end

  describe '#version' do
    it 'prints version number' do
      %w(version -v --version).freeze.each do |option|
        out = capture_io { Gemcon::Cli.start [option] }.join ''
        out.must_match "Gemcon #{Gemcon::VERSION}"
      end
    end
  end
end
