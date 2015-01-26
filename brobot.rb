
require "json"
require "net/https"
require "uri"
require "slack_client"

class Brobot < SlackClient::Client

  # Si on veut faire des adapters plus tard...
  # ADAPTERS = [SlackAdapter]

  # def initialize(params = {})
  #   @adapters = ADAPTERS.map { |a| a.new(self, params) }
  # end

  def initialize(params = {})
    super(params[:slack_token])
  end

  def onOpen data
    print "[BROBOT] _onOpen !"
  end

  def onMessage message
    print "[BROBOT] _onMessage #{message}"
    case message["type"]
    when "hello"
      channel = getChannelGroupOrDMByName "battlefield"
      # p channel
      channel.send_text "Hello world !"

    when "message"
      channel = getChannelGroupOrDMByName "battlefield"
      user = getUserByID(message["user"])
      # p channel
      channel.send_text "Hello #{user.name} !"
    end
  end

  def onError error
    print "[BROBOT] _onError #{error}"
  end
end
