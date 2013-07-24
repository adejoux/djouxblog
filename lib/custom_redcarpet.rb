class CustomRedcarpet < Redcarpet::Render::HTML
  include Sprockets::Rails::Helper
  include ActionView::Helpers::AssetTagHelper
  include ActionView::Helpers::UrlHelper


  def block_code(code, language)
    Pygments.highlight(code, lexer: language, options: {linespans: 'line'})
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
