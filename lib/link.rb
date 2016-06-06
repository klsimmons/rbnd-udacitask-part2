class LinkItem
  include Listable
  attr_reader :description, :site_name

  def initialize(url, options={})
    @description = url
    @site_name = options[:site_name]
    @complete = false
    @type = "Link"
  end

  def format_name
    @site_name ? @site_name : "N/A"
  end

  def details
    details = [@type, @description, "Site Name: " + format_name, nil, nil]
  end
end
