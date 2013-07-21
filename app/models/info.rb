class Info < ActiveRecord::Base
  attr_accessible :content, :name, :permalink
  before_save :render_body

  def to_param
    permalink
  end

  private
  def render_body
    renderer = CustomRedcarpet
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
