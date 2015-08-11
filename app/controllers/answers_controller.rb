class AnswersController < ApplicationController
	before_action :authenticate_user! , except: [:index]
	before_action :set_answer , except: [:create , :new , :index]

	def index
		@answers = Answer.all
	end

	def create
		@answer = Answer.new(answer_params)
		@answer.user = current_user
		if @answer.save
		  redirect_to question_path(@answer.question_id) , notice: "cevabiniz basari ile kaydedildi."
		else
		  redirect_to question_path(@answer.question_id) , alert: "Bir hata olustu"
		end
	end

	def edit
	end

	def update
		redirect_to question_path(@answer.question_id) , alert: "yetkisiz erisim" unless permitted
		if @answer.update(answer_params)
			redirect_to question_path(@answer.question_id)
		else
			render 'edit'
		end
		
	end

	def destroy
		redirect_to question_path(@answer.question_id) , alert: "yetkisiz erisim" unless permitted
		if @answer.destroy
			flash[:success] = "Cevap Silindi"
			redirect_to question_path(@answer.question_id)
		else
			flash[:success] = "Cevap Silinemedi"
		end
	end

	def upvote
		@answer = Answer.find(params[:id])
		@answer.upvote_by current_user
		if reputation(@answer) > 2
			@answer.user.roles.delete(User.first.roles.last)
			@answer.user.roles << Role.find_by_role("Moderatör")
		elsif reputation(@answer) > 0
			@answer.user.roles.delete(User.first.roles.last)
			@answer.user.roles << Role.find_by_role("Tecrubeli Kullanıcı")
		else
			@answer.user.roles.delete(User.first.roles.last)  
			@answer.user.roles << Role.find_by_role("Çaylak")
		end 	 
		redirect_to question_path(@answer.question)
	end

	def downvote
		@answer = Answer.find(params[:id])
		@answer.downvote_by current_user
		if reputation(@answer) > 2
			@answer.user.roles.delete(User.first.roles.last) 
			@answer.user.roles << Role.find_by_role("Moderatör")
		elsif reputation(@answer) > 0
			@answer.user.roles.delete(User.first.roles.last)  
			@answer.user.roles << Role.find_by_role("Tecrubeli Kullanıcı")
		else
			@answer.user.roles.delete(User.first.roles.last)  
			@answer.user.roles << Role.find_by_role("Çaylak")
		end 	 
		redirect_to question_path(@answer.question)	 
	end

	private

	def set_answer
		@answer =Answer.find(params[:id])
	end

	def answer_params
		params.require(:answer).permit(:content , :question_id)
	end
	def permitted
		current_user == @answer.user || current_user.roles.first == Role.first
	end

	def reputation(a)
		total = 0 
 		a.user.answers.each do |x| 
			total += x.votes_for.up.count
		end
		total 
    end 
end
