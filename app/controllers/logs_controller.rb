class LogsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_log, only: %i[ show edit update destroy ]

  def index
    @logs = Log.where(user: current_user).order(date: :desc)
  end

  def show
  end

  def new
    @log = Log.new
  end

  def create
    @log = Log.new(log_params)
    @log.user = current_user
    if @log.save
      redirect_to @log, notice: "Log Created!"
    else
      render :new, status: :unprocessable_entity
    end
  end

  def edit
  end

  def update
    if @log.update(log_params)
      redirect_to @log, notice: "Log Updated!"
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @log.destroy
    redirect_to logs_path, notice: "Log Deleted"
  end

  private

  def set_log
    @log = Log.find_by(id: params[:id], user: current_user)
    redirect_to root_path,  warning: "can't find log with that id" if @log.nil?
  end

  def log_params
    params.expect(log: [ :date, :trigger, :bad_thought, :emotion, :good_thought ])
  end
end
