module Roleable
  extend ActiveSupport::Concern
  
  included do
  
  ROLES = [:admin, :teacher, :student]
  
  #Json column to store roles
  store_accessor :roles, *ROLES
  
  #catch rolesto/fromm booleans
  ROLES.each do |role|
    scope role, -> {where("roles @> ?",{role=>true}.to_json)}
    define_method(:"#{role}="){ |value| super ActiveRecord::Type::Boolean.new.cast(value) }
    define_method(:"#{role}?"){ send(role) }
  end
  
  def active_roles
    ROLES.select { |role| send(:"#{role}?") }.compact
  end
  
  #validations
  validate :must_have_a_role, on: :update
  validate :must_have_an_admin
  
  private
  
  def must_have_an_admin
    if persisted? &&
      (User.where.not(id: id).pluck(:roles).count{ |h| h["admin"]==true } < 1) &&
      roles_changed? && admin==false
      errors.add(:base, "There should be atleast one admin")
    end
  
  end
  
  def must_have_a_role
    if roles.values.none?
      errors.add(:base, "user atleast have one role")
    end
  end
end  
end