module ApplicationHelper
  def dat_markdown(text)
    options = {
      :autolink => true,
      :space_after_headers => true,
      :no_intra_emphasis => true,
      :hard_wrap => true,
      :filter_html => true,
      :fenced_code_blocks => true
    }
    markdown = Redcarpet::Markdown.new(Redcarpet::Render::HTML, options)
    markdown.render(text).html_safe
  end
  
def markdown(text)
  erbified = ERB.new(text.html_safe).result(binding)
  options = {
      :hard_wrap => true, 
      :filter_html => true, 
      :autolink => true, 
      :no_intraemphasis => true,
      :prettify => true
    }
  #Redcarpet.new(erbified, *options).to_html.html_safe
  markdown = Redcarpet::Markdown.new(Redcarpet::Render::HTML, options)
  markdown.render(erbified).html_safe
end
end
