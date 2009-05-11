module HatchetHarry
  module Pingify

    include ActionController::UrlWriter

    def send_pingomatic(uri)
      if ENV['RAILS_ENV'] == 'production'
        enc_uri = URI.escape(uri)

        #ping pingomatic
        ping_url = "pingomatic.com"
        ping_vars = "/ping/?title=&blogurl=#{enc_uri}&rssurl=http%3A%2F%2F&chk_weblogscom=on&chk_blogs=on&chk_technorati=on&chk_feedburner=on&chk_syndic8=on&chk_newsgator=on&chk_myyahoo=on&chk_pubsubcom=on&chk_blogdigger=on&chk_blogstreet=on&chk_moreover=on&chk_weblogalot=on&chk_icerocket=on&chk_newsisfree=on&chk_topicexchange=on"

        Net::HTTP.get(ping_url, ping_vars)
      end
    end

    def send_sitemap(uri)
      if ENV['RAILS_ENV'] == 'production'
        uri = uri+'/sitemap.xml'

        enc_uri = URI.escape(uri)
        default_url_options[:host] = enc_uri

        #ping sitemap
        Net::HTTP.get('www.google.com' , '/ping?sitemap=' + enc_uri)
      end
    end

  end
end

