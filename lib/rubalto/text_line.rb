class Rubalto::TextLine < Rubalto::Element
  def to_s
    children.map(&:to_s).join(' ')
  end
end
