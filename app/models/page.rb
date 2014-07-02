class Page < ActiveRecord::Base
  require 'custom_redcarpet'

  has_paper_trail :on => [:update, :destroy], :ignore => [:publish_at, :tag_list]
  before_save :render_body
  belongs_to :user

  acts_as_taggable
  has_ancestry

  validates_presence_of :user_id, :content, :title, :category, :publish_at
  validates_uniqueness_of :title, :permalink

  has_many :comments, :dependent => :destroy

  scope :published, -> { where("publish_at <= ?", Time.now)}

  scope :wiki, -> {where(:category => "wiki")}
  scope :posts, -> {where(:category => "posts")}
  scope :infos, -> {where(:category => "infos")}

  # adding postgresql full text search
  include PgSearch
  pg_search_scope :search, against: [:title, :content],
    using: {tsearch: {dictionary: "english"}}

  def self.text_search(query)
    if query.present?
      search(query)
    else
      where(nil)
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
      strikethrough: true,
      disable_indented_code_blocks: true,
      superscript: true
    }
    redcarpet = Redcarpet::Markdown.new(renderer, options)
    self.rendered_body = redcarpet.render self.content
  end
end


