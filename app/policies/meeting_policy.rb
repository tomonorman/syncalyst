class MeetingPolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      scope.all
    end
  end

  def show?
    true
  end

  def new?
    true
  end

  def create?
    user
  end

  def start?
    record.user == user
  end

  def finish?
    record.user == user
  end
end
