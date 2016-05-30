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

  def all
    puts "-" * @title.length
    puts @title
    puts "-" * @title.length
    @items.each_with_index do |item, position|
      puts "#{position + 1}) #{item.details}"
    end
  end
end
