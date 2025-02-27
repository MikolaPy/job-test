class Transaction
  attr_reader :time, :info, :user, :amount, :log_string

  def initialize(log_string)
    @log_string = log_string
    @time, @info, @user, @amount = log_string.split(',')
  end

  def to_str
    log_string 
  end

  def <=>(other)
    amount.to_f <=> other.amount.to_f
  end
end
