class CustomRender < Redcarpet::Render::HTML
  include Redcarpet::Render::SmartyPants 

  def block_code(code, language)
    Pygments.highlight(code, lexer: language)
    Pygments.css(:style => "monokai")

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
    disable_indented_code_blocks: true, 
    superscript:      true
  }
end

