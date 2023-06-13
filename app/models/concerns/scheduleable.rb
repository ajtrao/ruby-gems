module Scheduleable
  extend ActiveSupport::Concern
  
  included do
  
  DAYS_OF_WEEK = [:monday, :tuesday, :wednesday, :thursday, :friday, :saturday, :sunday]
  
  #Json column to store days
  store_accessor :days, *DAYS_OF_WEEK
  
  #catch daysto/fromm booleans
  DAYS_OF_WEEK.each do |day|
    scope day, -> {where("days @> ?",{day=>true}.to_json)}
    define_method(:"#{day}="){ |value| super ActiveRecord::Type::Boolean.new.cast(value) }
    define_method(:"#{day}?"){ send(day) }
  end
  
  def active_days
    DAYS_OF_WEEK.select { |day| send(:"#{day}?") }.compact
  end
  

end  
end