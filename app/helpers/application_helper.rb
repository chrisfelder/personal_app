module ApplicationHelper
  
  class HTML < Redcarpet::Render::HTML
  # to use Rouge with Redcarpet
  include Rouge::Plugins::Redcarpet
  # overriding Redcarpet method
  # github.com/vmg/redcarpet/blob/master/lib/redcarpet/render_man.rb#L9
    def block_code(code, language)
      # highlight some code with a given language lexer 
      # and formatter: html or terminal256 
      # and block if you want to stream chunks
      # github.com/jayferd/rouge/blob/master/lib/rouge.rb#L17
      Rouge.highlight(code, language || 'text', 'html') 
      # watch out you need to provide 'text' as a default, 
      # because when you not provide language in Markdown 
      # you will get error: <RuntimeError: unknown lexer >
    end
  end

    def more_markdown(text)
      render_options = {
        filter_html:     true,
        hard_wrap:       true, 
        link_attributes: { rel: 'nofollow' }
      }
      renderer = HTML.new(render_options)

      extensions = {
        autolink:           true,
        fenced_code_blocks: true,
        lax_spacing:        true,
        no_intra_emphasis:  true,
        strikethrough:      true,
        superscript:        true
      }
      Redcarpet::Markdown.new(renderer, extensions).render(text).html_safe
    end

  def dat_markdown(text)
    options = {
      :autolink => true,
      :space_after_headers => true,
      :no_intra_emphasis => true,
      :hard_wrap => true,
      :filter_html => true,
      :fenced_code_blocks => true,
    }
    markdown = Redcarpet::Markdown.new(Redcarpet::Render::HTML, options)
    markdown.render(text).html_safe
  end
  
def wat_markdown(text)
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

  def markdown(text)
    @markdown ||= Redcarpet::Markdown.new(Redcarpet::Render::HTML, autolink: true, space_after_headers: true, fenced_code_blocks: true)
    @markdown.render(text)
  end
end
