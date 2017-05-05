require "pry"

class Transfer

  attr_accessor :sender, :receiver, :status, :amount

  def initialize(sender, receiver, status="pending", amount)
    @sender, @receiver, @status, @amount = sender, receiver, status, amount
  end

  def valid?
    @sender.valid? && @receiver.valid? && @amount <= @sender.balance ? true : false
  end

  def execute_transaction
    if @status != "complete"
      if valid?
        @sender.deposit(@amount*-1)
        @receiver.deposit(@amount)
        @status = "complete"
      else
        @status = "rejected"
        "Transaction rejected. Please check your account balance."
      end
    end
  end

  def reverse_transfer
    if @status == "complete"
      @sender.deposit(@amount)
      @receiver.deposit(@amount*-1)
      @status = "reversed"
    end
  end

end
