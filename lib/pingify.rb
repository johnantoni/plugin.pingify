module Pingify

  # only needed for pingomatic + sitemap
  include ActionController::UrlWriter

  def send_pingomatic(uri)
    # ping pingomatic
    if ENV['RAILS_ENV'] == 'production'
      require 'net/http'
      require 'uri'

      enc_uri = URI.escape(uri)

      ping_url = "pingomatic.com"
      ping_vars = "/ping/?title=&blogurl=#{enc_uri}&rssurl=http%3A%2F%2F&chk_weblogscom=on&chk_blogs=on&chk_technorati=on&chk_feedburner=on&chk_syndic8=on&chk_newsgator=on&chk_myyahoo=on&chk_pubsubcom=on&chk_blogdigger=on&chk_blogstreet=on&chk_moreover=on&chk_weblogalot=on&chk_icerocket=on&chk_newsisfree=on&chk_topicexchange=on"

      Net::HTTP.get(ping_url, ping_vars)
    end
  end

  def send_sitemap(uri)
    # ping sitemap
    if ENV['RAILS_ENV'] == 'production'
      require 'net/http'
      require 'uri'

      uri = uri+'/sitemap.xml'

      enc_uri = URI.escape(uri)
      default_url_options[:host] = enc_uri

      Net::HTTP.get('www.google.com' , '/ping?sitemap=' + enc_uri)
    end
  end

  def send_ping(uri, port=80)
    # ping uri
    require 'net/ping/external'
    return uri.blank? ? false : Net::Ping::External.new(uri,port).ping?
  end

end

