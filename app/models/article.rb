class Article < ActiveRecord::Base
  attr_accessible :author, :content, :title
  has_paper_trail :on => [:update, :destroy]
  before_save :render_body

  private
  def render_body
    renderer = PygmentizeHTML
    options = {
      nowrap: true,
      autolink: true,
      no_intra_emphasis: true,
      fenced_code_blocks: true,
      lax_html_blocks: true,
      strikethrough: true,
      superscript: true
    }
    redcarpet = Redcarpet::Markdown.new(renderer, options)
    self.rendered_body = redcarpet.render self.content
  end
end

class PygmentizeHTML < Redcarpet::Render::HTML
  def block_code(code, language)
    Pygments.highlight(code, lexer: language)
  end
end
