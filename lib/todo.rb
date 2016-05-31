class TodoItem
  include Listable
  attr_reader :description, :due, :priority

  def initialize(description, options={})
    @description = description
    @due = options[:due] ? Chronic.parse(options[:due]) : options[:due]
    @priority = options[:priority]
    check_priority if @priority != nil
  end

  def check_priority
    priorities = ["high", "medium", "low"]
    raise UdaciListErrors::InvalidPriorityValue if priorities.include?(@priority) == false
  end

  def details
    "Todo: " + format_description(@description) + "due: " +
    format_date(due: @due) +
    format_priority
  end
end
