module Pingify
  module Notify
    include ActionController::UrlWriter

    require 'net/http'
    require 'uri'

    def notify_pingomatic(uri)
      if (ENV['RAILS_ENV']=='production') && !uri.blank?
        ping_vars = "/ping/?title=&blogurl=#{URI.escape(uri)}&rssurl=http%3A%2F%2F&chk_weblogscom=on&chk_blogs=on&chk_technorati=on&chk_feedburner=on&chk_syndic8=on&chk_newsgator=on&chk_myyahoo=on&chk_pubsubcom=on&chk_blogdigger=on&chk_blogstreet=on&chk_moreover=on&chk_weblogalot=on&chk_icerocket=on&chk_newsisfree=on&chk_topicexchange=on"
        Net::HTTP.get("pingomatic.com", ping_vars)
      end
    end

    def notify_sitemap(uri)
      if (ENV['RAILS_ENV']=='production') && !uri.blank?
        enc_uri = URI.escape(uri+'/sitemap.xml')
        default_url_options[:host] = enc_uri
        Net::HTTP.get('www.google.com' , '/ping?sitemap=' + enc_uri)
      end
    end

    def ping(uri, port=80)
      require 'net/ping/external'
      return uri.blank? ? nil : Net::Ping::External.new(uri,port).ping?
    end

  end
end

