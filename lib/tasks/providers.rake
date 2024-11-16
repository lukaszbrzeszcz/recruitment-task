namespace :providers do
  desc "Delete providers and load from config file"
  task reload_from_config: :environment do
    Providers::Organizers::ReloadFromConfig.call
  end
end
