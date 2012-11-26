namespace :passenger do
  desc "Start passenger"
  task :start, :env, :port, :min, :max do |t, args|
    env = args[:env] || "production"
    port = args[:port] || 8888
    min = args[:min] || 3
    max = args[:max] || 6
    system "bundle exec passenger start -e #{env} -p #{port} --max-pool-size #{max} --min-instances #{min} -d"
  end
  task :stop, :port do |t, args|
    port = args[:port] || 8888
    system "bundle exec passenger stop -p #{port} && echo 'Passenger was stopped.'"
  end
  task :restart do
    system "touch tmp/restart.txt && echo 'Passenger was restarted.'"
  end
end
