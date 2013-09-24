# config/initializers/markdown.rb
 
module Haml::Filters::Markdown
 
  include Haml::Filters::Base
 
  require 'redcarpet'
 
  def render text
    markdown.render text
  end
 
  private
 
  def markdown
    @markdown ||= Redcarpet::Markdown.new Redcarpet::Render::HTML, {
      autolink:         true,
      fenced_code:      true,
      generate_toc:     true,
      gh_blockcode:     true,
      hard_wrap:        true,
      no_intraemphasis: true,
      strikethrough:    true,
      tables:           true,
      xhtml:            true
    }
  end
 
end
