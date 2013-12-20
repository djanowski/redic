require_relative "../lib/redic"

redis = spawn("redis-server --unixsocket /tmp/redis.sock --port 6379 --logfile /dev/null --dbfilename ''")

at_exit do
  Process.kill(:INT, redis)
  Process.wait
end

loop do
  begin
    TCPSocket.new("127.0.0.1", 6379).close
    break
  rescue Errno::ECONNREFUSED
  end
end
