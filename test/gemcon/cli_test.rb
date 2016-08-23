require 'test_helper'

describe Gemcon::Cli do
  include FakeFS::SpecHelpers
  describe '#new' do
    before do
      FakeFS::FileSystem.clone(Gemcon::Cli.source_root)
    end

    it 'generate files and directories' do
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

    it 'prints usqges error' do
      out = capture_io { Gemcon::Cli.start %w(new) }.join ''
      out.must_match 'Usage: gemcon new [APP_NAME]'
    end

    describe '#options' do
      it 'add ruby version in Gemfile' do
        Gemcon::Cli.start %w(new TreeFlex --ruby=2.1.5)
        gemfile_content = FakeFS::FileSystem.find('TreeFlex/Gemfile').content
        assert(gemfile_content.include?("ruby '2.1.5'"))
      end
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
