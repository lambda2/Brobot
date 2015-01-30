

require "./adapters/adapter"
require "slack_client"

# Finalement, je sais pas si useful
class SlackAdapter < Adapter

  class SlackClientAdapter < SlackClient::Client
    def initialize(base, params)
      super(params)
      @base = base
    end

    [:onOpen, :onMessage, :onError, :onClose].each do |method|
      define_method method do |data|
        @base.send(method, data)
      end
    end

  end

  def initialize(base, params = {})
    super(base, params)
    @bot = SlackClientAdapter.new(self, params[:slack_token] || "")
    @bot.login
  end

  [:onOpen, :onMessage, :onError, :onClose].each do |method|
    define_method method do |data|
      @base.send(method, data)
    end
  end

end
