require 'thor'
module Gemcon
  class Cli < Thor
    include Thor::Actions

    desc 'new [APP_NAME]', 'Generate a simple console application'
    def new(app_name)
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
