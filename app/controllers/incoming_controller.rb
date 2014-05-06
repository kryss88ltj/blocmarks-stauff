class IncomingController < ApplicationController
   # http://stackoverflow.com/questions/1177863/how-do-i-ignore-the-authenticity-token-for-specific-actions-in-rails
  skip_before_filter :verify_authenticity_token, only: [:create]

  def create
    # Take a look at these in your server logs
    # to get a sense of what you're dealing with.

    if request.method == 'POST':
         sender    = request.POST.get('sender')
         # recipient = request.POST.get('recipient')
         subject   = request.POST.get('subject', '')

         body_plain = request.POST.get('body-plain', '')

    
    return HttpResponse('OK')
    @topic = Topic.where(title: "E-mail").first_or_create
    @user = User.where(email: sender)
    unless @user.nil?
      @user.posts.create(url: body_plain, topic_id: @topic.id)
    end  
    # You put the message-splitting and business
    # magic here. 

    # Assuming all went well. 
    # head 200
  end


end
