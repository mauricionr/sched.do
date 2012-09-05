require 'spec_helper'

describe UserMailer do
  it 'uses the correct reply-to address' do
    vote = build_stubbed(:vote)

    mail = UserMailer.vote_confirmation(vote)

    mail.from.should == ['no-reply@sched.do']
  end
end

describe UserMailer, 'vote_confirmation' do
  it 'sends the email to the correct recipient' do
    vote = build_stubbed(:vote)

    mail = UserMailer.vote_confirmation(vote)

    mail.to.should == [vote.voter.email]
  end

  it 'sends the email with the correct subject' do
    vote = build_stubbed(:vote)
    user_name = vote.voter.name

    mail = UserMailer.vote_confirmation(vote)

    mail.subject.should == "#{user_name}, thanks for voting with Sched.do"
  end

  it 'sends the email with the correct body' do
    vote = build_stubbed(:vote)
    event = vote.event
    user_name = event.user.name
    event_name = vote.event.name

    mail = UserMailer.vote_confirmation(vote)

    mail.body.encoded.should include(user_name)
    mail.body.encoded.should include(event_name)
  end
end

describe UserMailer, 'invitation' do
  it 'sends the email to the correct recipient' do
    guest = build_stubbed(:guest)
    event = build_stubbed(:event)

    mail = UserMailer.invitation(guest, event)

    mail.to.should == [guest.email]
  end

  it 'sends the email with the correct subject' do
    guest = build_stubbed(:guest)
    event = build_stubbed(:event)

    mail = UserMailer.invitation(guest, event)

    mail.subject.should == 'You have been invited to a Sched.do event!'
  end

  it 'sends the email with the correct subject' do
    guest = build_stubbed(:guest)
    event = build_stubbed(:event)

    mail = UserMailer.invitation(guest, event)

    mail.body.encoded.should include (guest.name)
    mail.body.encoded.should include (event.name)
    mail.body.encoded.should include (event.name)
  end
end

describe UserMailer::Preview, 'vote_confirmation' do
  it 'sends the email to the correct recipient' do
    vote = create(:vote)
    UserMailer.vote_confirmation(vote)

    mail = UserMailer::Preview.new.vote_confirmation

    mail.to.should == [vote.voter.email]
  end

  it 'sends the email with the correct subject' do
    vote = create(:vote)
    user_name = vote.voter.name
    UserMailer.vote_confirmation(vote)

    mail = UserMailer::Preview.new.vote_confirmation

    mail.subject.should == "#{user_name}, thanks for voting with Sched.do"
  end

  it 'sends the email with the correct body' do
    vote = create(:vote)
    event = vote.event
    user_name = event.user.name
    event_name = vote.event.name
    UserMailer.vote_confirmation(vote)

    mail = UserMailer::Preview.new.vote_confirmation

    mail.body.encoded.should include(user_name)
    mail.body.encoded.should include(event_name)
  end
end

describe UserMailer::Preview, 'invitation' do
  it 'sends the email to the correct recipient' do
    guest = create(:guest)
    event = create(:event)
    UserMailer.invitation(guest, event)

    mail = UserMailer::Preview.new.invitation

    mail.to.should == [guest.email]
  end

  it 'sends the email with the correct subject' do
    guest = create(:guest)
    event = create(:event)
    UserMailer.invitation(guest, event)

    mail = UserMailer::Preview.new.invitation

    mail.subject.should == 'You have been invited to a Sched.do event!'
  end

  it 'sends the email with the correct subject' do
    guest = create(:guest)
    event = create(:event)
    UserMailer.invitation(guest, event)

    mail = UserMailer::Preview.new.invitation

    mail.body.encoded.should include (guest.name)
    mail.body.encoded.should include (event.name)
    mail.body.encoded.should include (event.name)
  end
end
