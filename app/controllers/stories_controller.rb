require 'html2text'

class StoriesController < ApplicationController
	$story_title
	$story_description
	

	def index
		if (session[:admin_id] != -1)
			redirect_to admin_path
		end
		@data = Story.all

		if session[:change_story_id]
			story = @data.find_by(id: session[:change_story_id])

			$story_title = story[:title]
			$story_description = story[:content]

			s = $story_description

			$synthesized_version = ""
		else
			$story_title = ""
			$story_description = ""
			$synthesized_version = ""
		end

	end

	def change
		story_id = params[:id]

		session[:change_story_id] = story_id
		redirect_to stories_path
	end



	def submit

		if session[:change_story_id]
			@story = Story.find_by(id: session[:change_story_id])	
		else
			@story = Story.new()
		end

		@story[:title] = params[:title]
		@story[:content] = params[:content]

		

		if @story.save
			session.delete(:change_story_id)

			s = params[:content]
			s = Html2Text.convert(s)

			split_text_endl_array = ['.',',',':',";",'!','?','-']
			
			split_text_endl_array.each do  |ch|
				#p ch
				s = s.gsub(ch,"\n")
			end
			s = s.gsub('"',"")

			p "-----------------"
			p s
			p "story-#{@story[:id]}"
			p "-------------------"

			req = @@Resource["story-#{@story[:id]}"]
			
			req.put({"title": @story[:title], "content": s}.to_json, {content_type: :json, accept: :json})

			redirect_to stories_path
		else
			redirect_to stories_path
		end


	end

	private 
  	def story_params
    	params.require(:story).permit(:title, :content)
  	end
end
