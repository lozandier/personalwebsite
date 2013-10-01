class CustomRender < Redcarpet::Render::HTML
  include Redcarpet::Render::SmartyPants 

  def block_code(code, language)
    Pygments.highlight(code, lexer: language)
  end
end

def markdown 
  @markdown ||= Redcarpet::Markdown.new CustomRender, {
    autolink:         true,
    fenced_code:      true,
    generate_toc:     true,
    gh_blockcode:     true,
    hard_wrap:        true,
    no_intraemphasis: true,
    strikethrough:    true,
    tables:           true,
    superscript:      true
  }
end

