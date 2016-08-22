require "thor"
module Gemcon
  class Runner < Thor
    include Thor::Actions
    argument :app_name

    desc "new [APP_NAME]", "Generate a simple console application"
    def new
      generate
    end

    private

    def generate
      template("Gemfile.tt", "Gemfile")
      template("app/project.tt", "app/#{app_name}.rb")
      template("config/boot.tt", "config/boot.rb")
    end

    def template(template, filename)
      super(Gemcon.root.join("templates", template), "#{app_name}/#{filename}")
    end

    class << self
      def source_root
        File.dirname(__FILE__)
      end
    end
  end
end
