
require "json"
require "net/https"
require "uri"
require "slack_client"

require "./actions/action"

class Brobot < SlackClient::Client

  # Si on veut faire des adapters plus tard...
  # ADAPTERS = [SlackAdapter]

  # def initialize(params = {})
  #   @adapters = ADAPTERS.map { |a| a.new(self, params) }
  # end

  def initialize(params = {})
    super(params[:slack_token])
    @actions = Action.actions.map { |e| e.new(self) }
  end

  def onOpen data
    # puts "[BROBOT] _onOpen !"
    puts @self.id
  end

  def onMessage message
    return if message["channel"] == "general"
    # puts "[BROBOT] _onMessage #{message.inspect}"
    case message["type"]
    # when "hello"
      # channel = getChannelGroupOrDMByName "battlefield"
      # p channel
      # channel.send_text "Hello world !"

    when "message"
      if talking_to_me? message["text"]
        channel = getChannelGroupOrDMByID(message["channel"])
        user = getUserByID(message["user"])
        @actions.each{|a| a.process!(message["text"].gsub("<@#{@self.id}>:", ""), user, channel)}
      end
      # channel = getChannelGroupOrDMByName "battlefield"
      # p channel
      # channel.send_text "Hello #{user.name} !"
    end
  end

  def onError error
    # puts "[BROBOT] _onError #{error}"
  end

  private

  def talking_to_me? message_text
    message_text["<@#{@self.id}>"]
  end
end
