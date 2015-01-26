
# Interface pour les adaptateurs
class Adapter

  def initialize(base, params = {})
    @base = base
    @params = params
  end

  def onOpen data
    raise "Not implemented"
  end

  def onMessage message
    raise "Not implemented"
  end

  def onError error
    raise "Not implemented"
  end

  def onClose data
    raise "Not implemented"
  end

end