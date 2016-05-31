class UdaciList
  attr_reader :title, :items

  def initialize(options={})
    @title = options[:title] || 'Untitled List'
    @items = []
  end
  def add(type, description, options={})
    type = type.downcase
    check_type(type)
    @items.push TodoItem.new(description, options) if type == "todo"
    @items.push EventItem.new(description, options) if type == "event"
    @items.push LinkItem.new(description, options) if type == "link"
  end

  def check_type(type)
    item_type = ["todo", "event", "link"]
    raise UdaciListErrors::InvalidItemType if item_type.include?(type) == false
  end

  def delete(index)
    @items.delete_at(index - 1)
    raise UdaciListErrors::IndexExceedsListSize if index - 1 > @items.length
  end

  def display_items(list=@items)
    list.each_with_index do |item, position|
      puts "#{position + 1}) #{item.details}"
    end
  end

  def list_title(title=@title)
    puts "-" * title.length
    puts title
    puts "-" * title.length
  end

  def all
    list_title
    display_items
  end

  def filter(type)
    list_title("#{@title} - #{type.capitalize}s")
    display_items(@items.select { |item| item.details.include?(type.capitalize) })
      #.each_with_index { |item, index| puts "#{index + 1} #{item.details}" }
  end
end
