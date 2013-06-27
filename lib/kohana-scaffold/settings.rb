class Settings < Settingslogic
  source File.join(File.dirname(__FILE__), "config.yml")
  namespace "options"
  load!
end
