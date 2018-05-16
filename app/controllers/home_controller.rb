class HomeController < ApplicationController
  def index
    @users = User.all
  end
  def edit_exercise 
    @pid = params[:format]
    @problem = Problem.find_by_id(@pid.to_i)

    @source = if file_ = params[:file] and file = file_[:name]
                File.read(file.path)
              elsif source_ = params[:source]
                source_["ex_#{@pid}"].gsub(/\r/, '')
              else
                ""
              end
  end
  def final_exercise 
    @st, @ed = params[:format].split("_")
    @problems = Problem.all[@st.to_i..@ed.to_i]
  end
  def confirm
    @source = params[:source]
    @comment = params[:comment]
    @result = params[:result]

    @pid = params[:format]
    @problem = Problem.find_by_id(@pid.to_i)
    if user = params[:user] 
      @user = User.find_by_id(user[:id])
    end
    #p @source
    
    require 'tempfile'
    target_file = Tempfile.open("your_script") do |fp|
      fp.puts @source["ex_#{@pid}"].gsub(/\r/, '')
      fp
    end
    answer_src = File.join("answers", @problem.answer_src)
    answer_out = File.join("answers", @problem.answer_out)
    arguments = @problem.arguments
    command = "public/check_python_script.rb #{answer_src} #{answer_out} #{target_file.path} #{arguments}"
    puts command
    result = `#{command}`
    @total_points = if total_points_match = result.match(/Total points:\s*(\d+)/)
                      total_points_match[1]
                    end
    @result["ex_#{@pid}"] = result
  end
  def final_confirm
    @source = params[:source]
    @comment = params[:comment]
    @result = params[:result]
    @pid = params[:format]
    @problem = Problem.find_by_id(@pid.to_i)

    if user = params[:user] 
      @user = User.find_by_id(user[:id])
    end
  end
  def register
    @source = params[:source]
    @comment = params[:comment]
    @result = params[:result]
    @pid = params[:format]
    @problem = Problem.find_by_id(@pid.to_i)
    @exid = "ex_#{@pid}"

    if @user = params[:user]
      if user = User.find_by_name(@user[:name]) and user.password == @user[:password]
        user.name = @user[:name] 
        user.password = @user[:password]
        source = @source[@exid]
        user.sources = {} unless user.sources
        user.results = {} unless user.results
        user.comments = {} unless user.comments
        user.sources[@exid] = source unless source.to_s.empty?
        user.results[@exid] = @result[@exid] unless @result[@exid].to_s.empty?
        user.comments[@exid] = @comment[@exid] unless @comment[@exid].to_s.empty?
        unless source.to_s.empty?
          log = Log.new
          log.user = user.name
          log.problem = @exid
          log.save
        end

        user.save
        @check = true
      elsif user = User.find_by_name(@user[:name]) and user.password != @user[:password]
        @check = false
      elsif @user[:password].to_s.empty?
        @check = false
        @input_password = true
      else
        user = User.new
        user.name = @user[:name] 
        user.password = @user[:password]
        source = @source[@exid]
        user.sources = {} unless user.sources
        user.results = {} unless user.results
        user.comments = {} unless user.comments
        user.sources[@exid] = source unless source.to_s.empty?
        user.results[@exid] = @result[@exid] unless @result[@exid].to_s.empty?
        user.comments[@exid] = @comment[@exid] unless @comment[@exid].to_s.empty?
        unless source.to_s.empty?
          log = Log.new
          log.user = user.name
          log.problem = @exid
          log.save
        end
        user.save
        @check = true
      end
    end
  end
  def edit
    #@user = params[:user]
    if user = params[:user] and 
      @user = User.find_by_id(user[:id]) and 
      password = user[:password] and
      @user.password == password
      @check = true 
      @problems = Problem.all
      @submitted = @user.sources.values.select{|s| !s.to_s.empty?}.length
    else
      @check = false
    end
  end
  def summary
    @users = User.all
    @user_sum = {}
    @q_sum = {}
    @problems = Problem.all
    @users.each do |user|
      @user_sum[user] = 0
      @problems.each do |problem|
        exid = "ex_#{problem.id}"
        @q_sum[exid] ||= 0
        unless user.sources[exid].to_s.empty?
          @user_sum[user] += 1
          @q_sum[exid] += 1 
        end
      end
    end
    @logs1 = {}
    user_count = 0
    Log.all.each do |log|
      if Time.new(2018,05,18,12) < log.updated_at and log.updated_at < Time.new(2018,05,18,20)
        unless @logs1[log.user]
          user_count += 1
        end
        user_name = "user_#{user_count}"
        @logs1[log.user] ||= {:submission => 0, :name=>user_name, :data=>{}}
        @logs1[log.user][:submission] += 1
        @logs1[log.user][:data][log.updated_at] = @logs1[log.user][:submission]
      end
    end
    @logs2 = {}
    user_count = 0
    Log.all.each do |log|
      if Time.new(2018,05,19,8) < log.updated_at and log.updated_at < Time.new(2018,05,19,20)
        unless @logs2[log.user]
          user_count += 1
        end
        user_name = "user_#{user_count}"
        @logs2[log.user] ||= {:submission => 0, :name=>user_name, :data=>{}}
        @logs2[log.user][:submission] += 1
        @logs2[log.user][:data][log.updated_at] = @logs2[log.user][:submission]
      end
    end
    @logs3 = {}
    user_count = 0
    Log.all.each do |log|
      if Time.new(2018,05,22,12) < log.updated_at and log.updated_at < Time.new(2018,05,22,20)
        unless @logs3[log.user]
          user_count += 1
        end
        user_name = "user_#{user_count}"
        @logs3[log.user] ||= {:submission => 0, :name=>user_name, :data=>{}}
        @logs3[log.user][:submission] += 1
        @logs3[log.user][:data][log.updated_at] = @logs3[log.user][:submission]
      end
    end

    @submissions = {
      '0-5' => 0,
      '6-10' => 0,
      '11-15' => 0,
      '16-20' => 0,
      '21-' => 0
    }
    @users.each do |user|
      subs = user.sources.keys.select{|s| s =~ /ex_/}.length
      if subs <= 5
        @submissions['0-5'] += 1
      elsif subs <= 10
        @submissions['6-10'] += 1
      elsif subs <= 15
        @submissions['11-15'] += 1
      elsif subs <= 20
        @submissions['16-20'] += 1
      else
        @submissions['21-'] += 1
      end
    end
  end
  def comments
    @users = User.all
    @problems = Problem.all
    @coms = {}
    @users.shuffle.each do |user|
      user.comments.each do |exid, value|
        @coms[exid] ||= ""
        @coms[exid] << value
        @coms[exid] << "<br>"
      end
    end
  end

  def test
    open("test.dat", "w") do |out|
      User.all.each do |user|
        out.puts user.name
      end
    end

    render :text => "output"
  end
end
