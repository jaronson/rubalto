class Rubalto::HtmlRenderer
  attr_reader :document
  attr_reader :builder

  def initialize(doc)
    @document = doc
  end

  def render
    @html = build_html

    dir   = Rubalto::TEMPLATES_DIR
    css   = File.read(File.join(dir, 'rubalto.css'))
    js    = File.read(File.join(dir, 'rubalto.js'))
    eruby = Erubis::Eruby.new(File.read(File.join(dir, 'rubalto.html.erb')))
    eruby.result(:css => css, :js => js, :document => @document, :html => @html)
  end

  def build_html
    doc = Nokogiri::HTML::DocumentFragment.parse('')
    Nokogiri::HTML::Builder.with(doc) do |h|
      add_html_element(h, @document.print_space)
    end

    doc.to_html
  end

  def add_html_element(builder, element)
    builder.send(html_tag_name(element), :class => html_class_name(element)){
      if element.children.any?
        element.children.each{|c| add_html_element(builder, c)}
      else
        builder.text " #{element.value} "
      end
    }
  end

  def html_tag_name(element)
    case element
    when Rubalto::String then 'span'
    else 'div'
    end
  end

  def html_class_name(element)
    element.name.gsub(/[A-Z]/){|s| '-' + s.downcase}.gsub(/^-/,'')
  end
end
