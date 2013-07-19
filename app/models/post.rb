class Post < ActiveRecord::Base
  attr_accessible :author, :content, :title, :summary, :tag_list
  has_paper_trail :on => [:update, :destroy]
  before_save :render_body

  acts_as_taggable

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

  include Sprockets::Helpers::RailsHelper
  include Sprockets::Helpers::IsolatedHelper
  include ActionView::Helpers::UrlHelper

  def block_code(code, language)
    Pygments.highlight(code, lexer: language)
  end

  #code below from http://yet.another.linux-nerd.com/blog/how-to-extend-redcarpet-to-support-a-media-library-part-2
  def parse_media_link(link)
    puts link
    matches = link.match(/^([\w\d\.]+)(?:\|(\w+))?(?:\|([\w\s\d]+))?$/)
    {
        :id => matches[1],
        :size => (matches[2] || 'standard').to_sym,
        :class => matches[3]

    } if matches
  end

  def image(link, title, alt_text)
    size = nil
    klass = nil

    if nil != (parse = parse_media_link(link))
      media = Image.find_by_id(parse[:id]) || Image.find_by_name(parse[:id])
      if media
        #size = media.file_size(parse[:size])
        link = media.file_url(parse[:size]).to_s
        klass = parse[:class]
      end
    end

    image_tag(link, :title => title, :alt => alt_text, :class => klass)
  end

  def link(link, title, content)
    klass = nil

    if nil != (parse = parse_media_link(link))
      media = Image.find_by_id(parse[:id]) || Image.find_by_name(parse[:id])
      if media
        link = media.file_url.to_s
        klass = parse[:class]
      end
    end

    link_to(content, link, :title => title, :class => klass)
  end
end
