class MessagesController < ApplicationController 
	before_filter :authenticate_user!
	before_filter :update_last_seen

	def index 
		if params[:user_id]
			partner_id = params[:user_id]
			@partner = User.find(partner_id)
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

			@conversations.sort_by! {|convo| convo[-1].id }.reverse!
			@inbox = @conversations.map do |convo| 
				last_message_in = convo.rindex { |message| message.recipient_id == current_user.id } 
				convo[0..last_message_in]
			end
			@awaiting_reply = @conversations.map do |convo| 
				last_message_in = convo.rindex { |message| message.recipient_id == current_user.id } 
				convo[(last_message_in + 1)..-1]
			end.select { |convo| !convo.empty? }
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