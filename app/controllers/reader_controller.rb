require 'json'

class ReaderController < ApplicationController
  def default
    id = Story.first[:id]
    
    redirect_to "/read/#{id}"
  end

  def index 
    if session[:user_id]
      @stories = get_user_stories
      story = @stories[params[:story]]
      if story
        @id = params[:story]
        @title = story['title']
        @content = Story.find_by(id: @id)[:content]
        @status = story['status']
      else
        default
      end
    else
      redirect_to login_path
    end
  end

  def synthesize
    if session[:user_id]
      puts synthesize_story params[:story]
      redirect_to read_path
    else
      redirect_to login_path
    end
  end

  def audio
    if session[:user_id]
      storyid = params[:story]
      audio = synthesize_story storyid
      render json: audio.body, headers: audio.headers
    end
  end

  def delete
    if session[:user_id]
      storyid = params[:story]
      response = @@Resource["user-#{session[:user_id]}/story-#{storyid}"].delete
      redirect_to read_path
    else
      redirect_to login_path
    end
  end

  private
  def story_resource(storyid)
    return @@Resource["story-#{storyid}"]
  end

  def get_story(storyid)
    begin
      response = story_resource(storyid).get
      return JSON.parse response
    rescue
      return nil
    end
  end

  def get_stories
    begin 
      response = @@Resource["stories"].get
      return JSON.parse response
    rescue
      return nil
    end
  end

  def get_user_stories
    begin
      response = @@Resource["user-#{session[:user_id]}/stories"].get
      return JSON.parse response
    rescue
      return nil
    end
  end

  def synthesize_story(storyid)
      begin
      response = @@Resource["user-#{session[:user_id]}/story-#{storyid}"].get
      return response
    rescue
      return nil
    end
  end
end
