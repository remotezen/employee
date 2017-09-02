class EventsController < ApplicationController
  before_action  :set_events 
  before_action :set_user, only: [:create]
  before_action :set_event, except: [:index, :new, :create]
  before_action :letin
  before_action :set_skill
  before_action :set_users
  load_and_authorize_resource
  include Eventable

 

  # GET /events
  # GET /events.json
  def index
    respond_to do |format|
      format.html
      format.pdf do
        render pdf: "index"
      end
     end
  end

  # GET /events/1
  # GET /events/1.json
  def show
  end

  # GET /events/new
  def new
    @event = Event.new
  end

  # GET /events/1/edit:
  def edit
  end

  # POST /events
  # POST /events.json
  def create
    
    bool = false 
    data = clean_date_time
    if data.size > 0
    #abort data.inspect
      Event.bulk_insert do |worker|
        data.each do |attrs|
          exit_plan if attrs[:start_time] >= attrs[:end_time]
          if worker.add(attrs)
           bool = true
          end
        end
      end
    else
      u = @user.events.build(event_params)
      respond_to do |format|
        if u.save?
          format.html { redirect_to root_url, notice: 'Event was successfully created.' }
          format.json { head :no_content }
        else
          format.html { render :new }
          format.json { render json: @event.errors, status: :unprocessable_entity }

        end
      end
    end
  end

  # PATCH/PUT /events/1
  # PATCH/PUT /events/1.json
  def update
    respond_to do |format|
      if @event.update(event_params)
        format.html { redirect_to @event, notice: 'Event was successfully updated.' }
        format.json { render :show, status: :ok, location: @event }
      else
        format.html { render :edit }
        format.json { render json: @event.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /events/1
  # DELETE /events/1.json
  def destroy
    @event.destroy
    respond_to do |format|
      format.html { redirect_to events_url, notice: 'Event was successfully destroyed.' }
      format.json { head :no_content }
    end
  end
  def exit_plan
    flash[:error] = "shift start can't be in the future of shift end"
    respond_to do |format|
      format.html { redirect_to new_event_url}  
     end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_user
      @user = User.find_by(name: params["event"]["name"])
    end
    def set_event
      @event = Event.find(params[:id])
    end
    def set_skill
      @skills = %w[supervisor juice line grill cashier baking coldpress]
    end

    def set_events
      @events = Event.top
    end

    



    # Never trust parameters from the scary internet, only allow the white list through.
    def set_users
      @users = User.all
    end
    
    def event_params
      params.require(:event).permit(:name, 
                    :job, :start_time, :end_time, :user_id)
    end
    

    
end
