# Set the host name for URL creation
SitemapGenerator::Sitemap.default_host = "https://tradenaira.com/"
SitemapGenerator::Sitemap.create_index = true
SitemapGenerator::Sitemap.ping_search_engines

SitemapGenerator::Sitemap.create do
  # Put links creation logic here.
  #
  # The root path '/' and sitemap index file are added automatically for you.
  # Links are added to the Sitemap in the order they are specified.
  #
  # Usage: add(path, options={})
  #        (default options are used if you don't specify)
  #
  # Defaults: :priority => 0.5, :changefreq => 'weekly',
  #           :lastmod => Time.now, :host => default_host
  #
  # Examples:
  #
    add '/welcome'
    add '/pages'
    add '/pages/amlpolicy'
    add '/pages/about'
    add '/pages/cookie'
    add '/pages/fee'
    add '/pages/privacy'
    add '/pages/termsofuse'
    add '/pages/riskwarning'
    add '/pages/news'
    add '/pages/learn'
    add '/pages/tradeservices'
    add '/pages/contactus'
    add '/pages/support'
    add '/pages/send-money-to-nigeria'
    add '/pages/request-money'
    add '/pages/faq'
    add '/newproj'
    add '/pages/riskwarning'
    add '/pages/marketplace'
    add '/pages/projectfunding'
    add '/pages/subscribe'
    add '/signup'
    add '/markets/usdngn'
    add '/markets/ghsngn'
    add '/markets/usdghs'
    add '/markets/btcngn'
    add '/markets/btcusd'
    add '/markets/btcgbp'
    add '/markets/gbpghs'
    add '/markets/btcghs'
    add '/signin'
    add '/news'
    add '/news'
    add '/news'
    add '/news'
    add '/news'
    add '/news'
    add '/advertise'
    add 'money/req'
    add 'money/send'
    add 'money/req_success'
    add 'money/commission'
    add '/pages/subscribe'

    Blogo::Post.published.find_each do |post|
      add blogo_post_path(post)
  #     add article_path(article), :lastmod => article.updated_at
    end
     Blogo::Post.published.find_each do |tag_name|
      add blogo_tag_path(tag_name)
  #     add article_path(article), :lastmod => article.updated_at
    end

  #
  #   add articles_path, :priority => 0.7, :changefreq => 'daily'
  #
  # Add all articles:
  #
  #   Article.find_each do |article|
  #     add article_path(article), :lastmod => article.updated_at
  #   end
end
