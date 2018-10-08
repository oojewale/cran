namespace :packages do
  desc 'Indexes packages'
  task index: :environment do
    puts "Task running..."
    Fetchers::PackageIndexerService.new.call
    puts "Task complete!"
  end
end
