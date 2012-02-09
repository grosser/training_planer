require 'yaml'

if File.exist?('config/config.yml')
  config = IO.read('config/config.yml')
else
  warn "USING EXAMPLE CONFIG, please customize"
  config = IO.read('config/config.example.yml')
end

CFG = YAML.load(ERB.new((config)).result)[Rails.env].with_indifferent_access
