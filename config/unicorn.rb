rails_root = File.expand_path('../../', __FILE__)

worker_processes 2
working_directory rails_root
timeout 30
listen (File.expand_path 'tmp/sockets/.unicorn.sock', rails_root)
pid (File.expand_path 'tmp/pids/unicorn.pid', rails_root)

stderr_path File.expand_path('log/unicorn.stderr.log', rails_root)
stdout_path File.expand_path('log/unicorn.stdout.log', rails_root)

preload_app true

before_exec do |server|
  ENV['BUNDLE_GEMFILE'] = "#{rails_root}/Gemfile"
end

before_fork do |server, worker|
  defined?(ActiveRecord::Base) and
      ActiveRecord::Base.connection.disconnect!

  old_pid = "#{server.config[:pid]}.oldbin"
  if old_pid != server.pid
    begin
      Process.kill "QUIT", File.read(old_pid).to_i
    rescue Errno::ENOENT, Errno::ESRCH
    end
  end
end

after_fork do |server, worker|
  defined?(ActiveRecord::Base) and
      ActiveRecord::Base.establish_connection
end