class MessagesController < ApplicationController 
	before_filter :authenticate_user!

	def index 
		if params[:user_id]
			partner_id = params[:user_id]

			@conversation = Message.where('(sender_id = ? AND recipient_id = ?) OR (sender_id = ? AND recipient_id = ?)', current_user.id, partner_id , partner_id , current_user.id).order('id DESC')
		else
			conversation_partner_ids = current_user.conversation_partners.map { |partner| partner.id }
			
			@conversations = []
			
			conversation_partner_ids.each do |cpi|
				@conversations << Message.where('(sender_id = ? AND recipient_id = ?) OR (sender_id = ? AND recipient_id = ?)', current_user.id, cpi, cpi, current_user.id).order('id DESC')
			end

			@conversations.each do |convo|
				convo.sort_by! {|mess| mess.id }
			end
			p @conversations
			@conversations
		end
	end


	def create
		@message = Message.new(params[:message])
		@message.sender_id = current_user.id

		@message.save! 

		if request.xhr?
			render partial: "message", locals: {message: @message}
		else
			redirect_to messages_url
		end
	end

end 