require 'json'

class ReaderController < ApplicationController
  def default
    id = get_stories[0]['id']
    
    redirect_to "/read/#{id}"
  end

  def index 
    if session[:user_id]
      @stories = get_user_stories
      story = @stories[params[:story]]
      puts @stories
      if story
        @id = params[:story]
        @title = story['title']
        @content = story['content']
        @synthesized = story['synthesized']
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
      return JSON.parse response
    rescue
      return nil
    end
  end
end
