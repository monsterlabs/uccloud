require 'rubygems'
require 'json'
require 'mail'
require 'redis'
require 'open3'
require 'resque'
require 'resque-remote'

class Mail::Message
  def to_hash
    hash = {}
    hash[:from] = from
    hash[:to] = to
    hash[:cc] = cc
    hash[:subject] = subject
    hash[:body] = body
    hash[:date] = date.to_s
    hash
  end
end

redis = Redis.new

message = $stdin.read
mail = Mail.new(message)
mail_json = mail.to_hash.to_json
redis.rpush "mail_queue", mail_json

mail = Mail.new do
  from     'info@uccld.com'
  to       'hectoregm@gmail.com'
  #to       ['hectoregm@gmail.com', 'juanger@gmail.com', 'shanaa@gmail.com']
  subject  'New email in the queue'
  body     mail_json
end

cmd = "/usr/sbin/sendmail -G -i -r #{ARGV[0]} #{ARGV[1]}"
stdin, stdouterr, wait_thr = Open3.popen2e(cmd)
stdin.print(message)
stdin.close
stdouterr.close

mail.delivery_method :sendmail
mail.deliver
exit(0)
