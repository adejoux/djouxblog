class Post < ActiveRecord::Base
  attr_accessible :author, :content, :title, :summary
  has_paper_trail :on => [:update, :destroy]
  before_save :render_body

  validates_presence_of :author, :content, :title
  validates_uniqueness_of :title

  has_many :comments, :dependent => :destroy

  # adding postgresql full text search
  include PgSearch
  pg_search_scope :search, against: [:title, :content],
    using: {tsearch: {dictionary: "english"}}

  def self.text_search(query)
    if query.present?
      search(query)
    else
      scoped
    end
  end

  def to_param
    "#{id}-#{title}".parameterize
  end

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
