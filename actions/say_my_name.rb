

module Action
  class SayMyName < Base

    def process! message_text, user, channel
      channel.send_text "Hey #{user.name}, #{message_text} toi même !"
    end
  end
end