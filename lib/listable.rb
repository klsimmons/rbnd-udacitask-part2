module Listable

  def format_description(description)
    "#{description}".ljust(30)
  end

  def format_date(options = {})
    if @type == "Event"
      dates = options[:start_date].strftime("%D") if options[:start_date]
      dates << " --\n " + options[:end_date].strftime("%D") if options[:end_date]
      dates = "N/A" if !dates
      return dates
    else
      options[:due] ? options[:due].strftime("%D") : "No due date"
    end
  end

  def format_priority
    value = " ⇧".colorize(:red) if @priority == "high"
    value = " ⇨".colorize(:yellow) if @priority == "medium"
    value = " ⇩".colorize(:green) if @priority == "low"
    value = "" if !@priority
    return value
  end

  def change_priority(new_priority)
    @priority = new_priority
  end

  def format_type
    "#{@type}: "
  end

  def complete?
    @complete
  end

  def mark_complete
    @complete = true
  end

  def format_complete
    "Done" if complete?
  end
end
