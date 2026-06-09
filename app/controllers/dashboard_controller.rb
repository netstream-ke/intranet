class DashboardController < ApplicationController
  before_action :authenticate_user

  def index
    @tasks = Task.all

    @not_done = Task.not_done
    @ongoing = Task.ongoing
    @completed = Task.completed
  end
end
