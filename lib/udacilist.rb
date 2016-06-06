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
      if item.complete? == true
        puts "#{position + 1}) #{item.details}".colorize(:green)
      else
        puts "#{position + 1}) #{item.details}"
      end
    end
  end

  def list_title(title=@title)
    puts "-" * title.length
    puts title
    puts "-" * title.length
  end

  def all
    puts table
  end

  def filter(type)
    list_title = "#{@title} - #{type.capitalize}s"
    filtered_list = Array.new
    @items.each { |item| filtered_list << item if item.details.include?(type.capitalize) }
    if filtered_list.empty?
      raise UdaciListErrors::NoItemsExist
    else
      puts table(filtered_list, list_title)
    end
  end

  def get(item_number)
    @items[item_number - 1]
  end

  def table(list=@items, title=@title)
    chart = Terminal::Table.new :title => title do |row|
      list.each_with_index do |item, position|
        row << item.details
        row.add_separator
      end
      chart
    end
  end
end
