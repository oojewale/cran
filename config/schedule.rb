set :output, "#{Whenever.path}/log/cron_log.log"

every 1.day, at: '12:00 pm' do
  rake "packages:index"
end
