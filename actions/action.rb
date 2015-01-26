
# La classe de base pour toutes les actions
module Action

  @@actions = []

  class Base

    def initialize(base)
      @base = base
    end

    def process! message_text, user, channel
      raise "Not implemented"
    end

    def self.inherited(child)
      Action.new_action child
    end
  end

  def self.actions
    @@actions
  end

  def self.new_action action
    @@actions << action
  end

end

require "./actions/say_my_name"