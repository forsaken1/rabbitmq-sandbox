# RabbitMQ sandbox

## Installation

`docker pull rabbitmq:3-management`

`docker run --rm -it -p 15672:15672 -p 5672:5672 rabbitmq:3-management`

## Run

push message to queue

`ruby backend.rb`

receive messages from queue

`ruby sms_service.rb`
