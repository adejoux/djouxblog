class Page < ActiveRecord::Base
  attr_accessible :author, :content, :title, :summary, :tag_list, :published, :category, :parent_id
  has_paper_trail :on => [:update, :destroy], :skip => [:published, :tag_list]
  before_save :render_body

  acts_as_taggable
  has_ancestry

  validates_presence_of :author, :content, :title, :category
  validates_uniqueness_of :title, :permalink

  has_many :comments, :dependent => :destroy

  scope :published, where(:published => true)

  scope :wiki, where(:category => "wiki")
  scope :posts, where(:category => "posts")

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


