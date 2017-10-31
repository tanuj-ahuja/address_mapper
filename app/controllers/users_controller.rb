class UsersController < ApplicationController
  before_action :set_user, only: [:show, :edit, :update, :destroy]

  # GET /users
  # GET /users.json
  def index
    @users = User.all
    ref = Bigbertha::Ref.new( 'https://trackme-22c21.firebaseio.com/' )
    counted=ref.child(:count).read
    if counted!=0
     a_val=ref.child(:pids).read
     b_val=ref.child(:users).read
   

   
flag=-1


     
user_newest = User.order("created_at").last


counted=counted-1
  if user_newest.blank?||counted>user_newest.count
  	if user_newest.blank?
for i in 0..counted
     @str=a_val[i]
     long=b_val[@str]["latLng"]["longitude"]
     emai=b_val[@str]["email"]
     mobil=b_val[@str]["mobile"]
     na=b_val[@str]["name"]
     dep=b_val[@str]["department"]
     des=b_val[@str]["designation"]
     lat=b_val[@str]["latLng"]["latitude"]
     object = User.new(:latitude => lat, :longitude => long,:name => na,:department => dep,:title => des,:count => counted,:email => emai,:mobile => mobil,:push_id => @str)
     object.save

  end
      else
    u=user_newest.count+1
for i in u..counted
     @str=a_val[i]
     long=b_val[@str]["latLng"]["longitude"]
     emai=b_val[@str]["email"]
     mobil=b_val[@str]["mobile"]
     na=b_val[@str]["name"]
     dep=b_val[@str]["department"]
     des=b_val[@str]["designation"]
     lat=b_val[@str]["latLng"]["latitude"]
     object = User.new(:latitude => lat, :longitude => long,:name => na,:department => dep,:title => des,:count => counted,:email => emai,:mobile => mobil,:push_id => @str)
     object.save

  end
end
end

if user_newest.blank?
else
  for i in 0..counted
    @str=a_val[i]
    long=b_val[@str]["latLng"]["longitude"]
    lat=b_val[@str]["latLng"]["latitude"]
    @user=User.find_by_push_id(@str)
    @email=@user.email
    @user.update_attributes(:latitude => lat, :longitude => long)
    @user.save
  end

end 


 







     

    @hash = Gmaps4rails.build_markers(@users) do |user, marker|
  marker.lat user.latitude
  marker.lng user.longitude
  marker.infowindow user.name+","+user.department
  end
  end
end

  # GET /users/1
  # GET /users/1.json
  def show
     @user = User.find(params[:id])
     ref = Bigbertha::Ref.new('https://trackme-22c21.firebaseio.com/')
     flag_pic=ref.child("users").child(@user.push_id).child("flagPic").read
     if flag_pic==1
     count_pic=ref.child("users").child(@user.push_id).child(:countPic).read
     @pics_url=ref.child("users").child(@user.push_id).child(:picsurl).read
     count_pic=count_pic-1
   else
    @pics_url="Nothing"
         end

     count_status_report=ref.child("users").child(@user.push_id).child(:countStatusReport).read
     if count_status_report!=0
      @status_reports=ref.child("users").child(@user.push_id).child(:statusReport).read
     else
      @status_reports="Nothing"
     end

     count_meeting=ref.child("users").child(@user.push_id).child(:meetingcount).read
     if count_meeting!=0
      @meeting=ref.child("users").child(@user.push_id).child(:meetings).read
     else
      @meeting="Nothing"
    end 

    count_user_meetings=ref.child("users").child(@user.push_id).child(:userMC).read
    if count_user_meetings!=0
      @usermeeting=ref.child("users").child(@user.push_id).child(:userM).read
    else
     @usermeeting="Nothing"
     end




  end

  def confirm
    @date=params[:date]
    @name=params[:name]
    @id=params[:id]
    @activity=params[:activity]
    @time=params[:time]
    ref = Bigbertha::Ref.new( 'https://trackme-22c21.firebaseio.com/' )
    mee=ref.child("users").child(@id).child(:meetingcount).read
    nee=ref.child("users").child(@id).child(:userMC).read
    ref_for_meeting= Bigbertha::Ref.new( 'https://trackme-22c21.firebaseio.com/' ).child("users").child(@id).child("meetings")
    ref_for_meeting_count=Bigbertha::Ref.new( 'https://trackme-22c21.firebaseio.com/' ).child("users").child(@id).child("meetingcount")
    ref_for_meeting_user= Bigbertha::Ref.new( 'https://trackme-22c21.firebaseio.com/' ).child("users").child(@id).child("userM")
    d={
       clientn: @name,
          date: @date,
          activity: @activity,
          time: @time,
          flag: 0,
          start: 0,
          approve: true,
          location: 0,
          end: 0
    }
    values = {mee => d}
        ref_for_meeting.update(values)
        nee=nee-1
    values2={nee => d}
        ref_for_meeting_user.update(values2)
        mee=mee+1
        ref_for_meeting_count.set(mee)
    redirect_to :back
  end

  def submit
    @name=params[:Client_Name]
    @id=params[:id]
    @date=params[:Date]
    @activity=params[:Activity]
    @time=params[:Time]
        ref = Bigbertha::Ref.new( 'https://trackme-22c21.firebaseio.com/' )
        mee=ref.child("users").child(@id).child(:meetingcount).read
        ref_for_meeting= Bigbertha::Ref.new( 'https://trackme-22c21.firebaseio.com/' ).child("users").child(@id).child("meetings")
        ref_for_meeting_count=Bigbertha::Ref.new( 'https://trackme-22c21.firebaseio.com/' ).child("users").child(@id).child("meetingcount")
        data = Hash.new( "data" )
        d={
          clientn: @name,
          date: @date,
          activity: @activity,
          time: @time,
          flag: 0,
          start: 0,
          approve: true,
          location: 0,
          end: 0
        }
        values = {mee => d}
        ref_for_meeting.update(values)
        mee=mee+1
        ref_for_meeting_count.set(mee)

    redirect_to root_url
    end

  # GET /users/new
  def new
    
  end

  # GET /users/1/edit
  def edit
  end

  # POST /users
  # POST /users.json
  def create
   
  end

  # PATCH/PUT /users/1
  # PATCH/PUT /users/1.json
  def update
  
  end

  # DELETE /users/1
  # DELETE /users/1.json
  def destroy
   
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_user
      @user = User.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def user_params
      params.require(:user).permit(:latitude, :longitude, :name, :address, :title)
    end
end
