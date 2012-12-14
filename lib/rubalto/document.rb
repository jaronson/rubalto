class Rubalto::Document
  attr_reader :xml
  attr_reader :height
  attr_reader :width
  attr_reader :top_margin
  attr_reader :left_margin
  attr_reader :right_margin
  attr_reader :bottom_margin
  attr_reader :print_space

  def self.define_collection(attr)
    define_method(attr) do
      var_name = "@#{attr}"
      return instance_variable_get(var_name) if instance_variable_defined?(var_name)

      coll = []
      klass = Rubalto.const_get(attr.to_s.gsub(/(^[a-z])|(_[a-z])/){|s| s.gsub('_','').upcase }.gsub(/s$/,''))
      recursively_add_elements(klass, coll)
      instance_variable_set(var_name, coll)
    end
  end

  define_collection :composed_blocks
  define_collection :text_blocks
  define_collection :text_lines
  define_collection :strings

  def initialize(filename)
    @xml = Nokogiri::XML::Document.parse(filename)

    page = xml.css('Page').first
    @height = page.attribute('HEIGHT').value.to_i
    @width  = page.attribute('WIDTH').value.to_i

    ['Top', 'Left', 'Right', 'Bottom' ].each do |pos|
      el = Rubalto::Element.new(xml.css("#{pos}Margin").first)
      instance_variable_set("@#{pos.downcase}_margin", el)
    end

    @print_space = Rubalto::Element.new(xml.css('PrintSpace').first)
  end

  def render_to_file(filename)
    File.open(filename, 'w'){|f| f.write(to_html)}
  end

  def to_html
    return @html if @html

    @html_renderer = Rubalto::HtmlRenderer.new(self)
    @html = @html_renderer.render
  end

  private
  def recursively_add_elements(klass, collection, element = nil)
    element ||= print_space
    collection << element if element.is_a?(klass)
    if element.children.any?
      element.children.each{|child| recursively_add_elements(klass, collection, child)}
    end
  end
end
