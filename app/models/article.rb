class Article < ActiveRecord::Base
  attr_accessible :author, :content, :title
  has_paper_trail :on => [:update, :destroy]
  before_save :render_body

  private
  def render_body
    renderer = Redcarpet::Render::HTML.new
    extensions = {fenced_code_blocks: true}
    redcarpet = Redcarpet::Markdown.new(renderer, extensions)
    self.rendered_body = redcarpet.render self.content
  end
end
