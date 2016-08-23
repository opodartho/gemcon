require 'thor'
module Gemcon
  # Gemcon Cli define tasks using thor
  class Cli < Thor
    include Thor::Actions

    desc 'new [APP_NAME]', 'Generate a simple console application'
    option :ruby, aliases: '-r'
    def new(app_name = nil)
      raise Error, 'Usage: gemcon new [APP_NAME]' if app_name.nil?
      path = File.expand_path(app_name)
      raise(
        Error,
        set_color("ERROR: #{path} already exists.", :red)
      ) if File.exist?(path)

      @app_name = app_name
      generate
    end

    desc 'version', 'Display version'
    map %w(-v --version) => :version

    def version
      say "Gemcon #{VERSION}"
    end

    private

    def generate
      template('Gemfile.tt', 'Gemfile')
      template('app/project.tt', "app/#{@app_name}.rb")
      template('config/boot.tt', 'config/boot.rb')
      template('bin/console', 'bin/console')
      chmod "#{@app_name}/bin/console", 0o755
    end

    def template(template, filename)
      super(template, "#{@app_name}/#{filename}")
    end

    class << self
      def source_root
        Pathname.new(__FILE__).join('../../../templates')
      end
    end
  end
end
