class Rubalto::Element
  attr_reader :id
  attr_reader :name
  attr_reader :parent
  attr_reader :children

  attr_reader :hpos
  attr_reader :vpos
  attr_reader :width
  attr_reader :height
  attr_reader :content_type
  attr_reader :value

  def self.subclass_names
    Rubalto.constants.select{|c| c = Rubalto::const_get(c); c.is_a?(Class) && c < Rubalto::Element }.map(&:to_s)
  end

  def self.create(parent, element)
    if subclass_names.include?(element.name)
      Rubalto.const_get(element.name).new(element, parent)
    else
      new(element, parent)
    end
  end

  def initialize(element, parent = nil)
    @name   = element.name
    @parent = parent
    @id     = element.attribute('ID').value
    @hpos   = element.attribute('HPOS').value.to_i
    @vpos   = element.attribute('VPOS').value.to_i
    @height = element.attribute('HEIGHT').value.to_i
    @width  = element.attribute('WIDTH').value.to_i

    t = element.attribute('TYPE')
    c = element.attribute('CONTENT')

    @content_type = t.value.strip if t
    @value = c.value if c

    @children = element.children.select{|el|
      el if self.class.subclass_names.include?(el.name)
    }.map{|el| Rubalto::Element.create(self, el) }
  end
end
