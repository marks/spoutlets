module EntriesHelper

  def width_for(emotional_state)
    emotional_state.to_i * 20
  end

  def like_status_for(entry, user)
    return "No one else knows the feeling." if entry.likes == 0
    out = []
    if entry.likes == 1
      if user == entry.user
        out << "Another person knows"
      else
        out << "You know"
      end
    else#likes > 1
      if user == entry.user
        likes = entry.likes
      else
        likes = entry.likes - 1
        out << "You and"
      end
      out << "<b>#{likes}</b> others know"
    end
    out << "the feeling."
    out.join(" ").html_safe
  end

  def like_button_for(entry, user)
    if entry.liked?(user)
      like_or_unlike_action = unlike_entry_path(entry)
      css_class = "active"
      title = " un-been there"
    else
      like_or_unlike_action = like_entry_path(entry)
      css_class = ""
      title = " been there"
    end
    return link_to(content_tag(:i, nil, class: "icon-heart") + title, like_or_unlike_action, method: :put, remote: true, class: "btn btn-mini btn-inverse pull-right #{css_class}")
  end
end
