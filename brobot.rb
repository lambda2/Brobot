
require "json"
require "net/https"
require "uri"
require "./client"

class Brobot < Client

  def onOpen
    print "[BROBOT] _onOpen !"
  end


  def onMessage message
    # print "[BROBOT] _onMessage #{message}"
    case message["type"]
    when "hello"
      channel = getChannelGroupOrDMByName "battlefield"
      # p channel
      channel.send_message "Hello world !"

    when "message"
      channel = getChannelGroupOrDMByName "battlefield"
      user = getUserByID(message["user"])
      # p channel
      channel.send_message "Hello #{user.name} !"
    end
  end

  def onError error
    print "[BROBOT] _onError #{error}"
  end

end


Brobot.on :open do
  "EVENT EMMITER CONNECT SYM"
end
Brobot.on 'open' do
  "EVENT EMMITER CONNECT QUOTE"
end