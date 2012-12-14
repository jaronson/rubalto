class Rubalto::TextBlock < Rubalto::Element
  def to_s
    children.map(&:to_s).join("\n")
  end
end
