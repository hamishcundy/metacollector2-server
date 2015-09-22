module ParticipantsHelper

  def get_type_string(type)
    if type == 1 
      return "Incoming"
    elsif type == 2 
      return "Outgoing"
    elsif type == 3 
      return "Missed"
    elsif type == 4 
      return "Voicemail"
    end
  end

  def get_sms_string(type)
    if type == 1 
      return "Incoming"
    elsif type == 2 
      return "Outgoing"
    end
  end

  def get_label(type)
    if type == CallEvent
      return "Call"
    elsif type == SmsEvent
      return "SMS"
    elsif type == LocationUpdateEvent
      return "Location"
    elsif type == FacebookMessageEvent
      return "Facebook message"
    end
  end
end
