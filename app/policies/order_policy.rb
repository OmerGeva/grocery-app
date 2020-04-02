class OrderPolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      scope.all
    end
  end

  def show?
    user.customer
  end

  def create?
    user.customer
  end
  def update?
    user.customer
  end
end
