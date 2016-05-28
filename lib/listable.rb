module Listable

  def format_description(description)
    "#{description}".ljust(30)
  end

  def format_date(start_date, end_date=nil)
    dates = @start_date.strftime("%D") if @start_date
    dates << " -- " + @end_date.strftime("%D") if @end_date
    dates = "N/A" if !dates
    @due ? @due.strftime("%D") : "No due date"
    return dates
  end

  def format_priority
    value = " ⇧" if @priority == "high"
    value = " ⇨" if @priority == "medium"
    value = " ⇩" if @priority == "low"
    value = "" if !@priority
    return value
  end
end
