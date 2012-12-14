class Rubalto::ComposedBlock < Rubalto::Element
  def to_s
    children.map(&:to_s)
  end
end
