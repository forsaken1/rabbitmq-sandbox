require_relative 'sms_service'

$stdout.sync = true # fix logs in Docker container

SmsService.new.call
